// ignore_for_file: avoid_print, file_names

import 'package:ads_helper/utils/ad_config.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../model/AdsDataModel.dart';

class AdsApiData extends GetxController {
  RxBool isLoading = true.obs;
  RxBool isAds = true.obs;
  RxInt adCount = 0.obs;
  late AdsDataModel adsData;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAdsApiData();
  }

  Future<void> getAdsApiData() async {
    print("123456547897.........>>>>>");
    isLoading.value = true;
    final dio = Dio();
    final response = await dio.post("https://adsapi.raghuveerinfotech.com/api/ads/cric");
    if (response.statusCode == 200) {
      adsData = AdsDataModel.fromJson(response.data);
      isAds.value = adsData.isAds;
      adCount.value = adsData.counter;
      print("is Ads Show:=> ${isAds.value}");
      try {
        await AdConfig().init(
          adMobAdOpenId: adsData.appOpen,
          adMobBannerId: adsData.banner,
          adMobInterstitialAdId: adsData.inter,
          adMobRewardAdId: adsData.reward,
          faceBookBannerId: '',
          faceBookInterstitialAdId: '',
          facebookRewardAdId: '',
          isShowFaceBookBannerAd: false,
          showFacebookInterstitialAd: false,
          showFacebookRewardedAd: false,
          showFacebookTestAd: false,
          coolDownsTap: adCount.value,
          proFutureEnable: false,
          adFeatureEnable: isAds.value,
          showButtonAd: false,
          showAllAdmobAds: true,
          showAppOpenAd: true,
          showAppOpenAdDelay: 2000,
        );
      } catch (e) {
        print('!!!!!!!!! Error AdConfig $e');
      }
      isLoading.value = false;
      print(adsData.appOpen);
      print(adsData.isAds);
      print(adsData.counter);
    } else {
      throw "statusCode ${response.statusCode}";
    }
  }
}
