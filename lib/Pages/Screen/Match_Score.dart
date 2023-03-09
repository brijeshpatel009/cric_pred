// ignore_for_file: file_names, avoid_print

import 'dart:convert';

import 'package:cric_pred/widget/Marquee.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Custom/my_icons_icons.dart';
import '../../controller/GetAllMatchController.dart';
import '../../controller/GetAllPlayerController.dart';
import '../../dialog/score_prediction.dart';
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
  LiveScoreRunModel? liveMatchRun;
  MatchDataModel? liveMatchData;

  @override
  void initState() {
    super.initState();
    getAllPlayerController = Get.find()
      ..getMatchPlayerData(matchStreamingCategoryIndex == 1 ? widget.matchResultData.matchId : widget.liveMatchData.matchId, 0);
    liveMatchRun = LiveScoreRunModel.fromJson(
        jsonDecode(getMatchController.liveMatchApiList[widget.index + 1 > getMatchController.liveMatchApiList.length ? 0 : widget.index].jsonruns));
    liveMatchData = MatchDataModel.fromJson(
        jsonDecode(getMatchController.liveMatchApiList[widget.index + 1 > getMatchController.liveMatchApiList.length ? 0 : widget.index].jsondata));
    print(widget.matchResultData.matchId);
  }

  late GetPlayerAndRunController getAllPlayerController;
  GetAllMatchesController getMatchController = Get.find();

  String matchDataString(String data) {
    String matchData = data;
    matchData = matchData.replaceAll('PLZ RATE US 5 STARS', '');
    matchData = matchData.replaceAll('*****', '');
    matchData = matchData.replaceAll('Share This App and Rate us on Playstore', '');
    return matchData;
  }

  @override
  Widget build(BuildContext context) {
    double height = Get.height;
    double width = Get.width;
    double logoHeight = height * 0.2;
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
      body: RefreshIndicator(
        onRefresh: () async {
          getAllPlayerController = Get.put(GetPlayerAndRunController());
          getMatchController = Get.put(GetAllMatchesController());
        },
        child: Container(
          height: double.infinity,
          color: const Color(0xff2E2445),
          child: Obx(
            () => getAllPlayerController.isLoading.value
                ? const Center(
                    child: SizedBox(height: 20, width: 20, child: CircularProgressIndicator()),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SafeArea(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: height * 0.02, horizontal: width * 0.05),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(MyIcons.backArrow, color: Colors.white, size: height * 0.035),
                              ),
                              Container(
                                height: height * 0.035,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(height * 0.03)),
                                  border: Border.all(color: Colors.black),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: (height * 0.03) * 0.3),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Live',
                                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: (height * 0.03) * 0.6),
                                      ),
                                      Icon(Icons.circle, size: (height * 0.035) * 0.5, color: Colors.red),
                                    ],
                                  ),
                                ),
                              ),
                              // Text(
                              //   matchStreamingCategoryIndex == 1 ? widget.matchResultData.teamA : widget.liveMatchData.teamA,
                              //   style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 17, color: Colors.white),
                              // ),
                              // const Text(
                              //   ' vs ',
                              //   style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17, color: Colors.white),
                              // ),
                              // Text(
                              //   matchStreamingCategoryIndex == 1 ? widget.matchResultData.teamB : widget.liveMatchData.teamB,
                              //   style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 17, color: Colors.white),
                              // ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: height * 0.01, bottom: height * 0.04),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            //TeamA
                            Expanded(
                              child: Column(
                                children: [
                                  PhysicalModel(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    color: const Color(0xff2E2445),
                                    borderRadius: BorderRadius.all(Radius.circular(logoHeight * 0.1)),
                                    child: FadeInImage.assetNetwork(
                                      placeholder: 'asset/cricImg.png',
                                      image: "${widget.liveMatchData.imgeUrl}${widget.liveMatchData.teamAImage}",
                                      fit: BoxFit.cover,
                                      height: logoHeight * 0.35,
                                      width: logoHeight * 0.35,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: logoHeight * 0.03),
                                    child: MarqueeWidget(
                                      child: Text(
                                        widget.liveMatchData.teamA,
                                        style: TextStyle(
                                          fontSize: logoHeight * 0.1,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    getAllPlayerController.allPlayerDataList.isEmpty
                                        ? "Match Not Started"
                                        : getAllPlayerController.allPlayerDataList[0].teamRuns == ''
                                            ? "in progress.."
                                            : getAllPlayerController.allPlayerDataList[0].teamRuns == "in progress.."
                                                ? "${getAllPlayerController.allPlayerDataList[0].teamRuns}"
                                                : getAllPlayerController.allPlayerDataList[0].teamRuns!.contains("progress")
                                                    ? "${getAllPlayerController.allPlayerDataList[0].teamRuns}"
                                                    : "${getAllPlayerController.allPlayerDataList[0].teamRuns})",
                                    style: TextStyle(fontSize: logoHeight * 0.1, fontWeight: FontWeight.w500, color: Colors.white),
                                  ),
                                ],
                              ),
                            ),

                            //VS
                            Image.asset(
                              'asset/VS.png',
                              fit: BoxFit.contain,
                              height: logoHeight * 0.35,
                              width: logoHeight * 0.35,
                            ),

                            //TeamB
                            Expanded(
                              child: Column(
                                children: [
                                  PhysicalModel(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    color: const Color(0xff2E2445),
                                    borderRadius: BorderRadius.all(Radius.circular(logoHeight * 0.1)),
                                    child: FadeInImage.assetNetwork(
                                      placeholder: 'asset/cricImg.png',
                                      image: "${widget.liveMatchData.imgeUrl}${widget.liveMatchData.teamBImage}",
                                      fit: BoxFit.cover,
                                      height: logoHeight * 0.35,
                                      width: logoHeight * 0.35,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: logoHeight * 0.03),
                                    child: MarqueeWidget(
                                      child: Text(
                                        widget.liveMatchData.teamB,
                                        style: TextStyle(fontSize: logoHeight * 0.1, fontWeight: FontWeight.w500, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    getAllPlayerController.allPlayerDataList.isEmpty
                                        ? "Match Not Started"
                                        : getAllPlayerController.allPlayerDataList.last.teamRuns == ''
                                            ? "in progress.."
                                            : getAllPlayerController.allPlayerDataList.last.teamRuns!.contains("progress")
                                                ? "${getAllPlayerController.allPlayerDataList.last.teamRuns}"
                                                : "${getAllPlayerController.allPlayerDataList.last.teamRuns})",
                                    style: TextStyle(fontSize: logoHeight * 0.1, fontWeight: FontWeight.w500, color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(height * 0.04)),
                          child: Container(
                            width: double.infinity,
                            color: Colors.white,
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Center(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          print("click");
                                          showDialog(
                                            barrierDismissible: false,
                                            context: context,
                                            builder: (BuildContext context) {
                                              return const ScoreDialog();
                                            },
                                          );
                                          print("Click1");
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20.0), color: const Color(0xff2E2445).withOpacity(0.5)),
                                          child: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child:
                                                Text("Click Here For Prediction", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: height * 0.015),
                                      child: Text(getMatchController
                                                  .liveMatchApiList[widget.index + 1 > getMatchController.liveMatchApiList.length ? 0 : widget.index]
                                                  .jsondata ==
                                              ''
                                          ? "Data Is Not available\nBecause Of That Match Is Not Started"
                                          : matchDataString(liveMatchData!.jsondata!.title!)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
