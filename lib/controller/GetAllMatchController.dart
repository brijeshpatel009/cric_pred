// ignore_for_file: file_names, avoid_print, invalid_use_of_protected_member

import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../model/LiveScore/LiveScoreModel.dart';
import '../model/MatchesResult.dart';

class GetAllMatchesController extends GetxController {
  MatchResultModel? matchResultData;
  RxList<AllMatchData> allMatchResultList = RxList([]);
  RxList<LiveScoreModel> liveMatchScoreList = RxList([]);
  // RxList<LiveScoreRunModel> liveMatchListRun = RxList([]);
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    getMatchData();
    fetchPosts();
    // photoScroller.addListener(() {
    //   if (photoScroller.position.pixels ==
    //       photoScroller.position.maxScrollExtent && photoList.length < (obj?.count ?? 0) ) {
    //     page = page+1;
    //     pageLimit = pageLimit+10;
    //     getPhoto();
    //   }
    // });
    super.onInit();
  }

  getMatchData() async {
    isLoading.value = true;
    print("object");
    final http.Response matchResultResponse = await http.post(Uri.parse('http://cricpro.cricnet.co.in/api/values/MatchResults'),
        headers: {'Accept': '*/*', 'Connection': 'keep-alive'}, body: {'start': '0', 'end': '15'});
    if (matchResultResponse.statusCode == 200) {
      // print('------res------------>${liveMatchResponse.body}');
      matchResultData = MatchResultModel.fromJson(jsonDecode(matchResultResponse.body));
      allMatchResultList.value.addAll(matchResultData?.allMatch ?? []);
      allMatchResultList.refresh();
      isLoading.value = false;
    } else {
      print(matchResultResponse.statusCode);
    }
  }

  fetchPosts() async {
    final http.Response liveMatchResponse = await http.post(
      Uri.parse('http://cricpro.cricnet.co.in/api/values/LiveLine'),
      headers: {'Accept': '*/*', 'Connection': 'keep-alive'},
    );
    var responseJson = json.decode(liveMatchResponse.body);
    for (var element in responseJson) {
      liveMatchScoreList.add(LiveScoreModel.fromJson(element));
    }
    for (var i = 0; i < liveMatchScoreList.length; i++) {
      print("${liveMatchScoreList[i].teamA}  vs ${liveMatchScoreList[i].teamB}");
    }
    // print(">>>???>>>${liveMatchResponse.body}");
    // print(">>??<<>>??${liveMatchList[0].jsonruns}");
    // liveMatchRunData = LiveScoreRunModel.fromJson(jsonDecode(liveMatchList[0].jsondata));
    // liveMatchRunData = LiveScoreRunModel.fromJson(jsonDecode(liveMatchList[0].jsonruns));
    // liveMatchRunData = LiveScoreRunModel.fromJson(jsonDecode(liveMatchList[0].jsondata));
    // List.generate(GetDataController().liveMatchList.length, (index) => liveMatchRunData.add(LiveScoreRunModel.fromJson(jsonDecode(liveMatchList[index].jsonruns))));
    // List.generate(GetDataController().liveMatchList.length, (index) => liveMatchRunData.add(LiveScoreRunModel.fromJson(jsonDecode(liveMatchList[index].jsondata))));
    // print(liveMatchRunData!.jsonruns.runxa);
    // print(liveMatchRunData!.jsonruns.runxb);
    // print(liveMatchRunData!.jsonruns.fav);
    // print(liveMatchRunData!.jsonruns.rateA);
    // print(liveMatchRunData!.jsonruns.rateB);
    // print(liveMatchRunData!.jsonruns.sessionA);
    // print(liveMatchRunData!.jsonruns.sessionB);
    // print(liveMatchRunData!.jsonruns.sessionOver);
    // print(liveMatchRunData!.jsonruns.summary);
    // print(liveMatchRunData!.jsondata.wicketA);
    // print(liveMatchRunData!.jsonruns.stat);
  }
}
