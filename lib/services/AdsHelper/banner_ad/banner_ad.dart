import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../utils/ad_config.dart';
import '../utils/constants.dart';
import '../utils/utils.dart';

class BannerAdView extends StatefulWidget {
  const BannerAdView({Key? key}) : super(key: key);

  @override
  State<BannerAdView> createState() => _BannerAdViewState();
}

class _BannerAdViewState extends State<BannerAdView> {
  BannerAd? _anchoredBanner;
  bool _loadingAnchoredBanner = false;

  @override
  void dispose() {
    _anchoredBanner?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return (AdConfig.isAdFeatureEnable)
        ? ((AdConfig.isShowFacebookBannerAds && (AdConfig.facebookBannerAdUnitId.isNotEmpty)) || Constant.isFailedAdMobBannerAd)
            ? Container(
                // height: Constant.bannerAdHeight,
                alignment: const Alignment(0.5, 1),
                child: FacebookBannerAd(
                  placementId: AdConfig.facebookBannerAdUnitId,
                  bannerSize: BannerSize.STANDARD,
                  listener: (result, value) {
                    switch (result) {
                      case BannerAdResult.ERROR:
                        printLog("Facebook Banner Ad Error: $value");
                        break;
                      case BannerAdResult.LOADED:
                        printLog("Facebook Banner Ad LOADED: $value");
                        break;
                      case BannerAdResult.CLICKED:
                        printLog("Facebook Banner Ad CLICKED: $value");
                        break;
                      case BannerAdResult.LOGGING_IMPRESSION:
                        printLog("Facebook Banner Ad LOGGING_IMPRESSION: $value");
                        break;
                    }
                  },
                ),
              )
            : Builder(
                builder: (BuildContext context) {
                  if (!_loadingAnchoredBanner) {
                    _loadingAnchoredBanner = true;
                    _createAnchoredBanner(context);
                  }
                  return Container(
                    height: _anchoredBanner == null ? 0 : Constant.bannerAdHeight,
                    alignment: Alignment.center,
                    child: _anchoredBanner == null
                        ? const SizedBox()
                        : AdWidget(
                            ad: _anchoredBanner!,
                          ),
                  );
                },
              )
        : const SizedBox();
  }

  Future<void> _createAnchoredBanner(BuildContext context) async {
    final AnchoredAdaptiveBannerAdSize? size = await AdSize.getAnchoredAdaptiveBannerAdSize(
      Orientation.portrait,
      MediaQuery.of(context).size.width.truncate(),
    );

    if (size == null) {
      printLog('Unable to get height of anchored banner.');
      return;
    }

    final BannerAd banner = BannerAd(
      size: AdSize.fullBanner,
      request: Constant.request,
      adUnitId: AdConfig.adMobBannerAdUnitId,
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          printLog('AdMob Banner Ad onAdLoaded:');
          setState(() {
            _anchoredBanner = ad as BannerAd?;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          printLog('AdMob Banner Ad failedToLoad: $error');
          setState(() {
            Constant.isFailedAdMobBannerAd = true;
          });
          ad.dispose();
        },
        onAdImpression: (Ad ad) {
          printLog('AdMob Banner Ad onAdImpression:');
        },
        onAdOpened: (Ad ad) {
          printLog('AdMob Banner Ad onAdImpression: $ad');
        },
        onAdClosed: (Ad ad) {
          printLog('$BannerAdView onAdClosed.');
        },
      ),
    );
    return banner.load();
  }
}
