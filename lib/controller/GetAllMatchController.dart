import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../model/LiveScore/LiveScoreModel.dart';
import '../model/MatchesResult.dart';

class GetAllMatchesController extends GetxController {
  MatchResultModel? matchResultData;
  RxList<AllMatchData> allMatchResultList = RxList([]);
  RxList<AllMatchData> completeTestMatchList = RxList([]);
  RxList<AllMatchData> completeT20MatchList = RxList([]);
  RxList<AllMatchData> completeBPLMatchList = RxList([]);
  RxList<AllMatchData> completeIPLMatchList = RxList([]);
  RxList<AllMatchData> completeCPLMatchList = RxList([]);
  RxList<AllMatchData> completeInternationalMatchList = RxList([]);
  RxList<LiveMatchModel> testMatchList = RxList([]);
  RxList<LiveMatchModel> liveMatchList = RxList([]);
  RxList liveMatchFilterList = [].obs;
  RxBool isLoading = true.obs;
  ScrollController allMatchScroller = ScrollController();

  @override
  void onInit() {
    getMatchData();
    fetchPosts();
    super.onInit();
  }

  matchDataPagination() {}
  Future<void> getMatchData() async {
    isLoading.value = true;
    allMatchResultList.clear();

    // print(">>>>>>All Match Api Calling<<<<<<");
    final http.Response matchResultResponse = await http.post(Uri.parse('http://cricpro.cricnet.co.in/api/values/MatchResults'),
        headers: {'Accept': '*/*', 'Connection': 'keep-alive'}, body: {'start': '0', 'end': '1000'});
    // print(">>>>>>All Match Api Called<<<<<<");
    // print(matchResultResponse.statusCode);
    if (matchResultResponse.statusCode == 200) {
      // print('------res------------>${matchResultResponse.body}');
      matchResultData = MatchResultModel.fromJson(jsonDecode(matchResultResponse.body));
      allMatchResultList.value.addAll(matchResultData?.allMatch ?? []);
      allMatchResultList.refresh();
      filterCompletedMatchList();
      isLoading.value = false;
    } else {
      // print(matchResultResponse.statusCode);
    }
  }

  void filterCompletedMatchList() {
    isLoading.value = true;
    completeInternationalMatchList.clear();
    completeTestMatchList.clear();
    completeT20MatchList.clear();
    completeBPLMatchList.clear();
    completeIPLMatchList.clear();
    completeCPLMatchList.clear();
    testMatchList.clear();
    completeInternationalMatchList.value = allMatchResultList.value.where((e) => e.title!.contains("International")).toList();
    completeT20MatchList.value = allMatchResultList.value.where((e) => e.matchtype == "T20").toList();
    completeIPLMatchList.value = allMatchResultList.value.where((e) => e.title!.contains("IPL")).toList();
    completeCPLMatchList.value = allMatchResultList.value.where((e) => e.title!.contains("CPL")).toList();
    completeBPLMatchList.value = allMatchResultList.value.where((e) => e.title!.contains("BPL")).toList();
    completeTestMatchList.value = allMatchResultList.value.where((e) => e.matchtype == "Test").toList();
    testMatchList.value = liveMatchList.value.where((e) => e.matchtime.length > 28).toList();
    completeInternationalMatchList.refresh();
    completeTestMatchList.refresh();
    completeT20MatchList.refresh();
    completeBPLMatchList.refresh();
    completeIPLMatchList.refresh();
    completeCPLMatchList.refresh();
    testMatchList.refresh();
    isLoading.value = false;
    print(">>>>>>>>>>+========= ${testMatchList.length}");
  }

  Future<void> fetchPosts() async {
    liveMatchList.clear();
    final http.Response liveMatchResponse = await http.post(
      Uri.parse('http://cricpro.cricnet.co.in/api/values/LiveLine'),
      headers: {'Accept': '*/*', 'Connection': 'keep-alive'},
    );
    var responseJson = json.decode(liveMatchResponse.body);
    for (var element in responseJson) {
      liveMatchList.add(LiveMatchModel.fromJson(element));
    }
  }

  void filterLiveMatchList() {
    List<String> apiDateList = [];
    for (var a = 0; a < liveMatchList.length; a++) {
      apiDateList.add(liveMatchList[a].matchtime);
    }

    DateTime currentDate = DateTime.now();
    String apiDateTime = '';
    String stringDateFormat = apiDateTime.split('at').first.replaceAll(' ', '');
    String stringTimeFormat = apiDateTime.split('at').last.split('-').first;
    print('stringDateFormat: $stringDateFormat');
    print('stringTimeFormat: $stringTimeFormat');
    String formatTime = '${stringTimeFormat.substring(0, 6)} ${stringTimeFormat.substring(6, 8)}';
    String stringDateTime = "$stringDateFormat$formatTime";
    print('stringDateTime: $stringDateTime');
    DateTime dateTimeFormat = DateFormat("dd-MMM-yyyy h:mm a").parse(stringDateTime);
    print('dateTimeFormat: $dateTimeFormat');
    bool dateTimeDifference = currentDate.difference(dateTimeFormat).isNegative;
    print('dateTime has gone: $dateTimeDifference');
  }
}