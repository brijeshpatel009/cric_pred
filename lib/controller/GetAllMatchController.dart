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
  RxList<LiveMatchModel> liveMatchApiList = RxList([]);
  RxList<LiveMatchModel> upcomingMatchList = RxList([]);
  RxList<LiveMatchModel> liveMatchList = RxList([]);
  RxBool isLoading = true.obs;
  ScrollController allMatchScroller = ScrollController();

  @override
  void onInit() {
    getMatchData();
    fetchPosts();
    filterLiveMatchList();
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
    completeInternationalMatchList.value = allMatchResultList.value.where((e) => e.title!.contains("International")).toList();
    completeT20MatchList.value = allMatchResultList.value.where((e) => e.matchtype == "T20").toList();
    completeIPLMatchList.value = allMatchResultList.value.where((e) => e.title!.contains("IPL")).toList();
    completeCPLMatchList.value = allMatchResultList.value.where((e) => e.title!.contains("CPL")).toList();
    completeBPLMatchList.value = allMatchResultList.value.where((e) => e.title!.contains("BPL")).toList();
    completeTestMatchList.value = allMatchResultList.value.where((e) => e.matchtype == "Test").toList();
    completeInternationalMatchList.refresh();
    completeTestMatchList.refresh();
    completeT20MatchList.refresh();
    completeBPLMatchList.refresh();
    completeIPLMatchList.refresh();
    completeCPLMatchList.refresh();
    isLoading.value = false;
  }

  Future<void> fetchPosts() async {
    liveMatchApiList.clear();
    final http.Response liveMatchResponse = await http.post(
      Uri.parse('http://cricpro.cricnet.co.in/api/values/LiveLine'),
      headers: {'Accept': '*/*', 'Connection': 'keep-alive'},
    );
    var responseJson = json.decode(liveMatchResponse.body);
    for (var element in responseJson) {
      liveMatchApiList.add(LiveMatchModel.fromJson(element));
    }
  }

  void filterLiveMatchList() {
    DateTime currentDate = DateTime.now();

    yourParserOrDateTimeParse(String dateTime) {
      print('Element: $dateTime');
      String stringDateFormat = dateTime.length > 28
          ? "${dateTime.substring(0, 6).replaceAll(" ", '-')}-${DateFormat("yyyy").format(currentDate)}"
          : dateTime.substring(0, 11);
      String stringTimeFormat = dateTime.length > 28 ? dateTime.substring(26, 33) : dateTime.split('at').last.split('-').first;

      //     print('stringDateFormat: $stringDateFormat');
      //     print('stringTimeFormat: $stringTimeFormat');

      String formatTime = dateTime.length > 28
          ? '${stringTimeFormat.substring(0, 5)} ${stringTimeFormat.substring(5, 7)}'
          : '${stringTimeFormat.substring(1, 6)} ${stringTimeFormat.substring(6, 8)}';
      String stringDateTime = "$stringDateFormat $formatTime";

//     print('stringDateTime: $stringDateTime');

      DateTime dateTimeFormat = DateFormat(dateTime.length > 28 ? "MMM-dd-yyyy h:mm a" : "dd-MMM-yyyy h:mm a").parse(stringDateTime);

//     print('dateTimeFormat: $dateTimeFormat');
      return dateTimeFormat;
//     String dateTimeDifference = currentDate.difference(dateTimeFormat).toString();
    }

    liveMatchList.value = liveMatchApiList.value.where((element) => yourParserOrDateTimeParse(element.matchtime).isBefore(DateTime.now())).toList();
    print("live Match List: $liveMatchList");
    upcomingMatchList.value =
        liveMatchApiList.value.where((element) => yourParserOrDateTimeParse(element.matchtime).isAfter(DateTime.now())).toList();
    print("upcoming Match List: $upcomingMatchList");
  }
}