import 'package:get/get.dart';

import '../controller/GetAllMatchController.dart';
import '../controller/GetAllPlayerController.dart';
import '../controller/GetNewsController.dart';
import '../controller/MatchStatsController.dart';
import '../controller/getAdAPIDataController.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<GetAllMatchesController>(GetAllMatchesController());
    Get.put<NewsController>(NewsController());
    Get.put<GetPlayerAndRunController>(GetPlayerAndRunController());
    Get.put<MatchStatusController>(MatchStatusController());
    Get.put<AdsApiData>(AdsApiData());
  }
}
