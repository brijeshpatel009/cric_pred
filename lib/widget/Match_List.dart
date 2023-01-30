// ignore_for_file: file_names, avoid_print, library_prefixes

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../Pages/Screen/Home_Match_Scor.dart';
import '../controller/GetController.dart';
import '../model/GetAllPlayer.dart';
import '../model/News.dart';
import '../utils/variable.dart';

class MatchesList extends StatefulWidget {
  const MatchesList({Key? key, required this.itemCount}) : super(key: key);
  final int itemCount;

  @override
  State<MatchesList> createState() => _MatchesListState();
}

class _MatchesListState extends State<MatchesList> {
  late double height = MediaQuery.of(context).size.height;
  late double width = MediaQuery.of(context).size.width;
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
  }

  @override
  void dispose() {
    super.dispose();
  }

  GetDataController matchDataController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => matchDataController.isLoading.value
          ? const Center(
              child: SizedBox(height: 20, width: 20, child: CircularProgressIndicator()),
            )
          : ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(top: 15, bottom: 100),
              itemCount: matchDataController.matchResultList.length,
              itemBuilder: (context, index) {
                return Container(
                  height: height * 0.13,
                  margin: const EdgeInsets.only(
                    left: 15,
                    right: 15,
                  ),
                  child: Stack(
                    children: [
                      Container(
                        width: height * 0.115,
                        height: height * 0.115,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(blurStyle: BlurStyle.outer, color: Colors.black.withOpacity(0.4), blurRadius: 4),
                          ],
                          border: Border.all(width: (height * 0.1152) * 0.08, color: matchesColor[index]),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(170),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 3,
                        child: GestureDetector(
                          // behavior: HitTestBehavior.translucent,
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return HomeMatchScoreScreen(
                                  color: matchesColor[index],
                                  matchResultData: matchDataController.matchResultList[index],
                                );
                              },
                            ));
                            print(index);
                          },
                          child: Container(
                            width: width * 0.82,
                            height: height * 0.115,
                            decoration: BoxDecoration(
                              color: const Color(0xffFFFFFF),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xff000000).withOpacity(0.5),
                                  blurRadius: 5,
                                ),
                              ],
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: (height * 0.115) * 0.6, right: (width * 0.82) * 0.05),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  FittedBox(
                                    child: Row(
                                      children: [
                                        Text(
                                          matchDataController.matchResultList[index].teamA,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w700),
                                        ),
                                        const Text(
                                          ' vs ',
                                          style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w400),
                                        ),
                                        Text(
                                          matchDataController.matchResultList[index].teamB,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: 15,
                                        width: 30,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(color: Colors.black),
                                        ),
                                        child: Text(
                                          textAlign: TextAlign.center,
                                          matchDataController.matchResultList[index].matchtype.name,
                                          style: const TextStyle(color: Colors.black, fontSize: 11),
                                        ),
                                      ),
                                      matchStreamingCategoryIndex == 0
                                          ? Row(
                                              children: const [
                                                Text('Live'),
                                                Icon(
                                                  Icons.circle,
                                                  size: 8,
                                                  color: Colors.red,
                                                ),
                                              ],
                                            )
                                          : Row(
                                              children: const [
                                                Text('Upcoming'),
                                                Icon(
                                                  Icons.circle,
                                                  size: 8,
                                                  color: Colors.blue,
                                                ),
                                              ],
                                            ),
                                    ],
                                  ),
                                  Text(
                                    matchDataController.matchResultList[index].matchtime,
                                    style: const TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: width * 0.025,
                        top: (height * 0.115) * 0.1,
                        child: Container(
                          height: (height * 0.115) * 0.8,
                          width: (height * 0.115) * 0.8,
                          decoration: BoxDecoration(
                            color: matchesColor[index],
                            borderRadius: BorderRadius.circular(165),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Image(image: AssetImage('asset/cricImg.png'), height: 30),
                              Text(
                                matchDataController.matchResultList[index].matchtype.name,
                                style: const TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}