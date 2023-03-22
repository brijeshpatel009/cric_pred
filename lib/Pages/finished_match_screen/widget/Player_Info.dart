// ignore_for_file: file_names, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/MatchesResult.dart';
import '../../../utils/utils.dart';
import '../../../widget/CustomTab.dart';
import '../Controller/GetAllPlayerController.dart';
import 'Player_Info_List.dart';

class PlayerInfo extends StatefulWidget {
  const PlayerInfo({Key? key, required this.matchData}) : super(key: key);
  final AllMatchData matchData;

  @override
  State<PlayerInfo> createState() => _PlayerInfoState();
}

class _PlayerInfoState extends State<PlayerInfo> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("MatchID:===>>>> ${widget.matchData.matchId}");
    // SocketHelper.playerSocketInit(widget.matchData.matchId, teamA: widget.matchData.teamA, teamB: widget.matchData.teamB);

    // SocketHelper.filterPlayerList(teamA: widget.matchData.teamA, teamB: widget.matchData.teamB);
    allPlayerData = Get.put(GetPlayerAndRunController())
      ..getMatchPlayerData(widget.matchData.matchId, teamA: widget.matchData.teamA, teamB: widget.matchData.teamB);
  }

  late GetPlayerAndRunController allPlayerData;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.02),
        child: Column(
          children: [
            SizedBox(
              height: height * 0.02,
            ),
            Expanded(
              child: TabContainer(
                childDuration: Duration(milliseconds: 700),
                tabDuration: Duration(milliseconds: 700),
                color: const Color(0xffEDE7FB),
                tabEdge: TabEdge.top,
                tabs: [widget.matchData.teamA, widget.matchData.teamB],
                selectedTextStyle: const TextStyle(
                  color: Color(0xff2E2445),
                  fontSize: 15.0,
                ),
                unselectedTextStyle: const TextStyle(
                  color: Color(0xff848484),
                  fontSize: 13.0,
                ),
                children: [
                  Obx(
                    () => PlayerInfoList(
                      teamPlayerList: allPlayerData.teamAPlayerList,
                      inning1PlayerList: allPlayerData.teamAInning1PlayerList,
                      inning2PlayerList: allPlayerData.teamAInning2PlayerList,
                      playerListLength: allPlayerData.allPlayerDataList.length,
                      isAllPlayerLoading: allPlayerData.isAllPlayerLoading.value,
                    ),
                  ),
                  Obx(
                    () => PlayerInfoList(
                      teamPlayerList: allPlayerData.teamBPlayerList,
                      inning1PlayerList: allPlayerData.teamBInning1PlayerList,
                      inning2PlayerList: allPlayerData.teamBInning2PlayerList,
                      playerListLength: allPlayerData.allPlayerDataList.length,
                      isAllPlayerLoading: allPlayerData.isAllPlayerLoading.value,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Text tittle(String string) {
    return Text(string, style: const TextStyle(color: Color(0xff2E1664)));
  }

  Text infoTittle(String string) {
    return Text(string, style: const TextStyle(color: Color(0xff000000)));
  }

  Text subTittle(String string) {
    return Text(
      string,
      style: const TextStyle(color: Color(0xff000000)),
    );
  }

  Text infoSubTittle(String string) {
    return Text(
      string,
      style: const TextStyle(color: Color(0xff767676)),
    );
  }
}
