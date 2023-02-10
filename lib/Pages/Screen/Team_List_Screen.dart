// ignore_for_file: file_names, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/MatchStatsController.dart';
import '../../model/MatchesResult.dart';
import 'Teams_Match.dart';

class TeamListScreen extends StatefulWidget {
  const TeamListScreen({Key? key, required this.matchList, this.list}) : super(key: key);
  final List matchList;
  final RxList<AllMatchData>? list;

  @override
  State<TeamListScreen> createState() => _TeamListScreenState();
}

class _TeamListScreenState extends State<TeamListScreen> {
  @override
  void initState() {
    super.initState();
    matchStatsController = Get.put(MatchStatusController())..getMatchStatsData(10768);
  }

  late MatchStatusController matchStatsController;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return ListView.builder(
      itemCount: widget.matchList.isNotEmpty ? widget.matchList.length : widget.list?.length,
      padding: EdgeInsets.only(left: width * 0.05, right: width * 0.05, bottom: height * 0.13),
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return TeamsMatch(
                        title: widget.matchList.isNotEmpty ? widget.matchList[index] : widget.list?[index].title,
                        matchStatus: widget.matchList.isNotEmpty ? 0000 : widget.list?[index].matchId ?? 0000,
                      );
                    },
                  ),
                );
                print(index);
              },
              child: Container(
                height: height * 0.07,
                width: width * 0.75,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(13),
                    topLeft: Radius.circular(13),
                  ),
                  color: Color(0xff9BDCFF),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.matchList.isNotEmpty ? widget.matchList[index] : widget.list?[index].title),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              height: height * 0.07,
              width: width * 0.13,
              decoration: const BoxDecoration(
                color: Color(0xff70CDFF),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              child: const Center(
                child: Icon(Icons.star_border, size: 33),
              ),
            ),
          ],
        );
      },
    );
  }
}
