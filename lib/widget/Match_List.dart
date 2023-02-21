// ignore_for_file: file_names, avoid_print, library_prefixes, unused_local_variable

import 'package:cric_pred/Pages/Screen/Match_Score.dart';
import 'package:cric_pred/Pages/Screen/Team_Screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../controller/GetAllMatchController.dart';
import '../model/GetAllPlayerModel.dart';
import '../model/NewsModel.dart';
import '../utils/variable.dart';
import 'commonWidget.dart';

class MatchesList extends StatefulWidget {
  const MatchesList({Key? key, required this.matchStreamingCategoryIndex})
      : super(key: key);
  final int matchStreamingCategoryIndex;

  @override
  State<MatchesList> createState() => _MatchesListState();
}

class _MatchesListState extends State<MatchesList> {
  String? date;
  late double height = MediaQuery
      .of(context)
      .size
      .height;
  late double width = MediaQuery
      .of(context)
      .size
      .width;

  List<Color> matchesColor = [
    const Color(0xff525298),
    const Color(0xff42BDFE),
    const Color(0xffDD52E1),
    const Color(0xffFCBC03),
    const Color(0xff21B07E),
    const Color(0xff0505DD),
    const Color(0xff525298),
    const Color(0xff42BDFE),
    const Color(0xffDD52E1),
    const Color(0xffFCBC03),
    const Color(0xff21B07E),
    const Color(0xff0505DD),
    const Color(0xff525298),
    const Color(0xff42BDFE),
    const Color(0xffDD52E1),
    const Color(0xffFCBC03),
    const Color(0xff21B07E),
    const Color(0xff0505DD),
    const Color(0xff525298),
    const Color(0xff42BDFE),
    const Color(0xffDD52E1),
    const Color(0xffFCBC03),
    const Color(0xff21B07E),
    const Color(0xff0505DD),
    const Color(0xff525298),
    const Color(0xff42BDFE),
    const Color(0xffDD52E1),
    const Color(0xffFCBC03),
    const Color(0xff21B07E),
    const Color(0xff0505DD),
    const Color(0xff525298),
    const Color(0xff42BDFE),
    const Color(0xffDD52E1),
    const Color(0xffFCBC03),
    const Color(0xff21B07E),
    const Color(0xff0505DD),
    const Color(0xff525298),
    const Color(0xff42BDFE),
    const Color(0xffDD52E1),
    const Color(0xffFCBC03),
    const Color(0xff21B07E),
    const Color(0xff0505DD),
    const Color(0xff525298),
    const Color(0xff42BDFE),
    const Color(0xffDD52E1),
    const Color(0xffFCBC03),
    const Color(0xff21B07E),
    const Color(0xff0505DD),
    const Color(0xff525298),
    const Color(0xff42BDFE),
    const Color(0xffDD52E1),
    const Color(0xffFCBC03),
    const Color(0xff21B07E),
    const Color(0xff0505DD),
    const Color(0xff525298),
    const Color(0xff42BDFE),
    const Color(0xffDD52E1),
    const Color(0xffFCBC03),
    const Color(0xff21B07E),
    const Color(0xff0505DD),
    const Color(0xff525298),
    const Color(0xff42BDFE),
    const Color(0xffDD52E1),
    const Color(0xffFCBC03),
    const Color(0xff21B07E),
    const Color(0xff0505DD),
    const Color(0xff525298),
    const Color(0xff42BDFE),
    const Color(0xffDD52E1),
    const Color(0xffFCBC03),
    const Color(0xff21B07E),
    const Color(0xff0505DD),
    const Color(0xff525298),
    const Color(0xff42BDFE),
    const Color(0xffDD52E1),
    const Color(0xffFCBC03),
    const Color(0xff21B07E),
    const Color(0xff0505DD),
    const Color(0xff525298),
    const Color(0xff42BDFE),
    const Color(0xffDD52E1),
    const Color(0xffFCBC03),
    const Color(0xff21B07E),
    const Color(0xff0505DD),
    const Color(0xff525298),
    const Color(0xff42BDFE),
    const Color(0xffDD52E1),
    const Color(0xffFCBC03),
    const Color(0xff21B07E),
    const Color(0xff0505DD),
  ];

  // String? date;

  // String getSystemTime() {
  //   var now = DateTime.now();
  //   return DateFormat("dd MMM yyyy - hh:mm EEE").format(now);
  // }

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

  @override
  void initState() {
    // initSocket();
    super.initState();
    // String cDate = DateFormat("dd-MMM-yyyy hh:mma-EEE").format(DateTime.now());
    // DateTime dt1 = DateTime.parse("2021-12-23 11:47:00");
    // DateTime dt = DateTime.parse('2020-01-02 03:04:05');
  }

