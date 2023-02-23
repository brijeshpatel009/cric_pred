import 'dart:async';
import 'dart:convert';
import 'package:cric_pred/Pages/Screen/Match_Score.dart';
import 'package:cric_pred/Pages/Screen/Team_Screen.dart';
import 'package:cric_pred/controller/GetAllPlayerController.dart';
import 'package:cric_pred/model/LiveScore/MatchDataModel.dart';
import 'package:cric_pred/model/LiveScore/MatchRunsModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../controller/GetAllMatchController.dart';
import '../model/GetAllPlayerModel.dart';
import '../model/LiveScore/MatchDataModel.dart';
import '../model/NewsModel.dart';
import '../utils/variable.dart';
import 'commonWidget.dart';

class MatchesList extends StatefulWidget {
  const MatchesList({Key? key, required this.matchStreamingCategoryIndex}) : super(key: key);
  final int matchStreamingCategoryIndex;

  @override
  State<MatchesList> createState() => _MatchesListState();}

class _MatchesListState extends State<MatchesList> {
  String? date;
  late IO.Socket socket;

  initSocket() {
    socket =
        IO.io("https://soccer-battle-2023.onrender.com/", <String, dynamic>{
          'autoConnect': false,
          'transports': ['websocket'],
        });
    socket.connect();
    socket.onConnect((_) {
      sendData();
      socket.on('leaderBoardReceiveData', (data) {
        print('Get LiveScore');
      });

      socket.on('', (data) {
        // getMatchResult(data);
        print('Get Match Result');
      });

      socket.on('', (data) {
        getAllPlayer(data);
        print('Get All Player');
      });

      socket.on('', (data) {
        getNews(data);
        print('Get News');
      });
      print('onConnected');
    });
    socket.onDisconnect((_) => print('Connection Disconnection'));
    socket.onConnectError((err) => print(err));
    socket.onError((err) => print(err));
  }

  sendData() {
    socket.emit(
      'leaderBoard',
    );
    print('data Send');
  }

  getData(String name) {
    print(name);
  }

  static const int _len = 5;
  LiveScoreRunModel? liveMatchRun;

  @override
  void initState() {
    super.initState();
    matchDataController = Get.find();
    print("(b)object");
    List.generate(
      matchStreamingCategoryIndex == 1
          ? matchDataController.liveMatchApiList.length
      : matchDataController.upcomingMatchApiList.length,
          (index) {
        getAllPlayerController = Get.find()
          ..getMatchPlayerData(matchStreamingCategoryIndex == 1
              ? matchDataController.upcomingMatchApiList[index].matchId
              : matchDataController.
          liveMatchApiList[index + 1 > matchDataController.currentLiveMatchFilterList.length ? 0 : index].matchId, 0
          );
        // liveMatchRun = LiveScoreRunModel.fromJson(
        //     jsonDecode(getMatchController.liveMatchApiList[index + 1 > getMatchController.liveMatchApiList.length ? 0 : index].jsonruns));
        // print(matchDataController.allMatchResultList[index].matchId);
        print("object");
        print(">>>>>>>>>> ${matchStreamingCategoryIndex == 1
            ? matchDataController.upcomingMatchApiList[index].matchId
            : matchDataController.
        liveMatchApiList[index + 1 > matchDataController.currentLiveMatchFilterList.length ? 0 : index].matchId}");
      },
    );
  }

  late GetAllMatchesController matchDataController;
  List<MatchDataModel> matchDataList = [];
  final GetAllMatchesController getMatchController = Get.find();
  late GetPlayerAndRunController getAllPlayerController;

