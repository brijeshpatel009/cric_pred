// ignore_for_file: file_names, non_constant_identifier_names
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
  late double height = MediaQuery.of(context).size.height;
  late double width = MediaQuery.of(context).size.width;

  List<String> international = [
    'India',
    'Bangladesh',
    'England',
    'South Africa',
    'Australia',
    'Sri Lanka',
    'New Zealand',
    'West Indies',
    'Ireland',
    'Zimbabwe',
  ];

  List<String> IPL = [
    'Mumbai Indians',
    'Chennai Super Kings',
    'Kolkata Knight Riders',
    'Royal Challengers Bangalore',
    'Punjab Kings',
    'Sunrisers Hyderabad',
  ];
  List<String> BPL = [
    'Comilla Victorians',
    'Rangpur Riders',
    'Fortune Barishal',
    'Rajshahi Royals',
    'Duronto Rajshahi',
  ];
  List<String> CPL = [
    'Guyana Amazon Warriors',
    'Trinbago Knight Riders',
    'Jamaica Tallawahs',
    'Antigua Hawksbills',
    'Barbados Royals',
  ];
  List<String> ODI = [
    "IND",
    "NZ",
    "ENG",
    "AUS",
  ];

  late final tabs = TabController(length: 6, vsync: this, animationDuration: const Duration(seconds: 1));

  final GetAllMatchesController allMatches = Get.find();

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
                    style: TextStyle(color: Colors.white, fontSize: height * 0.04, fontWeight: FontWeight.w600, letterSpacing: 1),
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
                tabs: [
                  tab('International'),
                  tab('T20'),
                  tab('IPL'),
                  tab('CPL'),
                  tab('BPL'),
                  tab('Test'),
                ],
              ),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(height * 0.04)),
                  child: Container(
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: height * 0.11, top: height * 0.04),
                      child: TabBarView(
                        controller: tabs,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          TeamListScreen(
                            list: allMatches.completeInternationalMatchList,
                          ),
                          TeamListScreen(
                            list: allMatches.completeT20MatchList,
                          ),
                          TeamListScreen(
                            list: allMatches.completeIPLMatchList,
                          ),
                          TeamListScreen(
                            list: allMatches.completeCPLMatchList,
                          ),
                          TeamListScreen(
                            list: allMatches.completeBPLMatchList,
                          ),
                          TeamListScreen(
                            list: allMatches.completeTestMatchList,
                          ),
                        ],
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

  Widget tab(String string) {
    return Text(
      string,
      style: const TextStyle(color: Color(0xffFFFFFF), fontSize: 18, fontWeight: FontWeight.w600),
    );
  }
}
