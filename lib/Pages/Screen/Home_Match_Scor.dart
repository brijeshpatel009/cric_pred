// ignore_for_file: file_names, avoid_print

import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Custom/my_icons_icons.dart';
import '../../controller/GetAllMatchController.dart';
import '../../controller/GetAllPlayerController.dart';
import '../../model/LiveScore/LiveScoreModel.dart';
import '../../model/LiveScore/MatchDataModel.dart';
import '../../model/LiveScore/MatchRunsModel.dart';
import '../../model/MatchesResult.dart';
import '../../utils/variable.dart';

class HomeMatchScoreScreen extends StatefulWidget {
  const HomeMatchScoreScreen({
    Key? key,
    required this.color,
    required this.matchResultData,
    required this.liveMatchData,
    required this.index,
  }) : super(key: key);
  final Color color;
  final AllMatchData matchResultData;
  final LiveScoreModel liveMatchData;
  final int index;

  @override
  State<HomeMatchScoreScreen> createState() => _HomeMatchScoreScreenState();
}

class _HomeMatchScoreScreenState extends State<HomeMatchScoreScreen> {
  late double height = MediaQuery.of(context).size.height;
  late double width = MediaQuery.of(context).size.width;
  // int run = Random().nextInt(200);
  // int runs = Random().nextInt(200);
  // int wickets = Random().nextInt(12);
  // int wicket = Random().nextInt(12);
  // double over = Random().nextDouble() * 20.0;
  static const int _len = 5;
  LiveScoreRunModel? liveMatchRun;
  MatchDataModel? liveMatchData;

  @override
  void initState() {
    super.initState();
    getPlayerController = Get.put(GetPlayerAndRunController())
      ..getMatchPlayerData(matchStreamingCategoryIndex == 0 ? widget.matchResultData.matchId!.toInt()
          : widget.liveMatchData.matchId);
    liveMatchRun = LiveScoreRunModel.fromJson(jsonDecode(getMatchController.liveMatchScoreList[widget.index].jsonruns));
    liveMatchData = MatchDataModel.fromJson(jsonDecode(getMatchController.liveMatchScoreList[widget.index].jsondata));
    print(getPlayerController.allPlayerDataList[0].teamRuns);
  }

