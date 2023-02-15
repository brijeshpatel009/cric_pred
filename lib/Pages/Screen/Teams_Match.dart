// ignore_for_file: file_names, depend_on_referenced_packages, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';

import '../../Custom/my_icons_icons.dart';
import '../../controller/MatchStatsController.dart';

class TeamsMatch extends StatefulWidget {
  const TeamsMatch({Key? key, required this.title, required this.matchId}) : super(key: key);
  final String title;
  final int matchId;

  @override
  State<TeamsMatch> createState() => _TeamsMatchState();
}

class _TeamsMatchState extends State<TeamsMatch> {
  late double height = MediaQuery.of(context).size.height;
  late double width = MediaQuery.of(context).size.width;

  String _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString = parse(document.body?.text).documentElement?.text ?? '';
    print(parsedString);
    return parsedString;
  }

  @override
  void initState() {
    super.initState();
    matchStatsController = Get.find()..getMatchStatsData(widget.matchId);
  }

  late MatchStatusController matchStatsController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          height: double.maxFinite,
          decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage('asset/appbar.png'), fit: BoxFit.fill),
          ),
          child: Row(
            children: [
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(MyIcons.backArrow)),
              Text(
                widget.title,
                style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage('asset/background.png'), fit: BoxFit.fill),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Obx(
                () => matchStatsController.isLoading.value == true
                    ? Center(
                        child: SizedBox(
                          height: height * 0.1,
                          width: height * 0.1,
                          child: const CircularProgressIndicator(),
                        ),
                      )
                    : Center(
                        child: Text(
                          matchStatsController.matchStatusData!.matchst!.isEmpty
                              ? "Data Not Available"
                              : _parseHtmlString(matchStatsController.matchStatusData!.matchst![0].stat1descr ?? ''),
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
              )),
        ),
      ),
    );
  }
}
