// ignore_for_file: file_names, avoid_print, no_leading_underscores_for_local_identifiers
import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../CustomIcon/tab_bar_icon_icons.dart';
import '../main.dart';
import '../utils/String_Style.dart';
import '../utils/utils.dart';
import '../utils/variable.dart';
import '../widget/Divider.dart';
import 'finished_match_screen/Finished_Match_Screen.dart';
import 'home_screen/Home_Screen.dart';
import 'news_screen/News_Screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final TabController _tab = TabController(length: 3, vsync: this);
  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;

  @override
  void initState() {
    super.initState();
    // AdsApiData adsApiData = Get.put(AdsApiData());
    getConnectivity();
    // SocketHelper.testingSocket();
  }

  getConnectivity() => subscription = Connectivity().onConnectivityChanged.listen(
        (ConnectivityResult result) async {
          isDeviceConnected = await InternetConnectionChecker().hasConnection;
          if (!isDeviceConnected && isAlertSet == false) {
            _showConnectionDialog();
            setState(() => isAlertSet = true);
          }
        },
      );

  Future<void> _showConnectionDialog() async {
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
                          "No Connection",
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
                          "Please check your internet connectivity",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: minSize * 0.04,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: height * 0.02, right: width * 0.05, left: width * 0.05),
                        child: GestureDetector(
                            onTap: () async {
                              Navigator.pop(context, 'Cancel');
                              setState(() => isAlertSet = false);
                              isDeviceConnected = await InternetConnectionChecker().hasConnection;
                              if (!isDeviceConnected && isAlertSet == false) {
                                _showConnectionDialog();
                                setState(() => isAlertSet = true);
                              }
                              if (isDeviceConnected) {
                                print("Connection Back");
                                runApp(const MyApp());
                              }
                            },
                            child: Container(
                              height: height * 0.04,
                              width: width * 0.15,
                              decoration: const BoxDecoration(color: Color(0xff2E2445), borderRadius: BorderRadius.all(Radius.circular(10))),
                              child: const Center(child: Text("Okay", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600))),
                            )),
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
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: Text(
                          "No Connection",
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
                          "Please check your internet connectivity",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: minSize * 0.04,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: height * 0.02, right: width * 0.05, left: width * 0.05),
                        child: GestureDetector(
                            onTap: () async {
                              Navigator.pop(context, 'Cancel');
                              setState(() => isAlertSet = false);
                              isDeviceConnected = await InternetConnectionChecker().hasConnection;
                              if (!isDeviceConnected && isAlertSet == false) {
                                _showConnectionDialog();
                                setState(() => isAlertSet = true);
                              }
                              if (isDeviceConnected) {
                                print("Connection Back");
                                runApp(const MyApp());
                              }
                            },
                            child: Container(
                              height: height * 0.04,
                              width: width * 0.15,
                              decoration: const BoxDecoration(color: Color(0xff2E2445), borderRadius: BorderRadius.all(Radius.circular(10))),
                              child: const Center(child: Text("Okay", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600))),
                            )),
                      ),
                    ],
                  ),
                ),
              );
      },
    );
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _tab,
              children: [
                LiveUpcomingScreen(
                  tab: _tab,
                ),
                const FinishedMatchScreen(
                  title: Strings.finish,
                ),
                const NewsScreen(
                  title: Strings.news,
                ),
                // const ProfileScreen(),
              ],
            ),
            Positioned(
              bottom: height * 0.05,
              right: 10,
              left: 10,
              child: Container(
                height: height * 0.1,
                decoration: const BoxDecoration(
                  color: Color(0xffFFFFFF),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black45,
                      blurRadius: 6,
                      spreadRadius: 1,
                      offset: Offset(0.0, 0.0),
                    ),
                  ],
                ),
                child: TabBar(
                  onTap: (int val) async {
                    // await AdsHelper.showInterstitialAds();
                    setState(() {
                      tabIndex = val;
                    });
                  },
                  physics: const NeverScrollableScrollPhysics(),
                  labelColor: const Color(0xff2E2445),
                  unselectedLabelColor: Colors.grey,
                  labelStyle: const TextStyle(fontSize: 13.0, color: Color(0xff2E2445)),
                  indicatorColor: Colors.transparent,
                  tabs: <Widget>[
                    tab(TabBarIcon.home, Strings.home, height),
                    tab(TabBarIcon.finished, Strings.finish, height),
                    tab(TabBarIcon.news, Strings.news, height),
                    // tab(Icons.person_pin, 'Profile'),
                  ],
                  controller: _tab,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget tab(IconData icon, String name, double height) {
    return Tab(
      icon: Icon(
        icon,
        size: (height * 0.1) * 0.4,
      ),
      text: name,
    );
  }
}
