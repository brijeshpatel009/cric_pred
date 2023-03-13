// ignore_for_file: file_names, avoid_print, library_prefixes, unused_local_variable, use_build_context_synchronously

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../Pages/Screen/Match_Score.dart';
import '../controller/GetAllMatchController.dart';
import '../model/GetAllPlayerModel.dart';
import '../model/LiveScore/MatchDataModel.dart';
import '../model/NewsModel.dart';
import '../services/AdsHelper/ads_helper.dart';
import '../utils/String.dart';
import '../utils/variable.dart';
import 'CountDown.dart';
import 'Marquee.dart';
import 'commonWidget.dart';

class MatchesList extends StatefulWidget {
  const MatchesList({Key? key}) : super(key: key);

  @override
  State<MatchesList> createState() => _MatchesListState();
}

class _MatchesListState extends State<MatchesList> {
  String? date;
  late IO.Socket socket;
  late GetAllMatchesController matchDataController;
  List<MatchDataModel> matchDataList = [];

  int randomInt() {
    var num = 0;
    num = Random().nextInt(3) + 1;
    return num;
  }

  initSocket() {
    socket = IO.io("https://soccer-battle-2023.onrender.com/", <String, dynamic>{
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

  @override
  void initState() {
    // initSocket();
    super.initState();
    matchDataController = Get.put(GetAllMatchesController());
  }

  @override
  Widget build(BuildContext context) {
    double height = Get.height;
    double width = Get.width;
    double cardHeight = height * 0.15;
    return Obx(
      () => matchDataController.isLoading.value
          ? Center(
              child: SizedBox(height: height * 0.04, width: height * 0.04, child: const CircularProgressIndicator()),
            )
          : matchDataController.currentLiveMatchFilterList.isEmpty && matchStreamingCategoryIndex == 0
              ? Center(
                  child: Text(
                    Strings.matchNotLiveText,
                    style: TextStyle(color: const Color(0xff2E2445), fontWeight: FontWeight.w500, letterSpacing: 0.8, fontSize: height * 0.02),
                  ),
                )
              : ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(top: 15, bottom: 100),
                  itemCount: matchStreamingCategoryIndex == 1
                      ? matchDataController.upcomingMatchTeamA.length
                      : matchDataController.currentLiveMatchFilterList.isEmpty
                          ? 1
                          : matchDataController.currentLiveMatchFilterList.length,
                  separatorBuilder: (context, index) {
                    if ((index + 1) % randomInt() == 0) {
                      print(">>>>>>>>>>>>>>>>>${(index + 1) % randomInt()}");
                      return SizedBox(width: width, child: const BannerAdView());
                    } else {
                      return Container();
                    }
                  },
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: height * 0.005),
                      child: Stack(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              // await AdsHelper.showInterstitialAds();
                              if (matchStreamingCategoryIndex == 0) {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return HomeMatchScoreScreen(
                                      liveMatchData: matchDataController.currentLiveMatchFilterList[index],
                                    );
                                  },
                                ));
                              }
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
                                            height: cardHeight * 0.13,
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
                                                    matchStreamingCategoryIndex == 0 ? Strings.live : Strings.upcoming,
                                                    style: const TextStyle(fontWeight: FontWeight.w500),
                                                  )),
                                                  FittedBox(
                                                    child: Icon(
                                                      Icons.circle,
                                                      size: width * 0.022,
                                                      color: matchStreamingCategoryIndex == 0 ? Colors.red : Colors.blue,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        //TeamA
                                        Expanded(
                                          child: Column(
                                            children: [
                                              PhysicalModel(
                                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                                color: const Color(0xff2E2445),
                                                borderRadius: BorderRadius.all(Radius.circular(cardHeight * 0.1)),
                                                child: FadeInImage.assetNetwork(
                                                  placeholder: 'asset/cricImg.png',
                                                  image: matchStreamingCategoryIndex == 1
                                                      ? matchDataController.upcomingMatchImageurlA[index]
                                                      : "${matchDataController.currentLiveMatchFilterList[index].imgeUrl}${matchDataController.currentLiveMatchFilterList[index].teamAImage}",
                                                  fit: BoxFit.cover,
                                                  height: cardHeight * 0.35,
                                                  width: cardHeight * 0.35,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(top: cardHeight * 0.03),
                                                child: MarqueeWidget(
                                                  child: Text(
                                                    matchStreamingCategoryIndex == 1
                                                        ? matchDataController.upcomingMatchTeamA[index]
                                                        : matchDataController.currentLiveMatchFilterList[index].teamA,
                                                    style: TextStyle(
                                                      fontSize: cardHeight * 0.1,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
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
                                        Expanded(
                                          child: Column(
                                            children: [
                                              PhysicalModel(
                                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                                color: const Color(0xff2E2445),
                                                borderRadius: BorderRadius.all(Radius.circular(cardHeight * 0.1)),
                                                child: FadeInImage.assetNetwork(
                                                  placeholder: 'asset/cricImg.png',
                                                  image: matchStreamingCategoryIndex == 1
                                                      ? matchDataController.upcomingMatchImageurlB[index]
                                                      : "${matchDataController.currentLiveMatchFilterList[index].imgeUrl}${matchDataController.currentLiveMatchFilterList[index].teamBImage}",
                                                  fit: BoxFit.cover,
                                                  height: cardHeight * 0.35,
                                                  width: cardHeight * 0.35,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(top: cardHeight * 0.03),
                                                child: MarqueeWidget(
                                                  child: Text(
                                                    matchStreamingCategoryIndex == 1
                                                        ? matchDataController.upcomingMatchTeamB[index]
                                                        : matchDataController.currentLiveMatchFilterList[index].teamB,
                                                    style: TextStyle(fontSize: cardHeight * 0.1, fontWeight: FontWeight.w500),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    if (matchStreamingCategoryIndex == 1)
                                      Text(
                                        matchDataController.upcomingMatchTime[index],
                                        style: TextStyle(
                                          fontSize: cardHeight * 0.1,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: (height * 0.015) * 0.2,
                            right: width * 0.4,
                            left: width * 0.4,
                            child: Container(
                              height: cardHeight * 0.18,
                              decoration: BoxDecoration(
                                color: const Color(0xff2E2445),
                                borderRadius: BorderRadius.all(Radius.circular(cardHeight * 0.18)),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black45,
                                    blurRadius: 10,
                                    spreadRadius: -1.8,
                                    offset: Offset(0.0, 0.0),
                                  )
                                ],
                              ),
                              child: Center(
                                child: MarqueeWidget(
                                  child: Text(
                                    matchStreamingCategoryIndex == 1
                                        ? CountDown().timeLeft(
                                            matchDataController.yourParserOrDateTimeParse(matchDataController.upcomingMatchTime[index]),
                                          )
                                        : CountDown().timeLeft(
                                            matchDataController
                                                .yourParserOrDateTimeParse(matchDataController.currentLiveMatchFilterList[index].matchtime),
                                          ),
                                    style: TextStyle(fontSize: (cardHeight * 0.18) * 0.65, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
    );
  }

  void update() async {
    Timer.periodic(Duration(seconds: 1), (timer) {});
  }
}
