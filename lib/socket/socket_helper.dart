// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:cric_pred/Pages/home_screen/model/LiveScore/LiveScoreModel.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:socket_io_client/socket_io_client.dart' as socket_io;

import '../Pages/finished_match_screen/model/GetAllPlayerModel.dart';
import '../Pages/finished_match_screen/model/MatchStatusModel.dart';
import '../Pages/home_screen/model/LiveScore/MatchDataModel.dart';
import '../Pages/news_screen/model/NewsModel.dart';
import '../model/MatchesResult.dart';
import '../model/UpcomingMatchModel.dart';

class SocketHelper {
  static final SocketHelper _singleton = SocketHelper._internal();

  factory SocketHelper() {
    return _singleton;
  }

  SocketHelper._internal();

  static late socket_io.Socket _socket;
  static DateTime currentDate = DateTime.now();
  static RxList<LiveMatchModel> liveScoreList = <LiveMatchModel>[].obs;
  static RxBool isLiveMatchLoading = true.obs;
  static RxBool isNewsLoading = true.obs;
  static RxBool isAllMatchLoading = true.obs;
  static RxBool isAllPlayerLoading = true.obs;
  static RxBool isStatsLoading = true.obs;
  static RxBool isPlayerFilterLoading = true.obs;
  static RxList<LiveMatchModel> upcomingMatchFilterList = RxList([]);
  static RxList<LiveMatchModel> currentLiveMatchFilterList = RxList([]);
  static RxList<String> upcomingMatchTeamA = RxList([]);
  static RxList<String> upcomingMatchTeamB = RxList([]);
  static RxList<String> upcomingMatchTime = RxList([]);
  static RxList<String> upcomingMatchImageurlA = RxList([]);
  static RxList<String> upcomingMatchImageurlB = RxList([]);
  static RxList<UpComingModelAllMatch> upcomingMatchApiList = RxList([]);
  static late NewsModel getNewsData;
  static late MatchResultModel matchResultData;
  static RxList<AllMatchData> allMatchResultList = RxList([]);
  static RxList<AllMatchData> completeT20MatchList = RxList([]);
  static RxList<AllMatchData> completeBPLMatchList = RxList([]);
  static RxList<AllMatchData> completeIPLMatchList = RxList([]);
  static RxList<AllMatchData> completeCPLMatchList = RxList([]);
  static RxList<AllMatchData> completeInternationalMatchList = RxList([]);
  static RxList<AllMatchData> completeTestMatchList = RxList([]);
  static MatchStatModel? matchStatusData;
  static RxList<Matchst> matchStatusList = RxList([]);
  static AllPlayerRunModel? allPlayerRunData;
  static RxList<Playerslist> allPlayerDataList = RxList([]);
  static RxList<Playerslist> teamAPlayerList = RxList([]);
  static RxList<Playerslist> teamBPlayerList = RxList([]);
  static RxList<Playerslist> teamAInning1PlayerList = RxList([]);
  static RxList<Playerslist> teamAInning2PlayerList = RxList([]);
  static RxList<Playerslist> teamBInning1PlayerList = RxList([]);
  static RxList<Playerslist> teamBInning2PlayerList = RxList([]);
  static late MatchDataModel liveMatchData;

  static testingSocket() {
    // _socket = socket_io.io("http://192.168.29.225:5757/", <String, dynamic>{
    //   'autoConnect': true,
    //   'transports': ['websocket'],
    // });
    // _socket.connect();
    // _socket.onConnect((data) {
    //   print("Testing Socket  Connected");
    // });
    // _socket.onConnectError((data) {
    //   print("Testing Connect Error:=== $data");
    // });
    // _socket.onError((data) => print("Testing Socket OnError:=== $data"));
  }

