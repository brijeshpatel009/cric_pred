// ignore_for_file: file_names, avoid_print

import 'dart:async';
import 'dart:convert';

import 'package:ads_helper/ads_helper.dart';
import 'package:cric_pred/widget/Marquee.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../CustomIcon/my_icons_icons.dart';
import '../../controller/GetAllMatchController.dart';
import '../../dialog/score_prediction.dart';
import '../../helper/firebase_remote_config.dart';
import '../../utils/Colors.dart';
import '../../utils/String_Style.dart';
import '../../utils/utils.dart';
import 'model/LiveScore/MatchDataModel.dart';

class HomeMatchScoreScreen extends StatefulWidget {
  const HomeMatchScoreScreen({Key? key, required this.jsonData, required this.teamAName, required this.jsonruns}) : super(key: key);
  final String jsonData;
  final String teamAName;
  final String jsonruns;

  @override
  State<HomeMatchScoreScreen> createState() => _HomeMatchScoreScreenState();
}

class _HomeMatchScoreScreenState extends State<HomeMatchScoreScreen> {
  @override
  void initState() {
    super.initState();
    // liveMatchRun = LiveScoreRunModel.fromJson(jsonDecode(widget.jsonruns));

    liveMatchData = MatchDataModel.fromJson(jsonDecode(widget.jsonData));
    // print("InitState Refresh");
    // SocketHelper.liveMatchInit(index: widget.index);

    _timer = Timer.periodic(const Duration(seconds: 3), (timer) async {
      allMatchData = await Get.put(GetAllMatch())
        ..getLiveMatch();
      for (var map in allMatchData.currentLiveMatchFilterList) {
        if (map.teamA == widget.teamAName) {
          print(map.teamA);
          liveMatchData = MatchDataModel.fromJson(jsonDecode(map.jsondata));
          // liveMatchRun = LiveScoreRunModel.fromJson(jsonDecode(map.jsonruns));
          setState(() {});
        }
      }
    });

    _adTimer = Timer.periodic(Duration(minutes: FirebaseRemoteConfigUtils.adPageDuration), (timer) {
      AdsHelper.showInterstitialAds(adCloseEvent: () {
        print('Close ad event');
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
    _adTimer.cancel();
  }

  late MatchDataModel liveMatchData;
  // late LiveScoreRunModel liveMatchRun;
  late GetAllMatch allMatchData;
  late Timer _timer;
  late Timer _adTimer;
  int rewardAdCount = 0;

  @override
  Widget build(BuildContext context) {
    double height = Get.height;
    double width = Get.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: Container(
        height: double.infinity,
        color: mainColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Back Navigator & Live
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
                  ],
                ),
              ),
            ),

            //Teams Runs & Banner
            Padding(
              padding: EdgeInsets.only(top: height * 0.01),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ///TeamA
                      Expanded(
                        child: Column(
                          children: [
                            PhysicalModel(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              color: mainColor,
                              borderRadius: BorderRadius.all(Radius.circular(logoHeight * 0.1)),
                              child: FadeInImage.assetNetwork(
                                placeholder: 'asset/cricImg.png',
                                image: "${liveMatchData.jsondata.imgurl}${liveMatchData.jsondata.teamABanner}",
                                fit: BoxFit.cover,
                                height: logoHeight * 0.35,
                                width: logoHeight * 0.35,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: logoHeight * 0.03),
                              child: MarqueeWidget(
                                child: Text(
                                  liveMatchData.jsondata.teamA,
                                  style: TextStyle(
                                    fontSize: logoHeight * 0.1,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              "${liveMatchData.jsondata.wicketA}(${liveMatchData.jsondata.oversA})",
                              style: TextStyle(fontSize: logoHeight * 0.1, fontWeight: FontWeight.w500, color: Colors.white),
                            ),
                          ],
                        ),
                      ),

                      ///VS
                      Image.asset(
                        'asset/VS.png',
                        fit: BoxFit.contain,
                        height: logoHeight * 0.35,
                        width: logoHeight * 0.35,
                      ),

                      ///TeamB
                      Expanded(
                        child: Column(
                          children: [
                            PhysicalModel(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              color: mainColor,
                              borderRadius: BorderRadius.all(Radius.circular(logoHeight * 0.1)),
                              child: FadeInImage.assetNetwork(
                                placeholder: 'asset/cricImg.png',
                                image: "${liveMatchData.jsondata.imgurl}${liveMatchData.jsondata.teamBBanner}",
                                fit: BoxFit.cover,
                                height: logoHeight * 0.35,
                                width: logoHeight * 0.35,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: logoHeight * 0.03),
                              child: MarqueeWidget(
                                child: Text(
                                  liveMatchData.jsondata.teamB,
                                  style: TextStyle(fontSize: logoHeight * 0.1, fontWeight: FontWeight.w500, color: Colors.white),
                                ),
                              ),
                            ),
                            Text(
                              liveMatchData.jsondata.wicketB == "0/0" ? "Bowling" : liveMatchData.jsondata.wicketB,
                              style: TextStyle(fontSize: logoHeight * 0.1, fontWeight: FontWeight.w500, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.05, vertical: height * 0.005),
                    child: MarqueeWidget(
                      child: Text(
                        liveMatchData.jsondata.score,
                        style: StringStyle.scoreStyle,
                        maxLines: 1,
                      ),
                    ),
                  )
                ],
              ),
            ),

            ///Match Details
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
                          ///Last Six Ball
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: width * 0.07, vertical: height * 0.015),
                            padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                            height: height * 0.06,
                            decoration: BoxDecoration(
                              color: const Color(0xffF1F5FE),
                              borderRadius: BorderRadius.all(
                                Radius.circular((height * 0.06) * 0.4),
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black45,
                                  blurRadius: 7,
                                  spreadRadius: -1,
                                  offset: Offset(0.0, 0.0),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Text(
                                  "Last Six Ball :-",
                                  style: TextStyle(fontSize: (height * 0.06) * 0.4, fontWeight: FontWeight.w500),
                                ),
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: liveMatchData.jsondata.last6Balls.split('-').toList().length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        margin: EdgeInsets.all(width * 0.015),
                                        height: (height * 0.06) * 0.55,
                                        width: (height * 0.06) * 0.55,
                                        decoration: const BoxDecoration(
                                          color: Color(0xff2E2445),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Center(
                                          child: Text(
                                            liveMatchData.jsondata.last6Balls.split('-').toList()[index],
                                            style: const TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),

                          ///Batsman Details
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: width * 0.07, vertical: height * 0.015),
                            decoration: const BoxDecoration(
                              color: Color(0xffF1F5FE),
                              borderRadius: BorderRadius.all(
                                Radius.circular(18),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black45,
                                  blurRadius: 7,
                                  spreadRadius: -1,
                                  offset: Offset(0.0, 0.0),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.all((height * 0.06) * 0.15),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: (height * 0.06) * 0.15),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 7,
                                          child: Text("Batsman", style: StringStyle.batsmanH),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Center(child: Text("R(B)", style: StringStyle.batsmanH)),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Center(child: Text("6s", style: StringStyle.batsmanH)),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Center(child: Text("4s", style: StringStyle.batsmanH)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Divider(color: mainColor, thickness: 2),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: (height * 0.06) * 0.15),
                                    decoration: BoxDecoration(
                                        color: const Color(0xff8E78BE).withOpacity(0.5),
                                        borderRadius: BorderRadius.all(Radius.circular(height * 0.06))),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: (height * 0.06) * 0.15, vertical: (height * 0.06) * 0.07),
                                      child: Row(
                                        children: [
                                          Expanded(
                                              flex: 7,
                                              child: Text(
                                                liveMatchData.jsondata.batsman.split("*|").first.isEmpty
                                                    ? "------------"
                                                    : liveMatchData.jsondata.batsman.split("*|").first,
                                                style: StringStyle.batsmanN,
                                              )),
                                          Expanded(
                                            flex: 2,
                                            child: Center(
                                              child: Text(
                                                "${liveMatchData.jsondata.oversB.split("|").first.split(",")[1]}(${liveMatchData.jsondata.oversB.split("|").last.split(",")[1]})",
                                                style: StringStyle.batsmanN,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                              flex: 1,
                                              child: Center(
                                                child: Text(
                                                  liveMatchData.jsondata.s6,
                                                  style: StringStyle.batsmanN,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 1,
                                              child: Center(
                                                child: Text(
                                                  liveMatchData.jsondata.s4,
                                                  style: StringStyle.batsmanN,
                                                ),
                                              ))
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: (height * 0.06) * 0.15),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 7,
                                          child: Text(
                                            liveMatchData.jsondata.batsman.split("*|").last.isEmpty
                                                ? "------------"
                                                : liveMatchData.jsondata.batsman.split("*|").last,
                                            style: StringStyle.batsmanN,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Center(
                                            child: Text(
                                              "${liveMatchData.jsondata.oversB.split("|").first.split(",")[0]}(${liveMatchData.jsondata.oversB.split("|").last.split(",")[0]})",
                                              style: StringStyle.batsmanN,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Center(
                                            child: Text(
                                              liveMatchData.jsondata.ns6,
                                              style: StringStyle.batsmanN,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Center(
                                            child: Text(
                                              liveMatchData.jsondata.ns4,
                                              style: StringStyle.batsmanN,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const Divider(color: mainColor, thickness: 2),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: (height * 0.06) * 0.15),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: RichText(
                                            text: TextSpan(children: [
                                              TextSpan(
                                                text: "P'ship: ",
                                                style: StringStyle.batsmanN,
                                              ),
                                              TextSpan(text: liveMatchData.jsondata.partnership, style: const TextStyle(color: Colors.black)),
                                            ]),
                                            maxLines: 1,
                                          ),
                                        ),
                                        Expanded(
                                            flex: 2,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                  "Last wkt:",
                                                  textAlign: TextAlign.end,
                                                  maxLines: 1,
                                                  style: StringStyle.batsmanN,
                                                ),
                                                SizedBox(
                                                  child: MarqueeWidget(
                                                    child: Text(
                                                      liveMatchData.jsondata.lastwicket.isEmpty ? "-----" : liveMatchData.jsondata.lastwicket,
                                                      textAlign: TextAlign.end,
                                                      maxLines: 1,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),

                          ///Bowler Details
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: width * 0.07, vertical: height * 0.015),
                            decoration: const BoxDecoration(
                              color: Color(0xffF1F5FE),
                              borderRadius: BorderRadius.all(
                                Radius.circular(18),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black45,
                                  blurRadius: 7,
                                  spreadRadius: -1,
                                  offset: Offset(0.0, 0.0),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.all((height * 0.06) * 0.15),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: (height * 0.06) * 0.15),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 7,
                                          child: Text("Bowler", style: StringStyle.batsmanH),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Center(child: Text("W-R", style: StringStyle.batsmanH)),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Center(child: Text("Overs", style: StringStyle.batsmanH)),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Center(child: Text("Econ", style: StringStyle.batsmanH)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Divider(color: mainColor, thickness: 2),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: (height * 0.06) * 0.15),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 7,
                                          child: Text(
                                            liveMatchData.jsondata.bowler.isEmpty
                                                ? liveMatchData.jsondata.cbowler1.isEmpty
                                                    ? "-----"
                                                    : liveMatchData.jsondata.cbowler1
                                                : liveMatchData.jsondata.bowler == "0"
                                                    ? "-----"
                                                    : liveMatchData.jsondata.bowler,
                                            style: StringStyle.batsmanN,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Center(
                                            child: Text(
                                              "${liveMatchData.jsondata.cwicket1}-${liveMatchData.jsondata.crun1}",
                                              style: StringStyle.batsmanN,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Center(
                                            child: Text(
                                              liveMatchData.jsondata.cover1,
                                              style: StringStyle.batsmanN,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Center(
                                            child: Text(
                                              liveMatchData.jsondata.ceco1,
                                              style: StringStyle.batsmanN,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          ///Prediction Dialog
                          if (!liveMatchData.jsondata.score.contains("Won") && !liveMatchData.jsondata.score.contains("MATCH DRAWN")) ...[
                            Padding(
                              padding: EdgeInsets.all(height * 0.03),
                              child: GestureDetector(
                                onTap: () {
                                  if (FirebaseRemoteConfigUtils.rewardedAdCount == 0) {
                                    print("Show Rewarded Ad");
                                    AdsHelper.showRewardedAd(adShowSuccess: () {
                                      print('Close ad event');
                                      showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (BuildContext context) {
                                          return ScoreDialog(
                                            teamARate: liveMatchData.jsondata.rateA.split("|").first.split("-")[0],
                                            teamBRate: liveMatchData.jsondata.rateA.split("|").first.split("-")[1],
                                            teamB: liveMatchData.jsondata.teamB,
                                            teamA: liveMatchData.jsondata.teamA,
                                          );
                                        },
                                      );
                                    });
                                    FirebaseRemoteConfigUtils.rewardedAdCount = 1;
                                  } else {
                                    showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (BuildContext context) {
                                        return ScoreDialog(
                                          teamARate: liveMatchData.jsondata.rateA.split("|").first.split("-")[0],
                                          teamBRate: liveMatchData.jsondata.rateA.split("|").first.split("-")[1],
                                          teamB: liveMatchData.jsondata.teamB,
                                          teamA: liveMatchData.jsondata.teamA,
                                        );
                                      },
                                    );
                                    FirebaseRemoteConfigUtils.rewardedAdCount--;
                                  }
                                },
                                child: Container(
                                  decoration:
                                      BoxDecoration(borderRadius: BorderRadius.circular(20.0), color: const Color(0xff2E2445).withOpacity(0.5)),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      "Who Win The Match",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],

                          Padding(
                            padding: EdgeInsets.only(top: height * 0.015),
                            child: Text(
                              widget.jsonData == ''
                                  ? "Data Is Not available\nBecause Of That Match Is Not Started"
                                  : Utils.matchDataString(liveMatchData.jsondata.title),
                            ),
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
    );
  }
}