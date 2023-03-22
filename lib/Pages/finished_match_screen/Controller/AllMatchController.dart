// ignore_for_file: file_names, avoid_print

import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../model/MatchesResult.dart';

class AllMatchController extends GetxController {
  RxBool isAllMatchLoading = true.obs;
  RxList<AllMatchData> allMatchResultList = RxList([]);
  RxList<AllMatchData> completeTestMatchList = RxList([]);
  RxList<AllMatchData> completeT20MatchList = RxList([]);
  RxList<AllMatchData> completeBPLMatchList = RxList([]);
  RxList<AllMatchData> completeIPLMatchList = RxList([]);
  RxList<AllMatchData> completeCPLMatchList = RxList([]);
  RxList<AllMatchData> completeInternationalMatchList = RxList([]);
  MatchResultModel? matchResultData;

  @override
  void onInit() {
    super.onInit();
    getAllCompleteMatch();
  }

  Future<void> getAllCompleteMatch() async {
    print(">>>>>>All Match Api Calling<<<<<<");
    isAllMatchLoading.value = true;
    allMatchResultList.clear();

    final http.Response matchResultResponse = await http.post(Uri.parse('http://cricpro.cricnet.co.in/api/values/MatchResults'),
        headers: {'Accept': '*/*', 'Connection': 'keep-alive'}, body: {'start': '0', 'end': '2000'});
    print(">>>>>>All Match Api Called<<<<<<");
    // print(matchResultResponse.statusCode);
    if (matchResultResponse.statusCode == 200) {
      // print('------res------------>${matchResultResponse.body}');
      matchResultData = MatchResultModel.fromJson(jsonDecode(matchResultResponse.body));
      allMatchResultList.addAll(matchResultData?.allMatch ?? []);
      allMatchResultList.refresh();
      filterCompletedMatchList();
      isAllMatchLoading.value = false;
    } else {
      print(matchResultResponse.statusCode);
    }
  }

  void filterCompletedMatchList() {
    print("Calling filter Completed MatchList Method");
    completeInternationalMatchList.clear();
    completeTestMatchList.clear();
    completeT20MatchList.clear();
    completeBPLMatchList.clear();
    completeIPLMatchList.clear();
    completeCPLMatchList.clear();
    completeInternationalMatchList.value = allMatchResultList.where((e) => e.title.contains("International")).toList();
    completeT20MatchList.value = allMatchResultList.where((e) => e.matchtype == "T20").toList();
    completeIPLMatchList.value = allMatchResultList.where((e) => e.title.contains("IPL")).toList();
    completeCPLMatchList.value = allMatchResultList.where((e) => e.title.contains("CPL")).toList();
    completeBPLMatchList.value = allMatchResultList.where((e) => e.title.contains("BPL")).toList();
    completeTestMatchList.value = allMatchResultList.where((e) => e.matchtype == "Test").toList();
    completeInternationalMatchList.refresh();
    completeTestMatchList.refresh();
    completeT20MatchList.refresh();
    completeBPLMatchList.refresh();
    completeIPLMatchList.refresh();
    completeCPLMatchList.refresh();
    print("Calling Complete filter Completed MatchList Method");
  }
}
