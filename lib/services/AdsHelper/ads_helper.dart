import 'package:cric_pred/services/AdsHelper/rewarded_ad/rewarded_ad.dart';
import 'package:cric_pred/services/AdsHelper/utils/ad_config.dart';
import 'package:cric_pred/services/AdsHelper/utils/utils.dart';

import 'interstitial_ad/interstitial_ad.dart';

export 'banner_ad/banner_ad.dart';
export 'utils/ad_config.dart';

class AdsHelper {
  static showInterstitialAds() {
    if (AdConfig.isAdFeatureEnable) {
      InterstitialAdUtils.showInterstitialAds();
    } else {
      printLog("Warning: Ads Feature is Disable");
    }
  }

  static Future<void> showRewardedAd({required Function adShowSuccess}) async {
    if (AdConfig.isAdFeatureEnable) {
      await RewardedAdUtils.showRewardedAd(adShowSuccess: adShowSuccess);
    } else {
      printLog("Warning: Ads Feature is Disable");
      adShowSuccess.call();
    }
  }
}
