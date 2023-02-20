// ignore_for_file: file_names, non_constant_identifier_names
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/GetAllMatchController.dart';
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

  final GetAllMatchesController allMatches = Get.find();

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
                onTap: (int val) {
                  setState(() {
                    teamsIndex = val;
                  });
                },
                controller: tabs,
                isScrollable: true,
                unselectedLabelStyle: const TextStyle(color: Color(0xffFFFFFF)),
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: const Color(0xffF97900),
                indicatorWeight: height * 0.005,
                padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                tabs: [
                  tab('International', width),
                  tab('T20', width),
                  tab('IPL', width),
                  tab('CPL', width),
                  tab('BPL', width),
                  tab('Test', width),
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
                        TeamListScreen(
                          list: allMatches.completeTestMatchList,
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

  Widget tab(String string, double width) {
    return Text(
      string,
      style: TextStyle(color: const Color(0xffFFFFFF), fontSize: width * 0.05, fontWeight: FontWeight.w400),
    );
  }
}
