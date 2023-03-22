// ignore_for_file: file_names, non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/String_Style.dart';
import '../../utils/utils.dart';
import '../../utils/variable.dart';
import 'Controller/AllMatchController.dart';
import 'Finished_Match_List.dart';

class FinishedMatchScreen extends StatefulWidget {
  const FinishedMatchScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<FinishedMatchScreen> createState() => _FinishedMatchScreenState();
}

class _FinishedMatchScreenState extends State<FinishedMatchScreen> with TickerProviderStateMixin {
  late final tabs = TabController(length: 6, vsync: this, animationDuration: const Duration(seconds: 1));

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // SocketHelper.finishedMatch();
    allMatches = Get.put(AllMatchController());
  }

  late AllMatchController allMatches;

  @override
  Widget build(BuildContext context) {
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
                    style: TextStyle(color: Colors.white, fontSize: minSize * 0.07, fontWeight: FontWeight.w600, letterSpacing: 1),
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
                  Utils.tabsWidget(Strings.international),
                  Utils.tabsWidget(Strings.test),
                  Utils.tabsWidget(Strings.t20),
                  Utils.tabsWidget(Strings.ipl),
                  Utils.tabsWidget(Strings.cpl),
                  Utils.tabsWidget(Strings.bpl),
                ],
              ),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(height * 0.04)),
                  child: Container(
                    color: Colors.white,
                    child: Obx(() => TabBarView(
                          controller: tabs,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            FinishedMatchList(
                              list: allMatches.completeInternationalMatchList,
                              isLoading: allMatches.isAllMatchLoading.value,
                            ),
                            FinishedMatchList(
                              list: allMatches.completeTestMatchList,
                              isLoading: allMatches.isAllMatchLoading.value,
                            ),
                            FinishedMatchList(
                              list: allMatches.completeT20MatchList,
                              isLoading: allMatches.isAllMatchLoading.value,
                            ),
                            FinishedMatchList(
                              list: allMatches.completeIPLMatchList,
                              isLoading: allMatches.isAllMatchLoading.value,
                            ),
                            FinishedMatchList(
                              list: allMatches.completeCPLMatchList,
                              isLoading: allMatches.isAllMatchLoading.value,
                            ),
                            FinishedMatchList(
                              list: allMatches.completeBPLMatchList,
                              isLoading: allMatches.isAllMatchLoading.value,
                            ),
                          ],
                        )),
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