  @override
  Widget build(BuildContext context) {
    double height = Get.height;
    double width = Get.width;
    double cardHeight = height * 0.25;
    return Obx(
          () => matchDataController.isLoading.value
          ? Center(
        child: SizedBox(height: height * 0.04, width: height * 0.04, child: const CircularProgressIndicator()),
      ) : matchDataController.currentLiveMatchFilterList.isEmpty && matchStreamingCategoryIndex == 0
              ? const Center(
            child: Text(
              'Currently Not Available Any Live Match',
              style: TextStyle(
                color: Color(0xff2E2445),
                fontWeight: FontWeight.w500,
                letterSpacing: 0.8,
              ),
            ),
          )
          : ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(top: 15, bottom: 100),
            itemCount: matchStreamingCategoryIndex == 1
                ? matchDataController.upcomingMatchApiList.length
                : matchDataController.currentLiveMatchFilterList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: height * 0.02),
                child: Stack(
                  children: [
                    commonContainer(
                      size: cardHeight,
                      radius: cardHeight * 0.3,
                      child: Padding(
                        padding: EdgeInsets.all(cardHeight * 0.08),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: cardHeight * 0.1,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular((width * 0.13))),
                                    color: Colors.white,
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black45,
                                        blurRadius: 5,
                                        spreadRadius: -1.9,
                                        offset: Offset(0.0, 0.0),
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: (cardHeight * 0.1) * 0.07, horizontal: (cardHeight * 0.1) * 0.5),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        FittedBox(
                                            child: Text(
                                              matchStreamingCategoryIndex == 0 ? 'Live' : 'Upcoming',
                                              style: const TextStyle(fontWeight: FontWeight.w500),
                                            )),
                                        Icon(
                                          Icons.circle,
                                          size: width * 0.022,
                                          color: matchStreamingCategoryIndex == 0 ? Colors.red : Colors.blue,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //TeamA
                                SizedBox(width: width*0.05,),
                                Column(
                                  children: [
                                    SizedBox(
                                      height: cardHeight * 0.45,
                                      width: cardHeight * 0.45,
                                      child: Image.network(
                                        matchStreamingCategoryIndex == 1
                                            ? "${matchDataController.upcomingMatchApiList[index].imageUrl}${matchDataController.upcomingMatchApiList[index].teamAImage}"
                                            : "${matchDataController.currentLiveMatchFilterList[index].imgeUrl}${matchDataController.currentLiveMatchFilterList[index].teamAImage}",
                                      ),
                                    ),
                                    Text(
                                      matchStreamingCategoryIndex == 1
                                          ? matchDataController.upcomingMatchApiList[index].teamA
                                          : matchDataController.currentLiveMatchFilterList[index].teamA,
                                      style: const TextStyle(fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      matchStreamingCategoryIndex == 1 ? "" : '',
                                      style: const TextStyle(fontWeight: FontWeight.w400, color: Colors.grey),
                                    )
                                  ],
                                ),

                                //VS
                                Image.asset(
                                  'asset/VS.png',
                                  fit: BoxFit.cover,
                                  height: cardHeight * 0.5,
                                  width: cardHeight * 0.5,
                                ),

                                //TeamB
                                Column(
                                  children: [
                                    SizedBox(
                                      height: cardHeight * 0.45,
                                      width: cardHeight * 0.45,
                                      child: Image.network(
                                        matchStreamingCategoryIndex == 1
                                            ? "${matchDataController.upcomingMatchApiList[index].imageUrl}${matchDataController.upcomingMatchApiList[index].teamBImage}"
                                            : "${matchDataController.currentLiveMatchFilterList[index].imgeUrl}${matchDataController.currentLiveMatchFilterList[index].teamBImage}",
                                      ),
                                    ),
                                    Text(
                                      matchStreamingCategoryIndex == 1
                                          ? matchDataController.upcomingMatchApiList[index].teamB
                                          : matchDataController.currentLiveMatchFilterList[index].teamB,
                                      style: const TextStyle(fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                SizedBox(width: width*0.05,),
                              ],
                            ),
                            matchStreamingCategoryIndex == 1
                                ? Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(
                                  matchDataController
                                      .upcomingMatchApiList[index]
                                      .matchtime,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 1),
                                ),
                              ],
                            )
                                : Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: cardHeight * 0.05),
                                      child: Text(getAllPlayerController
                                          .allPlayerDataList.isEmpty
                                          ? "Match Not Started"
                                          : getAllPlayerController
                                          .allPlayerDataList[0]
                                          .teamRuns ==
                                          ''
                                          ? "in progress.."
                                          : getAllPlayerController
                                          .allPlayerDataList[0]
                                          .teamRuns ==
                                          "in progress.."
                                          ? "${getAllPlayerController.allPlayerDataList[0].teamRuns}"
                                          : "${getAllPlayerController.allPlayerDataList[0].teamRuns})"),
                                    ),
                                  ],
                                ),
                                SizedBox(width: cardHeight * 0.3),
                                Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: cardHeight * 0.05),
                                      child: Text(
                                        getAllPlayerController
                                            .allPlayerDataList
                                            .isEmpty
                                            ? "Match Not Started"
                                            : getAllPlayerController
                                            .allPlayerDataList
                                            .last
                                            .teamRuns ==
                                            ''
                                            ? "in progress.."
                                            : "${getAllPlayerController.allPlayerDataList.last.teamRuns})",
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height * 0.00008,
                            ),
                          ],
                        ),
                      ),
                    ),
                    matchStreamingCategoryIndex == 1
                        ? Positioned(
                      top: height * 0.245,
                      left: width * 0.40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: width * 0.009,
                          ),
                          Container(
                            height: cardHeight / 07,
                            width: width / 05,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular((width * 0.13))),
                              color: const Color(0xFF2E2445),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black45,
                                  blurRadius: 5,
                                  spreadRadius: -1.9,
                                  offset: Offset(0.0, 0.0),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              children: const [
                                Text(
                                  'Upcomming',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  maxLines: 2,
                                  softWrap: true,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                        : Positioned(
                      top: height * 0.24,
                      left: width * 0.40,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return HomeMatchScoreScreen(
                                matchResultData: matchDataController
                                    .allMatchResultList[index],
                                liveMatchData: matchDataController
                                    .currentLiveMatchFilterList[index + 1 >
                                    matchDataController
                                        .liveMatchApiList.length
                                    ? 0
                                    : index],
                                index: index,
                              );
                            },
                          ));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: width * 0.009,
                            ),
                            Container(
                              height: cardHeight / 07,
                              width: width / 05,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.circular((width * 0.13))),
                                color: const Color(0xFF2E2445),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black45,
                                    blurRadius: 5,
                                    spreadRadius: -1.9,
                                    offset: Offset(0.0, 0.0),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: (cardHeight * 0.1) * 0.07,
                                    horizontal:
                                    (cardHeight * 0.1) * 0.5),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  children: const [
                                    FittedBox(
                                        child: Text(
                                          'View',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white),
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          )
    );
  }
}