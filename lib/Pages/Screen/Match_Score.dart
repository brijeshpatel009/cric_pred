import 'dart:convert';
import 'dart:developer';

import 'package:cric_pred/Pages/Screen/PridictionPage.dart';
import 'package:cric_pred/widget/commonWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Custom/my_icons_icons.dart';
import '../../controller/GetAllMatchController.dart';
import '../../controller/GetAllPlayerController.dart';
import '../../model/LiveScore/LiveScoreModel.dart';
import '../../model/LiveScore/MatchDataModel.dart';
import '../../model/LiveScore/MatchRunsModel.dart';
import '../../model/UpcomingMatchModel.dart';
import '../../utils/variable.dart';

class HomeMatchScoreScreen extends StatefulWidget {
  const HomeMatchScoreScreen({
    Key? key,
    required this.matchResultData,
    required this.liveMatchData,
    required this.index,
  }) : super(key: key);
  final UpComingModelAllMatch matchResultData;
  final LiveMatchModel liveMatchData;
  final int index;

  @override
  State<HomeMatchScoreScreen> createState() => _HomeMatchScoreScreenState();
}

class _HomeMatchScoreScreenState extends State<HomeMatchScoreScreen> {
  late double height = MediaQuery.of(context).size.height;
  late double width = MediaQuery.of(context).size.width;
  LiveScoreRunModel? liveMatchRun;
  MatchDataModel? liveMatchData;

  @override
  void initState() {
    super.initState();
    getAllPlayerController = Get.find()
      ..getMatchPlayerData(
          matchStreamingCategoryIndex == 1
              ? widget.matchResultData.matchId
              : widget.liveMatchData.matchId,
          0);
    liveMatchRun = LiveScoreRunModel.fromJson(jsonDecode(getMatchController
        .liveMatchApiList[
            widget.index + 1 > getMatchController.liveMatchApiList.length
                ? 0
                : widget.index]
        .jsonruns));
    liveMatchData = MatchDataModel.fromJson(jsonDecode(getMatchController
        .liveMatchApiList[
            widget.index + 1 > getMatchController.liveMatchApiList.length
                ? 0
                : widget.index]
        .jsondata));
    print(widget.matchResultData.matchId);
  }

  late GetPlayerAndRunController getAllPlayerController;
  final GetAllMatchesController getMatchController = Get.find();

