// ignore_for_file: file_names, avoid_print, invalid_use_of_protected_member

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

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
  RxList<LiveScoreModel> liveMatchScoreList = RxList([]);
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
    print("<<<<<<object");
    allMatchResultList.clear();

    print(">>>>>>All Match Api Calling<<<<<<");
    final http.Response matchResultResponse = await http.post(Uri.parse('http://cricpro.cricnet.co.in/api/values/MatchResults'),
        headers: {'Accept': '*/*', 'Connection': 'keep-alive'}, body: {'start': '0', 'end': '1000'});
    print(">>>>>>All Match Api Called<<<<<<");
    print(matchResultResponse.statusCode);
    if (matchResultResponse.statusCode == 200) {
      // print('------res------------>${matchResultResponse.body}');
      matchResultData = MatchResultModel.fromJson(jsonDecode(matchResultResponse.body));
      allMatchResultList.value.addAll(matchResultData?.allMatch ?? []);
      allMatchResultList.refresh();
      filterMatchList();
      isLoading.value = false;
    } else {
      print(matchResultResponse.statusCode);
    }
  }

  void filterMatchList() {
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
  }

  Future<void> fetchPosts() async {
    liveMatchScoreList.clear();
    final http.Response liveMatchResponse = await http.post(
      Uri.parse('http://cricpro.cricnet.co.in/api/values/LiveLine'),
      headers: {'Accept': '*/*', 'Connection': 'keep-alive'},
    );
    var responseJson = json.decode(liveMatchResponse.body);
    for (var element in responseJson) {
      liveMatchScoreList.add(LiveScoreModel.fromJson(element));
    }
  }
}