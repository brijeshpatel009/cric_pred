// ignore_for_file: file_names, avoid_print, library_prefixes, unused_local_variable

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
  const MatchesList({Key? key, required this.matchStreamingCategoryIndex}) : super(key: key);
  final int matchStreamingCategoryIndex;

  @override
  State<MatchesList> createState() => _MatchesListState();
}

class _MatchesListState extends State<MatchesList> {
  String? date;

  String getSystemTime() {
    var now = DateTime.now();
    return DateFormat("dd MMM - hh:mm a").format(now);
  }

  late IO.Socket socket;

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
    String cDate = DateFormat("dd-MMM-yyyy hh:mma-EEE").format(DateTime.now());
    DateTime dt1 = DateTime.parse("2021-12-23 11:47:00");
    DateTime dt = DateTime.parse('2020-01-02 03:04:05');
  }

  final GetAllMatchesController matchDataController = Get.find();

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
              itemCount: matchStreamingCategoryIndex == 1 ? matchDataController.allMatchResultList.length : matchDataController.liveMatchList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: height * 0.02),
                  child: commonContainer(
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //TeamA
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
                                  )
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
                                  )
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
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
