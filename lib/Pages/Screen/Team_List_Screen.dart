// ignore_for_file: file_names, avoid_print, use_build_context_synchronously

import 'package:cric_pred/widget/commonWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/MatchesResult.dart';
import '../../utils/Shared_Pref.dart';
import '../../utils/String_Style.dart';
import '../../utils/utils.dart';
import '../../widget/Marquee.dart';
import 'Teams_Match_Score.dart';

class TeamListScreen extends StatefulWidget {
  const TeamListScreen({Key? key, required this.list, required this.isLoading}) : super(key: key);

  final RxList<AllMatchData> list;
  final bool isLoading;

  @override
  State<TeamListScreen> createState() => _TeamListScreenState();
}

class _TeamListScreenState extends State<TeamListScreen> {
  List<String> isFavourite = SharedPreferencesDatas.getStringList(SharedPreferencesDatas.selectedMatchName);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.isLoading
        ? Center(child: SizedBox(height: height * 0.04, width: height * 0.04, child: const CircularProgressIndicator()))
        : widget.list.isEmpty
            ? Center(
                child: Text(
                  Strings.noData,
                  style: TextStyle(color: const Color(0xff2E2445), fontWeight: FontWeight.w500, letterSpacing: 0.8, fontSize: height * 0.02),
                ),
              )
            : ListView.builder(
                itemCount: widget.list.length,
                padding: EdgeInsets.only(bottom: height * 0.14, top: height * 0.04),
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return commonContainer(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              // await AdsHelper.showInterstitialAds();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return TeamsMatch(
                                      title: widget.list[index].title,
                                      matchData: widget.list[index],
                                    );
                                  },
                                ),
                              );
                              print(index);
                            },
                            child: MarqueeWidget(
                              direction: Axis.horizontal,
                              backDuration: const Duration(milliseconds: 10),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  widget.list[index].title,
                                  softWrap: false,
                                  maxLines: 1,
                                  style: TextStyle(fontSize: minSize * 0.045),
                                ),
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
                                  isFavourite.contains(widget.list[index].title)
                                      ? isFavourite.remove(widget.list[index].title)
                                      : isFavourite.add(widget.list[index].title);
                                });
                                SharedPreferencesDatas.getStringList(SharedPreferencesDatas.selectedMatchName).clear();
                                SharedPreferencesDatas.setStringList(SharedPreferencesDatas.selectedMatchName, isFavourite);
                              },
                              icon: Icon(
                                isFavourite.contains(widget.list[index].title) ? Icons.star : Icons.star_border,
                                size: (height * 0.07) * 0.6,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
  }
}
