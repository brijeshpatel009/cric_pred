import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../model/AdsDataModel.dart';
import '../services/AdsHelper/utils/ad_config.dart';

class AdsApiData extends GetxController {
  RxBool isLoading = true.obs;
  RxBool isAds = true.obs;
  RxInt adCount = 0.obs;
  AdsDataModel? adsData;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAdsApiData();
  }

  Future<void> getAdsApiData() async {
    isLoading.value = true;
    final dio = Dio();
    print(">>>>>>???????????<M/,/,./,");
    final response = await dio.post("https://adsapi.raghuveerinfotech.com/api/ads/cric");
    if (response.statusCode == 200) {
      adsData = AdsDataModel.fromJson(response.data);
      isAds.value = adsData!.isAds;
      adCount.value = adsData!.counter;
      try {
        await AdConfig().init(
          adMobBannerId: isAds.value == true ? adsData!.banner : '',
          adMobInterstitialAdId: isAds.value == true ? adsData!.inter : '',
          adMobRewardAdId: isAds.value == true ? adsData!.reward : '',
          faceBookBannerId: isAds.value == true ? adsData!.banner : '',
          faceBookInterstitialAdId: isAds.value == true ? adsData!.inter : '',
          facebookRewardAdId: isAds.value == true ? adsData!.reward : '',
          isShowFaceBookBannerAd: false,
          showFacebookInterstitialAd: false,
          showFacebookRewardedAd: false,
          showFacebookTestAd: false,
          coolDownsTap: isAds.value == true ? adsData!.counter : 1,
          proFutureEnable: false,
          adFeatureEnable: true,
          showButtonAd: false,
          showAllAdmobAds: true,
        );
      } catch (e) {
        // ignore: avoid_print
        print('!!!!!!!!! Error AdConfig $e');
      }
      isLoading.value = false;
      print(adsData!.appOpen);
      print(adsData!.isAds);
      print(adsData!.counter);
    } else {
      throw "statusCode ${response.statusCode}";
    }
  }
}
