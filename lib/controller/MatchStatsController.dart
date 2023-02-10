// ignore_for_file: file_names, avoid_print

import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../model/MatchStatusModel.dart';

class MatchStatusController extends GetxController {
  RxBool isLoading = true.obs;
  MatchStatModel? matchStatusData;
  RxList<Matchst> matchStatusList = RxList([]);

  getMatchStatsData(int matchId) async {
    isLoading.value = true;
    print(">>>>>>Api Calling<<<<<<");

    final http.Response matchStatusResponse = await http.post(Uri.parse('http://cricpro.cricnet.co.in/api/values/MatchStats'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8',
        },
        body: jsonEncode(<String, int>{'MatchId': matchId}));

    print(">>>>>Api Passed<<<<<");

    if (matchStatusResponse.statusCode == 200) {
      matchStatusData = MatchStatModel.fromJson(jsonDecode(matchStatusResponse.body));
      matchStatusList.addAll(matchStatusData?.matchst ?? []);
      matchStatusList.refresh();
      print(matchStatusResponse.body);
      isLoading.value = false;
    } else {
      print(matchStatusResponse.statusCode);
    }
  }
}