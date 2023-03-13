// ignore_for_file: file_names, non_constant_identifier_names
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/GetAllMatchController.dart';
import '../../utils/String.dart';
import '../../utils/variable.dart';
import 'Team_List_Screen.dart';

class TeamScreen extends StatefulWidget {
  const TeamScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<TeamScreen> createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen> with TickerProviderStateMixin {
  late final tabs = TabController(length: 6, vsync: this, animationDuration: const Duration(seconds: 1));
  late GetAllMatchesController allMatches;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    allMatches = Get.put(GetAllMatchesController());
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double size = min(height, width);
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      body: Container(
        height: double.infinity,
        color: const Color(0xff2E2445),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: height * 0.02),
                child: Center(
                  child: Text(
                    widget.title,
                    style: TextStyle(color: Colors.white, fontSize: size * 0.07, fontWeight: FontWeight.w600, letterSpacing: 1),
                  ),
                ),
              ),
              TabBar(
                overlayColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
                  return states.contains(MaterialState.focused) ? null : Colors.transparent;
                }),
                onTap: (int val) async {
                  // await AdsHelper.showInterstitialAds();
                  setState(() {
                    teamsIndex = val;
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
                  tabsWidget(Strings.international, width, height),
                  tabsWidget(Strings.t20, width, height),
                  tabsWidget(Strings.IPL, width, height),
                  tabsWidget(Strings.CPL, width, height),
                  tabsWidget(Strings.BPL, width, height),
                  tabsWidget(Strings.Test, width, height),
                ],
              ),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(height * 0.04)),
                  child: Container(
                    color: Colors.white,
                    child: TabBarView(
                      controller: tabs,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        TeamListScreen(
                          list: allMatches.completeInternationalMatchList,
                          isLoading: allMatches.isLoading.value,
                        ),
                        TeamListScreen(
                          list: allMatches.completeT20MatchList,
                          isLoading: allMatches.isLoading.value,
                        ),
                        TeamListScreen(
                          list: allMatches.completeIPLMatchList,
                          isLoading: allMatches.isLoading.value,
                        ),
                        TeamListScreen(
                          list: allMatches.completeCPLMatchList,
                          isLoading: allMatches.isLoading.value,
                        ),
                        TeamListScreen(
                          list: allMatches.completeBPLMatchList,
                          isLoading: allMatches.isLoading.value,
                        ),
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

  Widget tabsWidget(String string, double width, double height) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: height * 0.01,
      ),
      child: Text(
        string,
        style: TextStyle(fontSize: width * 0.05, fontWeight: FontWeight.w400),
      ),
    );
  }
}
