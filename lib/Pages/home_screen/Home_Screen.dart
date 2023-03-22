// ignore_for_file: file_names, avoid_print

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../CustomIcon/tab_bar_icon_icons.dart';
import '../../helper/firebase_remote_config.dart';
import '../../utils/String_Style.dart';
import '../../utils/utils.dart';
import '../../utils/variable.dart';
import '../../widget/Divider.dart';
import 'widget/Match_List.dart';

class LiveUpcomingScreen extends StatefulWidget {
  const LiveUpcomingScreen({Key? key, required this.tab}) : super(key: key);
  final TabController tab;

  @override
  State<LiveUpcomingScreen> createState() => _LiveUpcomingScreenState();
}

class _LiveUpcomingScreenState extends State<LiveUpcomingScreen> with TickerProviderStateMixin {
  late final tabController = TabController(length: 2, vsync: this, animationDuration: const Duration(seconds: 1));

  @override
  void initState() {
    super.initState();
    matchStreamingCategoryIndex = 0;
    _initPackageInfo();
    // SocketHelper.liveMatchInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future<void> _initPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    int currentVersion = int.parse(packageInfo.version.trim().replaceAll(".", ""));
    int newVersion = int.parse(FirebaseRemoteConfigUtils.newVersion.trim().replaceAll(".", ""));
    print("Package Version:=> $currentVersion");
    if (newVersion > currentVersion) {
      _showVersionDialog();
    }
  }

  Future<void> _showVersionDialog() async {
    await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Platform.isIOS
            ? WillPopScope(
                onWillPop: () async {
                  return false;
                },
                child: CupertinoAlertDialog(
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: Text(
                          "New Update Available",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: minSize * 0.05,
                          ),
                        ),
                      ),
                      const DividerWidget(color: Color(0xff2E2445), thickness: 3),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          "There is a newer version of app available please update it now.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: minSize * 0.04,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: height * 0.02, right: width * 0.05, left: width * 0.05),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              flex: 2,
                              child: GestureDetector(
                                  onTap: () => _launchURL(FirebaseRemoteConfigUtils.androidAppUrl),
                                  child: Container(
                                    height: height * 0.04,
                                    decoration: const BoxDecoration(color: Color(0xff2E2445), borderRadius: BorderRadius.all(Radius.circular(10))),
                                    child: const Center(child: Text("Update", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600))),
                                  )),
                            ),
                            const Expanded(flex: 1, child: SizedBox()),
                            Expanded(
                              flex: 2,
                              child: GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: Container(
                                  height: height * 0.04,
                                  decoration: const BoxDecoration(color: Color(0xff2E2445), borderRadius: BorderRadius.all(Radius.circular(10))),
                                  child: const Center(child: Text("No Thanks", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600))),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : WillPopScope(
                onWillPop: () async {
                  return false;
                },
                child: AlertDialog(
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: Text(
                          "New Update Available",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: minSize * 0.05,
                          ),
                        ),
                      ),
                      const DividerWidget(color: Color(0xff2E2445), thickness: 3),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          "There is a newer version of app available please update it now.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: minSize * 0.04,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: height * 0.02, right: width * 0.05, left: width * 0.05),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              flex: 2,
                              child: GestureDetector(
                                  onTap: () => _launchURL(FirebaseRemoteConfigUtils.androidAppUrl),
                                  child: Container(
                                    height: height * 0.04,
                                    decoration: const BoxDecoration(color: Color(0xff2E2445), borderRadius: BorderRadius.all(Radius.circular(10))),
                                    child: const Center(child: Text("Update", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600))),
                                  )),
                            ),
                            const Expanded(flex: 1, child: SizedBox()),
                            Expanded(
                              flex: 2,
                              child: GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: Container(
                                  height: height * 0.04,
                                  decoration: const BoxDecoration(color: Color(0xff2E2445), borderRadius: BorderRadius.all(Radius.circular(10))),
                                  child: const Center(child: Text("No Thanks", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600))),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
      },
    );
  }

  Future<void> _launchURL(String url) async {
    var uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $uri');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Container(
        height: double.infinity,
        color: const Color(0xff2E2445),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(right: width * 0.04, top: height * 0.02),
                child: GestureDetector(
                  onTap: () async {
                    // await AdsHelper.showInterstitialAds();
                    // setState(() {
                    //   tabIndex = 0;
                    //   widget.tab.animateTo(tabIndex);
                    // });
                    // print('profile');
                    _launchURL(FirebaseRemoteConfigUtils.privacyPolicyUrl);
                  },
                  child: const Align(
                    alignment: Alignment.topRight,
                    child: Icon(
                      TabBarIcon.insurance,
                      size: 25,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              //Live Or Upcoming Category Tab
              TabBar(
                  overlayColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
                    return states.contains(MaterialState.focused) ? null : Colors.transparent;
                  }),
                  onTap: (int val) async {
                    // await AdsHelper.showInterstitialAds();
                    setState(() {
                      matchStreamingCategoryIndex = val;
                    });
                    // print(val);
                  },
                  physics: const NeverScrollableScrollPhysics(),
                  isScrollable: false,
                  unselectedLabelStyle: const TextStyle(color: Color(0xffFFFFFF)),
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorColor: const Color(0xffF97900),
                  indicatorWeight: height * 0.005,
                  labelColor: const Color(0xffF97900),
                  labelStyle: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                  unselectedLabelColor: Colors.white,
                  controller: tabController,
                  tabs: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: height * 0.02,
                        bottom: height * 0.01,
                      ),
                      child: Text(Strings.liveMatch, style: TextStyle(fontSize: width * 0.05, fontWeight: FontWeight.w400)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: height * 0.02,
                        bottom: height * 0.01,
                      ),
                      child: Text(Strings.upcoming, style: TextStyle(fontSize: width * 0.05, fontWeight: FontWeight.w400)),
                    ),
                  ]),

              //Matches List View
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(height * 0.04)),
                  child: Container(
                    color: Colors.white,
                    child: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: tabController,
                      children: const [
                        MatchesList(),
                        MatchesList(),
                      ],
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
