import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cric_pred/model/Upcomming.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/LiveScore/LiveScoreModel.dart';

class GetUpcommingMatch extends GetxController{
  Upcomming? upcommingMatchdata;
  RxList<AllMatch> allUpcommingMatchResultList = RxList([]);
  RxList<AllMatch> completeTestMatchList = RxList([]);
  RxList<AllMatch> completeT20MatchList = RxList([]);
  RxList<AllMatch> completeBPLMatchList = RxList([]);
  RxList<AllMatch> completeIPLMatchList = RxList([]);
  RxList<AllMatch> completeCPLMatchList = RxList([]);
  RxList<AllMatch> completeInternationalMatchList = RxList([]);
  RxList<LiveMatchModel> testMatchList = RxList([]);
  RxList<LiveMatchModel> liveMatchList = RxList([]);
  RxList liveMatchFilterList = [].obs;
  RxBool isLoading = true.obs;
  ScrollController allMatchScroller = ScrollController();

  @override
  void onInit(){
    getUpcommingMatchData();
    super.onInit();
  }

  matchDataPagination() {}
  Future<void> getUpcommingMatchData() async {
    isLoading.value = true;
    allUpcommingMatchResultList.clear();

    final http.Response matchResultResponse = await http.get(Uri.parse('http://cricpro.cricnet.co.in/api/values/upcomingMatches'),
        headers: {'Accept': '*/*', 'Connection': 'keep-alive'},);
    if (matchResultResponse.statusCode == 200) {
      upcommingMatchdata = Upcomming.fromJson(jsonDecode(matchResultResponse.body));
      allUpcommingMatchResultList.value.addAll(upcommingMatchdata?.allMatch ?? []);
      allUpcommingMatchResultList.refresh();
      filterCompletedMatchList();
      isLoading.value = false;
    } else {
      print(matchResultResponse.statusCode);
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
    completeInternationalMatchList.value = allUpcommingMatchResultList.value.where((e) => e.title!.contains("International")).toList();
    completeT20MatchList.value = allUpcommingMatchResultList.value.where((e) => e.matchtype == "T20").toList();
    completeIPLMatchList.value = allUpcommingMatchResultList.value.where((e) => e.title!.contains("IPL")).toList();
    completeCPLMatchList.value = allUpcommingMatchResultList.value.where((e) => e.title!.contains("CPL")).toList();
    completeBPLMatchList.value = allUpcommingMatchResultList.value.where((e) => e.title!.contains("BPL")).toList();
    completeTestMatchList.value = allUpcommingMatchResultList.value.where((e) => e.matchtype == "Test").toList();
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
}