  static void liveMatchInit({int? index}) {
    print("Socket Connecting___________");
    _socket = socket_io.io("https://cricketapp.raghuveerinfotech.com", <String, dynamic>{
      'autoConnect': true,
      'transports': ['websocket'],
    });
    print("1Socket Connecting___________");
    _socket.connect();
    _socket.onConnect((_) {
      print("Hello there, Socket is connected.");

      ///Emit
      _socket.emit('getUpcommingMatchs');

      ///Get
      _socket.on('liveScore', (data) {
        List<LiveMatchModel> tempList = [];
        List<String> tempUpcomingMatchTeamA = [];
        List<String> tempUpcomingMatchTeamB = [];
        List<String> tempUpcomingMatchTime = [];
        List<String> tempUpcomingMatchImageurlA = [];
        List<String> tempUpcomingMatchImageurlB = [];
        isLiveMatchLoading.value = true;
        for (var element in data) {
          tempList.add(LiveMatchModel.fromJson(element));
        }
        liveScoreList(tempList);
        print('Live Score : ${liveScoreList.length}');

        upcomingMatchFilterList.value =
            liveScoreList.where((element) => SocketHelper.yourParserOrDateTimeParse(element.matchtime).isAfter(DateTime.now())).toList();

        currentLiveMatchFilterList.value =
            liveScoreList.where((element) => yourParserOrDateTimeParse(element.matchtime).isBefore(DateTime.now())).toList();

        for (var b = 0; b < upcomingMatchFilterList.length; b++) {
          tempUpcomingMatchTeamA.add(upcomingMatchFilterList[b].teamA);
          tempUpcomingMatchTeamB.add(upcomingMatchFilterList[b].teamB);
          tempUpcomingMatchImageurlA.add("${upcomingMatchFilterList[b].imgeUrl.replaceAll("thumb/", "")}${upcomingMatchFilterList[b].teamAImage}");
          tempUpcomingMatchImageurlB.add("${upcomingMatchFilterList[b].imgeUrl.replaceAll("thumb/", "")}${upcomingMatchFilterList[b].teamBImage}");
          tempUpcomingMatchTime.add(upcomingMatchFilterList[b].matchtime);
          upcomingMatchTeamA(tempUpcomingMatchTeamA);
          upcomingMatchTeamB(tempUpcomingMatchTeamB);
          upcomingMatchTime(tempUpcomingMatchTime);
          upcomingMatchImageurlA(tempUpcomingMatchImageurlA);
          upcomingMatchImageurlB(tempUpcomingMatchImageurlB);
        }
        isLiveMatchLoading.value = false;
        liveMatchData = MatchDataModel.fromJson(jsonDecode(SocketHelper.currentLiveMatchFilterList[index!].jsondata));
      });

      _socket.on("getUpcommingMatchsReceive", (data) {
        print("Get Upcomming Match Data:=>------");
        upcomingMatchApiList.clear();
        var upcomingMatchData = UpComingModel.fromJson(data);
        upcomingMatchApiList.addAll(upcomingMatchData.allMatch);
        upcomingMatchApiList.refresh();
        for (var a = 0; a < upcomingMatchApiList.length; a++) {
          upcomingMatchTeamA.add(upcomingMatchApiList[a].teamA);
          upcomingMatchTeamB.add(upcomingMatchApiList[a].teamB);
          upcomingMatchImageurlA.add("${upcomingMatchApiList[a].imageUrl.replaceAll("thumb/", "")}${upcomingMatchApiList[a].teamAImage}");
          upcomingMatchImageurlB.add("${upcomingMatchApiList[a].imageUrl.replaceAll("thumb/", "")}${upcomingMatchApiList[a].teamBImage}");
          upcomingMatchTime.add(upcomingMatchApiList[a].matchtime);
        }
      });

      _socket.on('getNewsReceive', (data) {
        print('Get News:=>-----');
        isNewsLoading.value = true;
        getNewsData = NewsModel.fromJson(data);
        isNewsLoading.value = false;
      });

      _socket.on('getMatchsStatsReceive', (data) {
        isStatsLoading.value = true;
        matchStatusList.clear();
        matchStatusData = MatchStatModel.fromJson(data);
        matchStatusList.addAll(matchStatusData?.matchst ?? []);
        matchStatusList.refresh();
        isStatsLoading.value = false;
      });

      _socket.on("getAllPlayersReceive", (data) {
        allPlayerRunData = AllPlayerRunModel.fromJson(data);
        allPlayerDataList.addAll(allPlayerRunData?.playerslist ?? []);
      });

      _socket.on("allMatchesResultsReceive", (data) {
        isAllMatchLoading.value = true;
        allMatchResultList.clear();
        matchResultData = MatchResultModel.fromJson(data);
        allMatchResultList.addAll(matchResultData.allMatch ?? []);
        filterFinishedList();
        isAllMatchLoading.value = false;
      });
    });

    _socket.onDisconnect((_) {
      print('liveMatch Connection Disconnect');
    });
    _socket.onConnectError((err) {
      print("liveMatch onConnectError: $err");
    });
    _socket.onError((err) => print("liveMatch onError: $err"));
  }

