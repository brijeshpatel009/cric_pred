import 'package:ads_helper/ads_helper.dart';

import 'firebase_remote_config.dart';

class AdUtils {
  Future<void> initMethod() async {
    try {
      await FirebaseRemoteConfigUtils().initMethod();

      await AdConfig().init(
        adMobAdOpenId: FirebaseRemoteConfigUtils.admobAppOpenAdUnitId,
        adMobBannerId: FirebaseRemoteConfigUtils.admobBannerAdUnitId,
        adMobInterstitialAdId: FirebaseRemoteConfigUtils.admobInterstitialAdUnitId,
        adMobRewardAdId: FirebaseRemoteConfigUtils.admobRewardedAdUnitId,
        faceBookBannerId: '',
        faceBookInterstitialAdId: '',
        facebookRewardAdId: '',
        isShowFaceBookBannerAd: false,
        showFacebookInterstitialAd: false,
        showFacebookRewardedAd: false,
        showFacebookTestAd: false,
        coolDownsTap: FirebaseRemoteConfigUtils.coolDownsTaps,
        proFutureEnable: true,
        adFeatureEnable: FirebaseRemoteConfigUtils.isAdFeatureEnable,
        showButtonAd: false,
        showAllAdmobAds: true,
        showAppOpenAd: true,
        maxFailedLoad: 3,
      );
    } catch (e) {
      rethrow;
    }

    // try {
    //
    // } catch (e, stack) {
    //   printLog('!!!!!! AdConfigError: $e Stack: $stack');
    //   FirebaseAnalyticsUtils().sendAnalyticsError({FirebaseAnalyticsUtils.adConfigError: e.toString()});
    // }
  }
}
