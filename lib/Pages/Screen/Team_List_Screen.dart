// ignore_for_file: file_names, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/MatchesResult.dart';
import '../../utils/Shared_Pref.dart';
import 'Teams_Match_Score.dart';

class TeamListScreen extends StatefulWidget {
  const TeamListScreen({Key? key, required this.list}) : super(key: key);

  final RxList<AllMatchData> list;

  @override
  State<TeamListScreen> createState() => _TeamListScreenState();
}

class _TeamListScreenState extends State<TeamListScreen> {
  @override
  void initState() {
    super.initState();
    print(widget.list[0].title);
  }

  List<String> isFavourite = SharedPreferencesDatas.getStringList(SharedPreferencesDatas.selectedMatchName);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double newsCardHeight = height * 0.07;
    return widget.list.isEmpty
        ? Center(
            child: SizedBox(
                height: height * 0.045,
                width: width * 0.8,
                child: const FittedBox(
                    child: Text(
                  "Data Not Available!",
                ))))
        : ListView.builder(
            itemCount: widget.list.length,
            padding: EdgeInsets.only(left: width * 0.05, right: width * 0.05, bottom: height * 0.13),
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.025, vertical: height * 0.015),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xffF1F5FE),
                    borderRadius: BorderRadius.all(
                      Radius.circular(height * 0.03),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xff000000).withOpacity(0.35),
                        blurRadius: 7,
                        spreadRadius: 0.8,
                        offset: const Offset(0.0, 0.0),
                      )
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return TeamsMatch(
                                    title: widget.list[index].title ?? '',
                                    matchId: widget.list[index].matchId ?? 0000,
                                  );
                                },
                              ),
                            );
                            print(index);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              widget.list[index].title ?? "",
                              softWrap: false,
                              maxLines: 1,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: height * 0.07,
                          width: height * 0.07,
                          decoration: BoxDecoration(
                            color: const Color(0xff2E2445),
                            borderRadius: BorderRadius.all(Radius.circular((height * 0.07) * 0.35)),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xff000000).withOpacity(0.35),
                                blurRadius: 4,
                                spreadRadius: 0.5,
                                offset: const Offset(0.0, 0.0),
                              )
                            ],
                          ),
                          child: IconButton(
                            onPressed: () async {
                              setState(() {
                                isFavourite.contains(widget.list[index].title!)
                                    ? isFavourite.remove(widget.list[index].title!)
                                    : isFavourite.add(widget.list[index].title!);
                              });
                              SharedPreferencesDatas.getStringList(SharedPreferencesDatas.selectedMatchName).clear();
                              SharedPreferencesDatas.setStringList(SharedPreferencesDatas.selectedMatchName, isFavourite);
                            },
                            icon: Icon(
                              isFavourite.contains(widget.list[index].title!) ? Icons.star : Icons.star_border,
                              size: (height * 0.07) * 0.6,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
  }
}