  String matchDataString(String data) {
    String matchData = data;
    matchData = matchData.replaceAll('PLZ RATE US 5 STARS', '');
    matchData = matchData.replaceAll('*****', '');
    matchData =
        matchData.replaceAll('Share This App and Rate us on Playstore', '');
    return matchData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      extendBody: true,
      // appBar: AppBar(
      //   elevation: 0,
      //   flexibleSpace: Container(
      //     decoration: const BoxDecoration(
      //       image: DecorationImage(image: AssetImage('asset/appbar.png'), fit: BoxFit.fill),
      //     ),
      //     child: Padding(
      //       padding: const EdgeInsets.symmetric(horizontal: 7),
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         children: [
      //           Row(
      //             children: [
      //               GestureDetector(
      //                 onTap: () {
      //                   Navigator.pop(context);
      //                 },
      //                 child: const Icon(MyIcons.backArrow),
      //               ),
      //               Padding(
      //                 padding: const EdgeInsets.only(top: 6, bottom: 7, right: 7),
      //                 child: Container(
      //                   height: 43,
      //                   width: 43,
      //                   decoration: BoxDecoration(
      //                     color: widget.color,
      //                     borderRadius: BorderRadius.circular(100),
      //                   ),
      //                   child: Column(
      //                     mainAxisAlignment: MainAxisAlignment.center,
      //                     children: [
      //                       const Icon(MyIcons.batBall, color: Colors.white),
      //                       Text(
      //                         matchStreamingCategoryIndex == 1 ? widget.matchResultData.matchtype ?? '' : widget.liveMatchData.matchType,
      //                         style: const TextStyle(fontSize: 10, color: Colors.white),
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //               ),
      //               FittedBox(
      //                 child: Row(
      //                   children: [
      //                     Text(
      //                       matchStreamingCategoryIndex == 1 ? widget.matchResultData.teamA : widget.liveMatchData.teamA,
      //                       style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
      //                     ),
      //                     const Text(' vs '),
      //                     Text(
      //                       matchStreamingCategoryIndex == 1 ? widget.matchResultData.teamB : widget.liveMatchData.teamB,
      //                       style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      //   automaticallyImplyLeading: false,
      //   backgroundColor: Colors.transparent,
      // ),
      body: Container(
        height: double.infinity,
        color: const Color(0xff2E2445),
        child: Obx(() => getAllPlayerController.isLoading.value
            ? const Center(
                child: SizedBox(
                    height: 20, width: 20, child: CircularProgressIndicator()),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: height * 0.02, horizontal: width * 0.05),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(MyIcons.backArrow,
                              color: Colors.white),
                        ),
                      ),
                      Text(
                        matchStreamingCategoryIndex == 1
                            ? widget.matchResultData.teamA
                            : widget.liveMatchData.teamA,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 17,
                            color: Colors.white),
                      ),
                      const Text(
                        ' vs ',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 17,
                            color: Colors.white),
                      ),
                      Text(
                        matchStreamingCategoryIndex == 1
                            ? widget.matchResultData.teamB
                            : widget.liveMatchData.teamB,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 17,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.vertical(
                          top: Radius.circular(height * 0.04)),
                      child: Container(
                        color: Colors.white,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: height*0.02),
                              child: commonContainer(
                                  size: height * 0.16,
                                  child: Padding(
                                    padding: EdgeInsets.all(height*0.02),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        FittedBox(
                                          child: Row(
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(2.5),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                      Radius.circular(25),
                                                    ),
                                                    border: Border.all(
                                                        color: Colors.black)),
                                                child:
                                                    matchStreamingCategoryIndex ==
                                                            0
                                                        ? Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              SizedBox(
                                                                width:
                                                                    width * 0.01,
                                                              ),
                                                              const Text(
                                                                'Live',
                                                                style: TextStyle(
                                                                    fontSize: 12),
                                                              ),
                                                              const Icon(
                                                                Icons.circle,
                                                                color: Colors.red,
                                                                size: 6,
                                                              ),
                                                            ],
                                                          )
                                                        : Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: const [
                                                              Text('Upcoming',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12)),
                                                              Icon(
                                                                Icons.circle,
                                                                color:
                                                                    Colors.blue,
                                                                size: 6,
                                                              ),
                                                            ],
                                                          ),
                                              ),
                                              SizedBox(
                                                  width: (width * 0.9) * 0.05),
                                              Text(
                                                'Start: ${matchStreamingCategoryIndex == 1 ? widget.matchResultData.matchtime : widget.liveMatchData.matchtime}',
                                                style:
                                                    const TextStyle(fontSize: 15),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              matchStreamingCategoryIndex == 1
                                                  ? widget.matchResultData.teamA
                                                  : widget.liveMatchData.teamA,
                                              style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            SizedBox(
                                              width: width * 0.2,
                                            ),
                                            Text(getAllPlayerController
                                                    .allPlayerDataList.isEmpty
                                                ? "Match Not Started"
                                                : getAllPlayerController
                                                            .allPlayerDataList[0]
                                                            .teamRuns ==
                                                        ''
                                                    ? "in progress.."
                                                    : getAllPlayerController
                                                                .allPlayerDataList[
                                                                    0]
                                                                .teamRuns ==
                                                            "in progress.."
                                                        ? "${getAllPlayerController.allPlayerDataList[0].teamRuns}"
                                                        : "${getAllPlayerController.allPlayerDataList[0].teamRuns})")
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              matchStreamingCategoryIndex == 1
                                                  ? widget.matchResultData.teamB
                                                  : widget.liveMatchData.teamB,
                                              style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            SizedBox(
                                              width: width * 0.2,
                                            ),
                                            Text(
                                              getAllPlayerController
                                                      .allPlayerDataList.isEmpty
                                                  ? "Match Not Started"
                                                  : getAllPlayerController
                                                              .allPlayerDataList
                                                              .last
                                                              .teamRuns ==
                                                          ''
                                                      ? "in progress.."
                                                      : "${getAllPlayerController.allPlayerDataList.last.teamRuns})",
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: height * 0.001,
                                        ),
                                      ],
                                    ),
                                  )),
                            ),
                            // Padding(
                            //   padding: EdgeInsets.only(top: height * 0.02),
                            //   child: Container(
                            //       height: height * 0.11,
                            //       width: width / 1.15,
                            //       decoration: BoxDecoration(
                            //         color: const Color(0xffF1F5FE),
                            //         borderRadius: BorderRadius.all(
                            //             Radius.circular(height * 0.03)),
                            //         boxShadow: const [
                            //           BoxShadow(
                            //             color: Colors.black45,
                            //             blurRadius: 10,
                            //             spreadRadius: -1.8,
                            //             offset: Offset(0.0, 0.0),
                            //           ),
                            //         ],
                            //       ),
                            //       child: Column(
                            //         mainAxisAlignment: MainAxisAlignment.start,
                            //         crossAxisAlignment:
                            //             CrossAxisAlignment.center,
                            //         children: [
                            //           Row(
                            //             mainAxisAlignment:
                            //                 MainAxisAlignment.start,
                            //             crossAxisAlignment:
                            //                 CrossAxisAlignment.center,
                            //             children: [
                            //               Padding(
                            //                 padding: EdgeInsets.only(
                            //                     top: height * 0.02,
                            //                     left: width * 0.05),
                            //                 child: Text(
                            //                     "Who Will Win The Match ??"),
                            //               ),
                            //             ],
                            //           ),
                            //           Row(
                            //             mainAxisAlignment:
                            //                 MainAxisAlignment.start,
                            //             crossAxisAlignment:
                            //                 CrossAxisAlignment.center,
                            //             children: [
                            //               GestureDetector(
                            //                 onTap: () {},
                            //                 child: Padding(
                            //                     padding: EdgeInsets.only(top: height*0.01,left: width*0.03),
                            //                   child: Container(
                            //                     height: height*0.05,
                            //                     width: width*0.25,
                            //                     decoration: BoxDecoration(
                            //                       color: Colors.white70,
                            //                       borderRadius: BorderRadius.all(Radius.circular(height * 0.03)),
                            //                       boxShadow: const [
                            //                         BoxShadow(
                            //                           color: Colors.black45,
                            //                           blurRadius: 10,
                            //                           spreadRadius: -1.8,
                            //                           offset: Offset(0.0, 0.0),
                            //                         ),
                            //                       ],
                            //                     ),
                            //                     child: Center(
                            //                       child: Text(widget.liveMatchData.teamA,
                            //                         style: const TextStyle(
                            //                         fontSize: 15,
                            //                         fontWeight: FontWeight.w500,
                            //                         ),
                            //                       ),
                            //                     ),
                            //                   ),
                            //                 ),
                            //               ),
                            //               GestureDetector(
                            //                 onTap: () {},
                            //                 child: Padding(
                            //                     padding: EdgeInsets.only(top: height*0.01,left: width*0.03),
                            //                   child: Container(
                            //                     height: height*0.05,
                            //                     width: width*0.25,
                            //                     decoration: BoxDecoration(
                            //                       color: Colors.white70,
                            //                       borderRadius: BorderRadius.all(Radius.circular(height * 0.03)),
                            //                       boxShadow: const [
                            //                         BoxShadow(
                            //                           color: Colors.black45,
                            //                           blurRadius: 10,
                            //                           spreadRadius: -1.8,
                            //                           offset: Offset(0.0, 0.0),
                            //                         ),
                            //                       ],
                            //                     ),
                            //                     child: Center(
                            //                       child: Text("Draw",
                            //                         style: const TextStyle(
                            //                         fontSize: 15,
                            //                         fontWeight: FontWeight.w500,
                            //                         ),
                            //                       ),
                            //                     ),
                            //                   ),
                            //                 ),
                            //               ),
                            //               GestureDetector(
                            //                 onTap: () {},
                            //                 child: Padding(
                            //                     padding: EdgeInsets.only(top: height*0.01,left: width*0.03),
                            //                   child: Container(
                            //                     height: height*0.05,
                            //                     width: width*0.25,
                            //                     decoration: BoxDecoration(
                            //                       color: Colors.white70,
                            //                       borderRadius: BorderRadius.all(Radius.circular(height * 0.03)),
                            //                       boxShadow: const [
                            //                         BoxShadow(
                            //                           color: Colors.black45,
                            //                           blurRadius: 10,
                            //                           spreadRadius: -1.8,
                            //                           offset: Offset(0.0, 0.0),
                            //                         ),
                            //                       ],
                            //                     ),
                            //                     child: Center(
                            //                       child: Text(widget.liveMatchData.teamB,
                            //                         style: const TextStyle(
                            //                         fontSize: 15,
                            //                         fontWeight: FontWeight.w500,
                            //                         ),
                            //                       ),
                            //                     ),
                            //                   ),
                            //                 ),
                            //               ),
                            //             ],
                            //           ),
                            //         ],
                            //       )),
                            // ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) {
                                  return PridictionPage();
                                },));
                              },
                              child: Padding(
                                padding: EdgeInsets.only(top: height*0.02),
                                child: Container(
                                  height: height*0.04,
                                  width: width/1.35,
                                  decoration: BoxDecoration(
                                    color: const Color(0xffF1F5FE),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(height * 0.03)),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black45,
                                        blurRadius: 10,
                                        spreadRadius: -1.8,
                                        offset: Offset(0.0, 0.0),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Text("View Pridiction"),
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              child: SizedBox(
                                child: SingleChildScrollView(
                                  physics: const BouncingScrollPhysics(),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: height * 0.05,
                                      ),
                                      Text(matchStreamingCategoryIndex == 1
                                          ? "Data Not Available From Server Side"
                                          : getMatchController
                                                      .liveMatchApiList[widget
                                                                      .index +
                                                                  1 >
                                                              getMatchController
                                                                  .liveMatchApiList
                                                                  .length
                                                          ? 0
                                                          : widget.index]
                                                      .jsondata ==
                                                  ''
                                              ? "Data Is Not available\nBecause Of That Match Is Not Started"
                                              : matchDataString(liveMatchData!
                                                  .jsondata!.title!)),
                                      // Text(matchDataString(liveMatchRun?.jsonruns.summary ?? "")),
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
                  ),
                ],
              )),
      ),
    );
  }
}
