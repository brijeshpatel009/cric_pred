// ignore_for_file: file_names, avoid_print,

import 'dart:async';
import 'dart:math';

import 'package:ads_helper/ads_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/GetAllMatchController.dart';
import '../../../utils/String_Style.dart';
import '../../../utils/variable.dart';
import '../../../widget/CountDown.dart';
import '../../../widget/Marquee.dart';
import '../../../widget/common_widget.dart';
import '../Match_Score.dart';

class MatchesList extends StatefulWidget {
  const MatchesList({Key? key}) : super(key: key);

  @override
  State<MatchesList> createState() => _MatchesListState();
}

class _MatchesListState extends State<MatchesList> {
  int randomInt() {
    var num = 0;
    num = Random().nextInt(3) + 1;
    return num;
  }

  @override
  void initState() {
    super.initState();
    Get.delete<GetAllMatch>();
    allMatchData = Get.put(GetAllMatch());
    print("Navigate Match List");
  }

  late GetAllMatch allMatchData;

  @override
  Widget build(BuildContext context) {
    double height = Get.height;
    double width = Get.width;
    double cardHeight = height * 0.15;
    return Obx(() => allMatchData.currentLiveMatchFilterList.isEmpty && matchStreamingCategoryIndex == 0
        ? allMatchData.isLiveMatchLoading.value
            ? const Center(
                child: SizedBox(height: 20, width: 20, child: CircularProgressIndicator()),
              )
            : Center(
                child: Text(
                  Strings.matchNotLiveText,
                  style: TextStyle(color: const Color(0xff2E2445), fontWeight: FontWeight.w500, letterSpacing: 0.8, fontSize: height * 0.02),
                ),
              )
        : ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(top: 15, bottom: 100),
            itemCount: matchStreamingCategoryIndex == 1
                ? allMatchData.upcomingMatchTeamA.length
                : allMatchData.currentLiveMatchFilterList.isEmpty
                    ? 1
                    : allMatchData.currentLiveMatchFilterList.length,
            // separatorBuilder: (context, index) {
            //   if ((index + 1) % randomInt() == 0) {
            //     print(">>>>>>>>>>>>>>>>>${(index + 1) % randomInt()}");
            //     return SizedBox(width: width, child: const BannerAdView());
            //   } else {
            //     return Container();
            //   }
            // },
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: height * 0.005),
                child: Stack(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        if (matchStreamingCategoryIndex == 0) {
                          AdsHelper.showInterstitialAds(adCloseEvent: () {
                            print('Close ad event');
                          });
                        }
                        if (matchStreamingCategoryIndex == 0) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return HomeMatchScoreScreen(
                                    jsonData: allMatchData.currentLiveMatchFilterList[index].jsondata,
                                    jsonruns: allMatchData.currentLiveMatchFilterList[index].jsonruns,
                                    teamAName: allMatchData.currentLiveMatchFilterList[index].teamA,
                                  );
                                },
                              )..popped.then((value) {
                                  Get.delete<GetAllMatch>();
                                  allMatchData = Get.put(GetAllMatch());
                                  print("Popped Match List Screen");
                                }));
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
                                        padding: EdgeInsets.symmetric(vertical: (cardHeight * 0.1) * 0.07, horizontal: (cardHeight * 0.1) * 0.5),
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
                                  ///TeamA
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
                                                ? allMatchData.upcomingMatchImageurlA[index]
                                                : "${allMatchData.currentLiveMatchFilterList[index].imgeUrl.replaceAll("thumb/", "")}${allMatchData.currentLiveMatchFilterList[index].teamAImage}",
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
                                                  ? allMatchData.upcomingMatchTeamA[index]
                                                  : allMatchData.currentLiveMatchFilterList[index].teamA,
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

                                  ///VS
                                  Image.asset(
                                    'asset/VS.png',
                                    fit: BoxFit.contain,
                                    height: cardHeight * 0.35,
                                    width: cardHeight * 0.35,
                                  ),

                                  ///TeamB
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
                                                ? allMatchData.upcomingMatchImageurlB[index]
                                                : "${allMatchData.currentLiveMatchFilterList[index].imgeUrl.replaceAll("thumb/", "")}${allMatchData.currentLiveMatchFilterList[index].teamBImage}",
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
                                                  ? allMatchData.upcomingMatchTeamB[index]
                                                  : allMatchData.currentLiveMatchFilterList[index].teamB,
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
                                  allMatchData.upcomingMatchTime[index],
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
                        padding: const EdgeInsets.symmetric(horizontal: 5),
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
                                      allMatchData.yourParserOrDateTimeParse(allMatchData.upcomingMatchTime[index]),
                                    )
                                  : CountDown().timeLeft(
                                      allMatchData.yourParserOrDateTimeParse(allMatchData.currentLiveMatchFilterList[index].matchtime),
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
          ));
  }

  void update() async {
    Timer.periodic(const Duration(seconds: 1), (timer) {});
  }
}