  static void finishedMatch() {
    print("finished Match SocketInit:=>>>>");
    _socket.emit("allMatchesResults", {"start": 0, "end": 1000});
  }

  static void newsSocketInit() {
    print("News Socket Connecting___________");
    _socket.emit('getNews');
  }

  static void statSocket(int matchID) {
    print("Match Stat Socket:==>>>>");
    _socket.emit("getMatchsStats", {"MatchId": matchID});
  }

  static void playerSocketInit(int matchID, {required String teamA, required String teamB}) {
    print("player Socket Init");
    _socket.emit("getAllPlayers", {"MatchId": matchID});
    isAllPlayerLoading.value = true;
    teamAPlayerList.clear();
    teamBPlayerList.clear();
    teamAPlayerList.value = allPlayerDataList.where((e) => e.teamName.contains(teamA)).toList();
    teamBPlayerList.value = allPlayerDataList.where((e) => e.teamName.contains(teamB)).toList();
    print("Filter Generated");
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
      teamBInning2PlayerList.value = teamBPlayerList.where((e) => e.inning == 2).toList();
      print("teamBInning2PlayerList:====> ${teamBInning2PlayerList.length}");
      isAllPlayerLoading.value = false;
    }
  }

  // static void filterPlayerList({required String teamA, required String teamB}) {
  //   isAllPlayerLoading.value = true;
  //   teamAPlayerList.clear();
  //   teamBPlayerList.clear();
  //   teamAPlayerList.value = allPlayerDataList.where((e) => e.teamName.contains(teamA)).toList();
  //   teamBPlayerList.value = allPlayerDataList.where((e) => e.teamName.contains(teamB)).toList();
  //   isAllPlayerLoading.value = false;
  //   if (allPlayerDataList.length > 22) {
  //     isAllPlayerLoading.value = true;
  //     teamAInning1PlayerList.clear();
  //     teamAInning2PlayerList.clear();
  //     teamBInning1PlayerList.clear();
  //     teamBInning2PlayerList.clear();
  //     teamAInning1PlayerList.value = teamAPlayerList.where((e) => e.inning == 1).toList();
  //     teamAInning2PlayerList.value = teamAPlayerList.where((e) => e.inning == 2).toList();
  //     print("teamAInning2PlayerList;===> ${teamAInning2PlayerList.length}");
  //     teamBInning1PlayerList.value = teamBPlayerList.where((e) => e.inning == 1).toList();
  //     teamBInning2PlayerList.value = teamBPlayerList.where((e) => e.inning == 2).toList();
  //     print("teamBInning2PlayerList:====> ${teamBInning2PlayerList.length}");
  //     isAllPlayerLoading.value = false;
  //   }
  // }

  static void filterFinishedList() {
    completeInternationalMatchList.clear();
    completeInternationalMatchList.value = allMatchResultList.where((e) => e.title.contains("International")).toList();
    completeInternationalMatchList.refresh();
    completeTestMatchList.clear();
    completeTestMatchList.value = allMatchResultList.where((e) => e.matchtype == "Test").toList();
    completeTestMatchList.refresh();
    completeT20MatchList.clear();
    completeT20MatchList.value = allMatchResultList.where((e) => e.matchtype == "T20").toList();
    completeT20MatchList.refresh();
    completeIPLMatchList.clear();
    completeIPLMatchList.value = allMatchResultList.where((e) => e.title.contains("IPL")).toList();
    completeIPLMatchList.refresh();
    completeCPLMatchList.clear();
    completeCPLMatchList.value = allMatchResultList.where((e) => e.title.contains("CPL")).toList();
    completeCPLMatchList.refresh();
    completeBPLMatchList.clear();
    completeBPLMatchList.value = allMatchResultList.where((e) => e.title.contains("BPL")).toList();
    completeBPLMatchList.refresh();
  }

  static DateTime yourParserOrDateTimeParse(String dateTime) {
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
}
