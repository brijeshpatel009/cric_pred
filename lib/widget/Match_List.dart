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

import '../Pages/Screen/Match_Score.dart';
import '../controller/GetAllMatchController.dart';
import '../model/GetAllPlayerModel.dart';
import '../model/LiveScore/MatchDataModel.dart';
import '../model/NewsModel.dart';
import '../utils/variable.dart';
import 'Marquee.dart';
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
            )
          : matchDataController.currentLiveMatchFilterList.isEmpty && matchStreamingCategoryIndex == 0
              ? const Center(
                  child: Text(
                    'Currently Not Live Any Match',
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
                      : matchDataController.currentLiveMatchFilterList.isEmpty
                          ? 1
                          : matchDataController.currentLiveMatchFilterList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: height * 0.02),
                      child: Stack(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return HomeMatchScoreScreen(
                                    color: Colors.orange,
                                    matchResultData: matchDataController.upcomingMatchApiList[index],
                                    liveMatchData: matchDataController
                                        .currentLiveMatchFilterList[index + 1 > matchDataController.currentLiveMatchFilterList.length ? 0 : index],
                                    index: index,
                                  );
                                },
                              ));
                            },
                            child: commonContainer(
                              size: cardHeight,
                              radius: cardHeight * 0.3,
                              child: Padding(
                                padding: EdgeInsets.all(cardHeight * 0.08),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(bottom: cardHeight * 0.05),
                                      child: Row(
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
                                              padding:
                                                  EdgeInsets.symmetric(vertical: (cardHeight * 0.1) * 0.07, horizontal: (cardHeight * 0.1) * 0.5),
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
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        //TeamA
                                        ClipRRect(
                                          borderRadius: BorderRadius.all(Radius.circular(cardHeight * 0.1)),
                                          child: Image.network(
                                            matchStreamingCategoryIndex == 1
                                                ? "${matchDataController.upcomingMatchApiList[index].imageUrl}${matchDataController.upcomingMatchApiList[index].teamAImage}"
                                                : "${matchDataController.currentLiveMatchFilterList[index].imgeUrl}${matchDataController.currentLiveMatchFilterList[index].teamAImage}",
                                            height: cardHeight * 0.35,
                                            width: cardHeight * 0.35,
                                            fit: BoxFit.cover,
                                          ),
                                        ),

                                        //VS
                                        Image.asset(
                                          'asset/VS.png',
                                          fit: BoxFit.contain,
                                          height: cardHeight * 0.35,
                                          width: cardHeight * 0.35,
                                        ),

                                        //TeamB
                                        ClipRRect(
                                          borderRadius: BorderRadius.all(Radius.circular(cardHeight * 0.1)),
                                          child: Image.network(
                                            matchStreamingCategoryIndex == 1
                                                ? "${matchDataController.upcomingMatchApiList[index].imageUrl}${matchDataController.upcomingMatchApiList[index].teamBImage}"
                                                : "${matchDataController.currentLiveMatchFilterList[index].imgeUrl}${matchDataController.currentLiveMatchFilterList[index].teamBImage}",
                                            height: cardHeight * 0.35,
                                            width: cardHeight * 0.35,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        MarqueeWidget(
                                          child: Text(
                                            matchStreamingCategoryIndex == 1
                                                ? matchDataController.upcomingMatchApiList[index].teamA
                                                : matchDataController.currentLiveMatchFilterList[index].teamA,
                                            style: TextStyle(fontSize: cardHeight * 0.08, fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        MarqueeWidget(
                                          child: Text(
                                            matchStreamingCategoryIndex == 1
                                                ? matchDataController.upcomingMatchApiList[index].teamB
                                                : matchDataController.currentLiveMatchFilterList[index].teamB,
                                            style: TextStyle(fontSize: cardHeight * 0.08, fontWeight: FontWeight.w500),
                                          ),
                                        )
                                      ],
                                    ),
                                    if (matchStreamingCategoryIndex == 1)
                                      Text(
                                        matchDataController.upcomingMatchApiList[index].matchtime,
                                        style: TextStyle(fontSize: cardHeight * 0.08, fontWeight: FontWeight.w500),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                    //   Container(
                    //   height: height * 0.13,
                    //   margin: const EdgeInsets.only(
                    //     left: 15,
                    //     right: 15,
                    //   ),
                    //   child: GestureDetector(
                    //     onTap: () {
                    //       Navigator.push(context, MaterialPageRoute(
                    //         builder: (context) {
                    //           return HomeMatchScoreScreen(
                    //             color: matchesColor[index],
                    //             matchResultData: matchDataController.allMatchResultList[index],
                    //             liveMatchData: matchDataController.liveMatchList[index + 1 > matchDataController.liveMatchList.length ? 0 : index],
                    //             index: index,
                    //           );
                    //         },
                    //       ));
                    //     },
                    //     child: Container(
                    //       width: width * 0.82,
                    //       height: height * 0.115,
                    //       decoration: BoxDecoration(
                    //         color: const Color(0xffFFFFFF),
                    //         boxShadow: [
                    //           BoxShadow(
                    //             color: const Color(0xff000000).withOpacity(0.5),
                    //             blurRadius: 5,
                    //           ),
                    //         ],
                    //         borderRadius: const BorderRadius.only(
                    //           topRight: Radius.circular(10),
                    //           bottomRight: Radius.circular(10),
                    //         ),
                    //       ),
                    //       child: Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //         children: [
                    //           FittedBox(
                    //             child: Row(
                    //               children: [
                    //                 Text(
                    //                   matchStreamingCategoryIndex == 1
                    //                       ? matchDataController.allMatchResultList[index].teamA ?? ""
                    //                       : matchDataController.liveMatchList[index].teamA,
                    //                   overflow: TextOverflow.ellipsis,
                    //                   style: const TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w700, letterSpacing: 0.5),
                    //                 ),
                    //                 const Text(
                    //                   ' vs ',
                    //                   style: TextStyle(
                    //                     fontSize: 15,
                    //                     color: Colors.black,
                    //                     fontWeight: FontWeight.w400,
                    //                   ),
                    //                 ),
                    //                 Text(
                    //                   matchStreamingCategoryIndex == 1
                    //                       ? matchDataController.allMatchResultList[index].teamB ?? ""
                    //                       : matchDataController.liveMatchList[index].teamB,
                    //                   overflow: TextOverflow.ellipsis,
                    //                   style: const TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w700, letterSpacing: 0.5),
                    //                 ),
                    //               ],
                    //             ),
                    //           ),
                    //           Row(
                    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //             children: [
                    //               Container(
                    //                 height: 15,
                    //                 width: 30,
                    //                 decoration: BoxDecoration(
                    //                   borderRadius: BorderRadius.circular(10),
                    //                   border: Border.all(color: Colors.black),
                    //                 ),
                    //                 child: FittedBox(
                    //                   child: Text(
                    //                     textAlign: TextAlign.center,
                    //                     matchStreamingCategoryIndex == 1
                    //                         ? matchDataController.allMatchResultList[index].matchtype ?? ""
                    //                         : matchDataController.liveMatchList[index].matchType,
                    //                     style: const TextStyle(
                    //                       color: Colors.black,
                    //                     ),
                    //                   ),
                    //                 ),
                    //               ),
                    //               matchStreamingCategoryIndex == 0
                    //                   ? Row(
                    //                       children: [
                    //                         const Text('Live'),
                    //                         SizedBox(
                    //                           width: width * 0.015,
                    //                         ),
                    //                         Icon(
                    //                           Icons.circle,
                    //                           size: width * 0.022,
                    //                           color: Colors.red,
                    //                         ),
                    //                       ],
                    //                     )
                    //                   : Row(
                    //                       children: [
                    //                         const Text('Upcoming'),
                    //                         SizedBox(
                    //                           width: width * 0.015,
                    //                         ),
                    //                         Icon(
                    //                           Icons.circle,
                    //                           size: width * 0.022,
                    //                           color: Colors.blue,
                    //                         ),
                    //                       ],
                    //                     ),
                    //             ],
                    //           ),
                    //           Text(
                    //             matchStreamingCategoryIndex == 1
                    //                 ? matchDataController.allMatchResultList[index].matchtime ?? ""
                    //                 : matchDataController.liveMatchList[index].matchtime,
                    //             style: const TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.w400, letterSpacing: 1),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // );
                  },
                ),
    );
  }
}