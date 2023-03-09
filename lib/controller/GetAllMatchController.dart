import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../model/LiveScore/LiveScoreModel.dart';
import '../model/MatchesResult.dart';
import '../model/UpcomingMatchModel.dart';

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
  RxList<UpComingModelAllMatch> upcomingMatchApiList = RxList([]);
  RxList<LiveMatchModel> upcomingMatchFilterList = RxList([]);
  RxList<LiveMatchModel> currentLiveMatchFilterList = RxList([]);
  RxBool isLoading = true.obs;
  ScrollController allMatchScroller = ScrollController();
  DateTime currentDate = DateTime.now();

  @override
  void onInit() {
    super.onInit();
    getMatchData();
    fetchPosts();
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

    liveMatchApiList.clear();
    final http.Response liveMatchResponse = await http.post(
      Uri.parse('http://cricpro.cricnet.co.in/api/values/LiveLine'),
      headers: {'Accept': '*/*', 'Connection': 'keep-alive'},
    );
    var responseJson = json.decode(liveMatchResponse.body);
    for (var element in responseJson) {
      liveMatchApiList.add(LiveMatchModel.fromJson(element));
    }

    upcomingMatchApiList.clear();
    final http.Response upcomingMatchResponse = await http.get(Uri.parse('http://cricpro.cricnet.co.in/api/values/upcomingMatches'));
    if (upcomingMatchResponse.statusCode == 200) {
      var upcomingMatchData = UpComingModel.fromJson(jsonDecode(upcomingMatchResponse.body));
      upcomingMatchApiList.value.addAll(upcomingMatchData.allMatch);
      upcomingMatchApiList.refresh();
    } else {
      print(upcomingMatchResponse.statusCode);
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

  yourParserOrDateTimeParse(String dateTime) {
    String stringDateFormat = dateTime.length > 28
        ? "${dateTime.substring(0, 6).replaceAll(" ", '-')}-${DateFormat("yyyy").format(currentDate)}"
        : dateTime.substring(0, 11);

    String stringTimeFormat = dateTime.length > 28 ? dateTime.substring(26, 33) : dateTime.split(' at').last.split('-').first;

    String formatTime = dateTime.length > 28
        ? '${stringTimeFormat.substring(0, 5)} ${stringTimeFormat.substring(5, 7)}'
        : '${stringTimeFormat.substring(1, 6)} ${stringTimeFormat.substring(6, 8)}';

    String stringDateTime = "$stringDateFormat $formatTime";

    String stringTime = "$formatTime";

    DateTime dateTimeFormate = DateFormat(dateTime.length > 28 ? "MMM-dd-yyyy h:mm a" : "dd-MMM-yyyy h:mm a").parse(stringDateTime);

    return dateTimeFormate;
  }

  dateTimeCompare(String dateTime){
    String stringDateFormat =   dateTime.length > 28
        ? "${dateTime.substring(0, 6).replaceAll(" ", '-')}-${DateFormat("yyyy").format(currentDate)}"
        : dateTime.substring(0, 11);

    String stringTimeFormat = dateTime.length > 28 ? dateTime.substring(26, 33) : dateTime.split(' ,').last.split(' ').first;

    String formatTime = dateTime.length > 28
        ? '${stringTimeFormat.substring(0, 5)} ${stringTimeFormat.substring(5, 7)}'
        : '${stringTimeFormat.substring(1, 6)} ${stringTimeFormat.substring(6, 8)}';

    String stringDateTime = "$stringDateFormat $formatTime";

    DateTime dateTimeFormate = DateFormat(dateTime.length > 28 ? "MMM-dd-yyyy h:mm a" : "yyyy-MMM-dd h:mm a").parse(stringDateTime);
    
    return dateTimeFormate;
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

    // var pastMatchList =
    //     liveMatchApiList.value.where((element) => DateFormat("dd-MMM-yyyy").parse(element.matchtime).difference(DateTime.now()).inDays < 0).toList();
    // for (var a = 0; a < pastMatchList.length; a++) {
    //   print("pastMatchList:=>>> ${pastMatchList[a].matchtime}");
    // }

    upcomingMatchFilterList.value =
        liveMatchApiList.value.where((element) {
             return yourParserOrDateTimeParse(element.matchtime).isAfter(DateTime.now());
          },).toList();

    currentLiveMatchFilterList.value =
        liveMatchApiList.value.where((element) {
             return yourParserOrDateTimeParse(element.matchtime).isBefore(DateTime.now());
          },).toList();

    // print(">>>>>>>>++++++++++=====${yourParserOrDateTimeParse(liveMatchApiList[1].matchtime).isBefore(DateTime.now())}");
    // print("++++++++++=====${upcomingMatchFilterList[0].matchtime}");
    // print("=====${currentLiveMatchFilterList[0].matchtime}");
    // print(DateFormat("dd-MMM-yyyy h:mm a")
    //         .parse(forMoreThenOneDayMatch(matchTime: currentLiveMatchFilterList[0].matchtime))
    //         .difference(DateTime.now())
    //         .inDays >=
    //     0);

    // currentLiveMatchFilterList.value = currentLiveMatchFilterList.value
    //     .where((element) =>
    //         DateFormat("dd-MMM-yyyy h:mm a").parse(forMoreThenOneDayMatch(matchTime: element.matchtime)).difference(DateTime.now()).inDays >= 0)
    //     .toList();

    // for (var a = 0; a < upcomingMatchFilterList.length; a++) {
    //   // print(DateFormat("dd-MMM-yyyy").parse(upcomingMatchFilterList[a].matchtime).difference(DateTime.now()).inMinutes);
    //   int time = DateFormat("dd-MMM-yyyy").parse("06:30PM").difference(DateTime.now()).inSeconds;
    //   print("Minutes:=> $time");

    // int sec = time % 60;
    // int min = (time / 60).floor();
    // String minute = min.toString().length <= 1 ? "0$min" : "$min";
    // String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    // print("$minute:$second");

    // var d = Duration(minutes: mini);
    // List<String> parts = d.toString().split(':');
    // print('${parts[0].padLeft(2, '0')}:${parts[1].padLeft(2, '0')}');
    // }
  }
}