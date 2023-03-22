// ignore_for_file: file_names, avoid_print

import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../model/GetAllPlayerModel.dart';

class GetPlayerAndRunController extends GetxController {
  RxBool isAllPlayerLoading = true.obs;
  late AllPlayerRunModel allPlayerRunData;
  RxList<Playerslist> allPlayerDataList = RxList([]);
  RxList<Playerslist> teamAPlayerList = RxList([]);
  RxList<Playerslist> teamAInning1PlayerList = RxList([]);
  RxList<Playerslist> teamAInning2PlayerList = RxList([]);
  RxList<Playerslist> teamBPlayerList = RxList([]);
  RxList<Playerslist> teamBInning1PlayerList = RxList([]);
  RxList<Playerslist> teamBInning2PlayerList = RxList([]);

  getMatchPlayerData(int matchId, {required String teamA, required String teamB}) async {
    print("Calling All Player Info Method");
    isAllPlayerLoading.value = true;
    allPlayerDataList.clear();

    final http.Response allPlayerResponse = await http.post(Uri.parse('http://cricpro.cricnet.co.in/api/values/GetAllPlayers'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8',
        },
        body: jsonEncode(<String, int>{'MatchId': matchId}));

    if (allPlayerResponse.statusCode == 200) {
      print(allPlayerResponse.body);
      allPlayerRunData = AllPlayerRunModel.fromJson(jsonDecode(allPlayerResponse.body));
      allPlayerDataList.addAll(allPlayerRunData.playerslist);
      print('added====:::>>>>');
      print("Length:=>====== ${allPlayerDataList.length}");
      allPlayerDataList.refresh();
      teamAPlayerList.clear();
      teamBPlayerList.clear();
      teamAPlayerList.value = allPlayerDataList.where((e) => e.teamName.contains(teamA)).toList();
      teamBPlayerList.value = allPlayerDataList.where((e) => e.teamName.contains(teamB)).toList();
      print("teamBPlayerList:===> ${teamBPlayerList.length}");
      isAllPlayerLoading.value = false;
      if (allPlayerDataList.length > 22) {
        isAllPlayerLoading.value = true;
        teamAInning1PlayerList.clear();
        teamAInning2PlayerList.clear();
        teamBInning1PlayerList.clear();
        teamBInning2PlayerList.clear();
        teamAInning1PlayerList.value = teamAPlayerList.where((e) => e.inning == 1).toList();
        teamAInning2PlayerList.value = teamAPlayerList.where((e) => e.inning == 2).toList();
        print("teamAInning2PlayerList;===> ${teamAInning2PlayerList.length}");
        teamBInning1PlayerList.value = teamBPlayerList.where((e) => e.inning == 1).toList();
        print("teamBInning1PlayerList:====> ${teamBInning1PlayerList.length}");
        teamBInning2PlayerList.value = teamBPlayerList.where((e) => e.inning == 2).toList();
        print("teamBInning2PlayerList:====> ${teamBInning2PlayerList.length}");
        isAllPlayerLoading.value = false;
      } else {
        print("AllPlayer Response StatusCode:==>>  ${allPlayerResponse.statusCode}");
      }
    }
  }
}
