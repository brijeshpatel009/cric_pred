// ignore_for_file: file_names, depend_on_referenced_packages, avoid_print

import 'dart:async';

import 'package:ads_helper/ads_helper.dart';
import 'package:cric_pred/Pages/finished_match_screen/widget/Player_Info.dart';
import 'package:cric_pred/Pages/finished_match_screen/widget/Score_Info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';

import '../../CustomIcon/my_icons_icons.dart';
import '../../helper/firebase_remote_config.dart';
import '../../model/MatchesResult.dart';
import '../../utils/String_Style.dart';
import '../../utils/utils.dart';
import '../../utils/variable.dart';
import '../../widget/Marquee.dart';
import 'Controller/MatchStatsController.dart';

class FinishedMatchScore extends StatefulWidget {
  const FinishedMatchScore({Key? key, required this.title, required this.matchData}) : super(key: key);
  final String title;
  final AllMatchData matchData;

  @override
  State<FinishedMatchScore> createState() => _FinishedMatchScoreState();
}

class _FinishedMatchScoreState extends State<FinishedMatchScore> with TickerProviderStateMixin {
  late final tabs = TabController(length: 4, vsync: this, animationDuration: const Duration(seconds: 1));

  String _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString = parse(document.body?.text).documentElement?.text ?? '';
    print(parsedString);
    return parsedString;
  }

  @override
  void initState() {
    super.initState();
    matchStatsController = Get.put(MatchStatusController())..getMatchStatsData(widget.matchData.matchId);
    adTimer = Timer.periodic(Duration(minutes: FirebaseRemoteConfigUtils.adPageDuration), (timer) {
      AdsHelper.showInterstitialAds(adCloseEvent: () {
        print('Close ad event');
      });
    });
    // SocketHelper.statSocket(widget.matchData.matchId);
  }

  late MatchStatusController matchStatsController;
  late Timer adTimer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      body: Container(
        height: double.infinity,
        color: const Color(0xff2E2445),
        child: Obx(
          () => matchStatsController.isStatsLoading.value
              ? const Center(
                  child: SizedBox(height: 20, width: 20, child: CircularProgressIndicator()),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ///Back Navigator
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
                          ],
                        ),
                      ),
                    ),

                    ///Teams Name & Banner
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: height * 0.01),
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
                                      color: const Color(0xff2E2445),
                                      borderRadius: BorderRadius.all(Radius.circular(logoHeight * 0.1)),
                                      child: FadeInImage.assetNetwork(
                                        placeholder: 'asset/cricImg.png',
                                        image: "${widget.matchData.imageUrl}${widget.matchData.teamAImage}",
                                        fit: BoxFit.cover,
                                        height: logoHeight * 0.35,
                                        width: logoHeight * 0.35,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(vertical: logoHeight * 0.03),
                                      child: MarqueeWidget(
                                        child: Text(
                                          widget.matchData.teamA,
                                          style: StringStyle.teamNameStyle,
                                        ),
                                      ),
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
                                      color: const Color(0xff2E2445),
                                      borderRadius: BorderRadius.all(Radius.circular(logoHeight * 0.1)),
                                      child: FadeInImage.assetNetwork(
                                        placeholder: 'asset/cricImg.png',
                                        image: "${widget.matchData.imageUrl}${widget.matchData.teamBImage}",
                                        fit: BoxFit.cover,
                                        height: logoHeight * 0.35,
                                        width: logoHeight * 0.35,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(vertical: logoHeight * 0.03),
                                      child: MarqueeWidget(
                                        child: Text(
                                          widget.matchData.teamB,
                                          style: StringStyle.teamNameStyle,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    ///TabBar
                    TabBar(
                      overlayColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
                        return states.contains(MaterialState.focused) ? null : Colors.transparent;
                      }),
                      onTap: (int val) async {
                        // await AdsHelper.showInterstitialAds();
                        setState(() {
                          teamScoreBoardIndex = val;
                        });
                      },
                      controller: tabs,
                      isScrollable: true,
                      unselectedLabelStyle: const TextStyle(color: Color(0xffFFFFFF)),
                      unselectedLabelColor: Colors.white,
                      indicatorColor: const Color(0xffF97900),
                      labelColor: const Color(0xffF97900),
                      indicatorWeight: height * 0.005,
                      indicatorSize: TabBarIndicatorSize.label,
                      padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                      tabs: [
                        Utils.tabsWidget(Strings.playerInfo),
                        Utils.tabsWidget(Strings.matchInfo),
                        Utils.tabsWidget(Strings.location),
                        Utils.tabsWidget(Strings.stat),
                      ],
                    ),

                    ///TabBar View
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(height * 0.04)),
                        child: TabBarView(
                          controller: tabs,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            PlayerInfo(
                              matchData: widget.matchData,
                            ),
                            ScoreInfo(
                              info: matchStatsController.matchStatusList.isEmpty
                                  ? Strings.dataNotAvailable
                                  : _parseHtmlString(matchStatsController.matchStatusList[0].stat1descr),
                            ),
                            ScoreInfo(
                              info: matchStatsController.matchStatusList.isEmpty
                                  ? Strings.dataNotAvailable
                                  : matchStatsController.matchStatusList[0].stat2descr.isEmpty
                                      ? Strings.dataNotAvailable
                                      : _parseHtmlString(matchStatsController.matchStatusList[0].stat2descr),
                            ),
                            ScoreInfo(
                              info: matchStatsController.matchStatusData.matchst.isEmpty
                                  ? Strings.dataNotAvailable
                                  : matchStatsController.matchStatusList[0].stat3descr.isEmpty
                                      ? Strings.dataNotAvailable
                                      : _parseHtmlString(matchStatsController.matchStatusList[0].stat3descr),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