  late GetPlayerAndRunController getPlayerController;
  late GetAllMatchesController getMatchController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage('asset/appbar.png'), fit: BoxFit.fill),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(MyIcons.backArrow),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 6, bottom: 7, right: 7),
                      child: Container(
                        height: 43,
                        width: 43,
                        decoration: BoxDecoration(
                          color: widget.color,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(MyIcons.batBall, color: Colors.white),
                            Text(
                              matchStreamingCategoryIndex == 0 ? widget.matchResultData.matchtype ?? ""
                                  : widget.liveMatchData.matchType,
                              style: const TextStyle(fontSize: 10, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    FittedBox(
                      child: Row(
                        children: [
                          Text(
                            matchStreamingCategoryIndex == 0 ? widget.matchResultData.teamA ?? ""
                                : widget.liveMatchData.teamA,
                            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
                          ),
                          const Text(' vs '),
                          Text(
                            matchStreamingCategoryIndex == 0 ? widget.matchResultData.teamB ?? ""
                                : widget.liveMatchData.teamB,
                            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('asset/background.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: height * 0.05,
              ),
              Container(
                width: width * 0.9,
                height: height * 0.13,
                decoration: const BoxDecoration(
                  color: Color(0xffFFFFFF),
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 5,
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(2.5),
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(25),
                                ),
                                border: Border.all(color: Colors.black)),
                            child: matchStreamingCategoryIndex == 0
                                ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  'Live',
                                  style: TextStyle(fontSize: 12),
                                ),
                                Icon(
                                  Icons.circle,
                                  color: Colors.red,
                                  size: 8,
                                ),
                              ],
                            )
                                : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text('Upcoming', style: TextStyle(fontSize: 12)),
                                Icon(
                                  Icons.circle,
                                  color: Colors.blue,
                                  size: 8,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: (width * 0.9) * 0.03),
                          Text(
                            'Start: ${matchStreamingCategoryIndex == 0 ? widget.matchResultData.matchtime : widget.liveMatchData.matchtime}',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${ matchStreamingCategoryIndex == 0 ? liveMatchData!.jsondata!.teamA ?? ""
                                  : liveMatchData!.jsondata!.teamA } (B)',
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(matchStreamingCategoryIndex == 0 ? "${liveMatchRun!.jsonruns.runxa}/${liveMatchData!.jsondata!.wicketA} (${liveMatchData!.jsondata!.wicketA})" : "${liveMatchRun?.jsonruns.fav}"),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${matchStreamingCategoryIndex == 0 ? liveMatchData!.jsondata!.teamB ?? ""
                                  : liveMatchData!.jsondata!.teamB} (W)',
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(matchStreamingCategoryIndex == 0 ? "${liveMatchRun!.jsonruns.runxa}/${liveMatchData!.jsondata!.wicketB} (${liveMatchData!.jsondata!.oversB})" : "${liveMatchRun?.jsonruns.fav}"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              Flexible(
                child: SizedBox(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Text('${liveMatchData?.jsondata?.title} '),
                        const Divider(
                          color: Colors.black,
                        ),
                        Text('${liveMatchRun?.jsonruns.summary}'),
                        Text(share)
                      ],
                    ),
                  ),
                ),
                // ListView.builder(
                //   itemCount: _len,
                //   itemBuilder: (context, index) {
                //     return Container(
                //       margin: EdgeInsets.only(bottom: height * 0.02, right: width * 0.06, left: width * 0.06),
                //       height: height * 0.1,
                //       decoration: const BoxDecoration(
                //         color: Color(0xff9BDCFF),
                //         borderRadius: BorderRadius.all(
                //           Radius.circular(15),
                //         ),
                //       ),
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           const Padding(
                //             padding: EdgeInsets.only(left: 5),
                //             child: Text(
                //               'Who win the match?',
                //             ),
                //           ),
                //           Container(
                //             width: width * 0.35,
                //             decoration: const BoxDecoration(
                //               color: Color(0xff70CDFF),
                //               borderRadius: BorderRadius.only(
                //                 topRight: Radius.circular(15),
                //                 bottomRight: Radius.circular(15),
                //               ),
                //             ),
                //             child: Padding(
                //               padding: EdgeInsets.symmetric(horizontal: (width * 0.35) * 0.1, vertical: (height * 0.08) * 0.1),
                //               child: Column(
                //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //                 children: [
                //                   Container(
                //                     height: (height * 0.11) * 0.35,
                //                     decoration: BoxDecoration(
                //                       border: Border.all(color: Colors.black, width: 1),
                //                       borderRadius: BorderRadius.circular(5),
                //                     ),
                //                     child: FittedBox(
                //                       child: Padding(
                //                         padding: const EdgeInsets.symmetric(horizontal: 2),
                //                         child: Row(
                //                           children: [
                //                             Text(matchStreamingCategoryIndex == 0 ? widget.matchResultData.teamA : widget.liveMatchData.teamA,
                //                                 style: const TextStyle(fontSize: 10)),
                //                             const Text(
                //                               '(0.0)',
                //                               style: TextStyle(fontSize: 10),
                //                             ),
                //                           ],
                //                         ),
                //                       ),
                //                     ),
                //                   ),
                //                   Container(
                //                     height: (height * 0.11) * 0.35,
                //                     decoration: BoxDecoration(
                //                       border: Border.all(color: Colors.black, width: 1),
                //                       borderRadius: BorderRadius.circular(5),
                //                     ),
                //                     child: FittedBox(
                //                       child: Padding(
                //                         padding: const EdgeInsets.symmetric(horizontal: 2),
                //                         child: Row(
                //                           children: [
                //                             Text(
                //                               matchStreamingCategoryIndex == 0 ? widget.matchResultData.teamB : widget.liveMatchData.teamB,
                //                               style: const TextStyle(fontSize: 5),
                //                             ),
                //                             const Text(
                //                               '(0.0)',
                //                               style: TextStyle(fontSize: 5),
                //                             ),
                //                           ],
                //                         ),
                //                       ),
                //                     ),
                //                   ),
                //                 ],
                //               ),
                //             ),
                //           ),
                //         ],
                //       ),
                //     );
                //   },
                // ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String share = "gla National Stadium, Dhaka \\n\\n\\nShare This App and Rate us on Playstore\\n\n ";
}