  final GetAllMatchesController matchDataController = Get.find();

  DateTime curruntDate = DateTime.now();

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
          : ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(top: 15, bottom: 100),
              itemCount:
                  matchStreamingCategoryIndex == 1 ? matchDataController.allMatchResultList.length : matchDataController.liveMatchApiList.length,
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
                                          crossAxisAlignment: CrossAxisAlignment.center,
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
                                SizedBox(height: cardHeight * 0.1,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //TeamA
                                    Row(
                                      children: [
                                        Column(
                                          children: [
                                            SizedBox(
                                              height: cardHeight * 0.25,
                                              width: cardHeight * 0.25,
                                              child: Image.network(
                                                "${matchDataController.allMatchResultList[index].imageUrl}${matchDataController.allMatchResultList[index].teamAImage}",
                                              ),
                                            ),
                                            Text(
                                              matchDataController.allMatchResultList[index].teamA ?? '',
                                              style: const TextStyle(fontWeight: FontWeight.w500),
                                            ),
                                            matchStreamingCategoryIndex == 0 ?
                                            Padding(
                                              padding: EdgeInsets.only(top: cardHeight *0.05),
                                              child: const Text(
                                                "150/02",
                                                style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20),
                                              ),
                                            )
                                                : const Text(''),
                                            matchStreamingCategoryIndex == 0 ?
                                            const Text(
                                              "(20.5 over)",
                                              style: TextStyle(fontWeight: FontWeight.w500),
                                            ) : const Text(""),
                                          ],
                                        ),
                                      ],
                                    ),
                                    //VS
                                    Image.asset(
                                      'asset/VS.png',
                                      fit: BoxFit.contain,
                                      height: cardHeight * 0.4,
                                      width: cardHeight * 0.4,
                                    ),
                                    //TeamB
                                    Column(
                                      children: [
                                        SizedBox(
                                          height: cardHeight * 0.25,
                                          width: cardHeight * 0.25,
                                          child: Image.network(
                                            "${matchDataController.allMatchResultList[index].imageUrl}${matchDataController.allMatchResultList[index].teamBImage}",
                                          ),
                                        ),
                                        Text(
                                          matchDataController.allMatchResultList[index].teamB ?? '',
                                          style: const TextStyle(fontWeight: FontWeight.w500),
                                        ),
                                        matchStreamingCategoryIndex == 0 ?
                                        Padding(
                                          padding: EdgeInsets.only(top: cardHeight *0.05),
                                          child: const Text(
                                            "280/06",
                                            style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20),
                                          ),
                                        ) : const Text(""),
                                        matchStreamingCategoryIndex == 0 ?
                                        const Text(
                                          "(50 over)",
                                          style: TextStyle(fontWeight: FontWeight.w500),
                                        ) : const Text(""),
                                      ],
                                    )
                                  ],
                                ),
                                matchStreamingCategoryIndex == 0 ?
                                const Text("") :
                                Text(matchStreamingCategoryIndex == 0
                                                  ? matchDataController.liveMatchList[index].matchtime
                                                  : matchDataController.allMatchResultList[index].matchtime ?? "",
                                              style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 1),
                                ),
                                matchStreamingCategoryIndex == 0 ?
                                 const SizedBox(height: 01)
                                : SizedBox(height: height*0.01,),
                              ],
                            ),
                          ),
                      ),
                      matchStreamingCategoryIndex == 0 ?
                      Positioned(
                        top: height * 0.24,
                        left: width * 0.40,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return HomeMatchScoreScreen(
                                              color: matchesColor[index],
                                              matchResultData: matchDataController.allMatchResultList[index],
                                              liveMatchData: matchDataController.liveMatchList[index + 1 > matchDataController.liveMatchList.length ? 0 : index],
                                              index: index,
                                            );
                            },));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(width: width*0.009,),
                              Container(
                                height: cardHeight/07,
                                width: width/05,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular((width * 0.13))),
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
                                  padding: EdgeInsets.symmetric(vertical: (cardHeight * 0.1) * 0.07, horizontal: (cardHeight * 0.1) * 0.5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: const [
                                      FittedBox(
                                          child: Text(
                                            'View',
                                            style: TextStyle(fontWeight: FontWeight.w500,color: Colors.white),
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      : Positioned(
                        top: height * 0.24,
                        left: width * 0.40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(width: width*0.009,),
                            Container(
                              height: cardHeight/07,
                              width: width/05,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular((width * 0.13))),
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Text(
                                    'Upcomming',
                                    style: TextStyle(fontWeight: FontWeight.w500,color: Colors.white,overflow: TextOverflow.ellipsis,),
                                    maxLines: 2,
                                    softWrap: true,
                                  ),
                                ],
                              ),
                            ),
                          ],
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
