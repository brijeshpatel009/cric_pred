// ignore_for_file: file_names, avoid_print, invalid_use_of_protected_member

import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../Pages/home_screen/model/LiveScore/LiveScoreModel.dart';
import '../model/UpcomingMatchModel.dart';
import '../widget/CountDown.dart';

class GetAllMatch extends GetxController {
  // MatchResultModel? matchResultData;
  // RxList<AllMatchData> allMatchResultList = RxList([]);
  // RxList<AllMatchData> completeTestMatchList = RxList([]);
  // RxList<AllMatchData> completeT20MatchList = RxList([]);
  // RxList<AllMatchData> completeBPLMatchList = RxList([]);
  // RxList<AllMatchData> completeIPLMatchList = RxList([]);
  // RxList<AllMatchData> completeCPLMatchList = RxList([]);
  // RxList<AllMatchData> completeInternationalMatchList = RxList([]);
  RxList<LiveMatchModel> liveMatchApiList = RxList([]);
  RxList<UpComingModelAllMatch> upcomingMatchApiList = RxList([]);
  RxList<LiveMatchModel> upcomingMatchFilterList = RxList([]);
  RxList<LiveMatchModel> currentLiveMatchFilterList = RxList([]);
  RxBool isLoading = true.obs;
  RxBool isLiveMatchLoading = true.obs;
  // RxBool isAllMatchLoading = true.obs;
  ScrollController allMatchScroller = ScrollController();
  DateTime currentDate = DateTime.now();
  RxList<String> upcomingMatchTeamA = RxList([]);
  RxList<String> upcomingMatchTeamB = RxList([]);
  RxList<String> upcomingMatchTime = RxList([]);
  RxList<String> upcomingMatchImageurlA = RxList([]);
  RxList<String> upcomingMatchImageurlB = RxList([]);
  late Timer _timer;

  @override
  void onInit() {
    super.onInit();
    getLiveMatch().then((value) => upcomingMatch()).then((value) => filterLiveAndUpcomingMatch());
    // _timer = Timer.periodic(Duration(seconds: 1), (timer) {
    //   timeOut;
    // });
    // getAllCompleteMatch();
  }

  matchDataPagination() {}

  String timeOut(DateTime date) {
    return CountDown().timeLeft(date);
  }

  // Future<void> getAllCompleteMatch() async {
  //   print(">>>>>>All Match Api Calling<<<<<<");
  //   isAllMatchLoading.value = true;
  //   allMatchResultList.clear();
  //
  //   final http.Response matchResultResponse = await http.post(Uri.parse('http://cricpro.cricnet.co.in/api/values/MatchResults'),
  //       headers: {'Accept': '*/*', 'Connection': 'keep-alive'}, body: {'start': '0', 'end': '2000'});
  //   print(">>>>>>All Match Api Called<<<<<<");
  //   // print(matchResultResponse.statusCode);
  //   if (matchResultResponse.statusCode == 200) {
  //     // print('------res------------>${matchResultResponse.body}');
  //     matchResultData = MatchResultModel.fromJson(jsonDecode(matchResultResponse.body));
  //     allMatchResultList.value.addAll(matchResultData?.allMatch ?? []);
  //     allMatchResultList.refresh();
  //     filterCompletedMatchList();
  //     isAllMatchLoading.value = false;
  //   } else {
  //     print(matchResultResponse.statusCode);
  //   }
  // }

  Future<void> upcomingMatch() async {
    print("Calling Upcoming Match API");
    isLoading.value = true;
    upcomingMatchApiList.clear();
    final http.Response upcomingMatchResponse = await http.get(Uri.parse('http://cricpro.cricnet.co.in/api/values/upcomingMatches'));
    if (upcomingMatchResponse.statusCode == 200) {
      var upcomingMatchData = UpComingModel.fromJson(jsonDecode(upcomingMatchResponse.body));
      upcomingMatchApiList.value.addAll(upcomingMatchData.allMatch);
      upcomingMatchApiList.refresh();
      print("Calling Complete And Add Upcoming Match Data");
      isLoading.value = false;
    } else {
      print(upcomingMatchResponse.statusCode);
    }
  }

  // void filterCompletedMatchList() {
  //   print("Calling filter Completed MatchList Method");
  //   completeInternationalMatchList.clear();
  //   completeTestMatchList.clear();
  //   completeT20MatchList.clear();
  //   completeBPLMatchList.clear();
  //   completeIPLMatchList.clear();
  //   completeCPLMatchList.clear();
  //   completeInternationalMatchList.value = allMatchResultList.value.where((e) => e.title.contains("International")).toList();
  //   completeT20MatchList.value = allMatchResultList.value.where((e) => e.matchtype == "T20").toList();
  //   completeIPLMatchList.value = allMatchResultList.value.where((e) => e.title.contains("IPL")).toList();
  //   completeCPLMatchList.value = allMatchResultList.value.where((e) => e.title.contains("CPL")).toList();
  //   completeBPLMatchList.value = allMatchResultList.value.where((e) => e.title.contains("BPL")).toList();
  //   completeTestMatchList.value = allMatchResultList.value.where((e) => e.matchtype == "Test").toList();
  //   completeInternationalMatchList.refresh();
  //   completeTestMatchList.refresh();
  //   completeT20MatchList.refresh();
  //   completeBPLMatchList.refresh();
  //   completeIPLMatchList.refresh();
  //   completeCPLMatchList.refresh();
  //   print("Calling Complete filter Completed MatchList Method");
  // }

