// ignore_for_file: file_names, depend_on_referenced_packages, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';

import '../../Custom/my_icons_icons.dart';
import '../../controller/MatchStatsController.dart';
import '../../model/MatchesResult.dart';
import '../../utils/String_Style.dart';
import '../../utils/utils.dart';
import '../../widget/Marquee.dart';

class TeamsMatch extends StatefulWidget {
  const TeamsMatch({Key? key, required this.title, required this.matchData}) : super(key: key);
  final String title;
  final AllMatchData matchData;

  @override
  State<TeamsMatch> createState() => _TeamsMatchState();
}

class _TeamsMatchState extends State<TeamsMatch> {
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
  }

  late MatchStatusController matchStatsController;

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
          () => matchStatsController.isLoading.value
              ? const Center(
                  child: SizedBox(height: 20, width: 20, child: CircularProgressIndicator()),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Back Navigator
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

                    //Teams Name & Banner
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
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: width * 0.05, vertical: height * 0.005),
                            child: MarqueeWidget(child: Text(widget.matchData.result, style: StringStyle.scoreStyle, maxLines: 1)),
                          ),
                        ],
                      ),
                    ),

                    //Match Details
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(height * 0.04)),
                        child: Container(
                          width: double.infinity,
                          color: Colors.white,
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.only(top: height * 0.015, left: width * 0.02, right: width * 0.02),
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: Text(
                                        matchStatsController.matchStatusData!.matchst!.isEmpty
                                            ? Strings.dataNotAvailable
                                            : "${matchStatsController.matchStatusData!.matchst![0].stat1name} :",
                                        style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
                                      ),
                                      subtitle: Text(
                                        matchStatsController.matchStatusData!.matchst!.isEmpty
                                            ? Strings.dataNotAvailable
                                            : _parseHtmlString(matchStatsController.matchStatusData!.matchst![0].stat1descr ?? ''),
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                    ),
                                    const Divider(color: Colors.black, thickness: 2),
                                    ListTile(
                                      title: Text(
                                        matchStatsController.matchStatusData!.matchst!.isEmpty
                                            ? Strings.dataNotAvailable
                                            : "${matchStatsController.matchStatusData!.matchst![0].stat2name} :",
                                        style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
                                      ),
                                      subtitle: Text(
                                        matchStatsController.matchStatusData!.matchst!.isEmpty
                                            ? Strings.dataNotAvailable
                                            : _parseHtmlString(matchStatsController.matchStatusData!.matchst![0].stat2descr ?? ''),
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                    ),
                                    const Divider(color: Colors.black, thickness: 2),
                                    ListTile(
                                      title: Text(
                                        matchStatsController.matchStatusData!.matchst!.isEmpty
                                            ? Strings.dataNotAvailable
                                            : "${matchStatsController.matchStatusData!.matchst![0].stat3name} :",
                                        style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
                                      ),
                                      subtitle: Text(
                                        matchStatsController.matchStatusData!.matchst!.isEmpty
                                            ? Strings.dataNotAvailable
                                            : _parseHtmlString(matchStatsController.matchStatusData!.matchst![0].stat3descr ?? ''),
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  ],
                                ),
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
    );
  }
}