  DateTime yourParserOrDateTimeParse(String dateTime) {
    String stringDateFormat = dateTime.length > 28
        ? "${dateTime.substring(0, 6).replaceAll(" ", '-')}-${DateFormat("yyyy").format(currentDate)}"
        : dateTime.substring(0, 11);

    String stringTimeFormat = dateTime.length > 28 ? dateTime.substring(26, 33) : dateTime.split(' at').last.split('-').first;

    String formatTime = dateTime.length > 28
        ? '${stringTimeFormat.substring(0, 5)} ${stringTimeFormat.substring(5, 7)}'
        : '${stringTimeFormat.substring(1, 6)} ${stringTimeFormat.substring(6, 8)}';

    String stringDateTime = "$stringDateFormat $formatTime";
    DateTime dateTimeFormat = DateFormat(dateTime.length > 28 ? "MMM-dd-yyyy h:mm a" : "dd-MMM-yyyy h:mm a").parse(stringDateTime);

    DateTime lastDateTime;

    var liveDate = DateFormat("MMM-dd-yyyy h:mm a").parse("${DateFormat("MMM-dd-yyyy").format(currentDate)} $formatTime");
    if (dateTime.length > 28) {
      lastDateTime = DateFormat("MMM-dd-yyyy h:mm a").parse(
          "${dateTime.substring(14, 20).replaceAll(" ", '-')}-${DateFormat("yyyy").format(currentDate)} ${dateTime.substring(27, 31)} ${dateTime.substring(31, 33)}");
      if (dateTimeFormat.isBefore(DateTime.now()) && !lastDateTime.difference(DateTime.now()).inDays.isNegative) {
        return liveDate;
      } else {
        return dateTimeFormat;
      }
    } else {
      return dateTimeFormat;
    }
  }

  // DateTime getOnlyDate() {}

  Future<void> getLiveMatch() async {
    print("Calling Live Match API");
    isLiveMatchLoading.value = true;
    liveMatchApiList.clear();
    final http.Response liveMatchResponse = await http.post(
      Uri.parse('http://cricpro.cricnet.co.in/api/values/LiveLine'),
      headers: {'Accept': '*/*', 'Connection': 'keep-alive'},
    );
    var responseJson = json.decode(liveMatchResponse.body);
    for (var element in responseJson) {
      liveMatchApiList.add(LiveMatchModel.fromJson(element));
    }
    print("Calling Complete And Add Live Match Data");
    currentLiveMatchFilterList.value =
        liveMatchApiList.value.where((element) => yourParserOrDateTimeParse(element.matchtime).isBefore(DateTime.now())).toList();
    isLiveMatchLoading.value = false;
  }

  void filterLiveAndUpcomingMatch() async {
    print("Calling filter Live And Upcoming Match Method");
    isLiveMatchLoading.value = true;
    upcomingMatchFilterList.value =
        liveMatchApiList.value.where((element) => yourParserOrDateTimeParse(element.matchtime).isAfter(DateTime.now())).toList();

    for (var b = 0; b < upcomingMatchFilterList.length; b++) {
      upcomingMatchTeamA.add(upcomingMatchFilterList[b].teamA);
      upcomingMatchTeamB.add(upcomingMatchFilterList[b].teamB);
      upcomingMatchImageurlA.add("${upcomingMatchFilterList[b].imgeUrl.replaceAll("thumb/", "")}${upcomingMatchFilterList[b].teamAImage}");
      upcomingMatchImageurlB.add("${upcomingMatchFilterList[b].imgeUrl.replaceAll("thumb/", "")}${upcomingMatchFilterList[b].teamBImage}");
      upcomingMatchTime.add(upcomingMatchFilterList[b].matchtime);
    }

    for (var a = 0; a < upcomingMatchApiList.length; a++) {
      upcomingMatchTeamA.add(upcomingMatchApiList[a].teamA);
      upcomingMatchTeamB.add(upcomingMatchApiList[a].teamB);
      upcomingMatchImageurlA.add("${upcomingMatchApiList[a].imageUrl.replaceAll("thumb/", "")}${upcomingMatchApiList[a].teamAImage}");
      upcomingMatchImageurlB.add("${upcomingMatchApiList[a].imageUrl.replaceAll("thumb/", "")}${upcomingMatchApiList[a].teamBImage}");
      upcomingMatchTime.add(upcomingMatchApiList[a].matchtime);
    }
    print("Calling Complete filter Live And Upcoming Match");
    isLiveMatchLoading.value = false;
  }
}
