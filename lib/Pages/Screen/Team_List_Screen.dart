// ignore_for_file: file_names, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/MatchesResult.dart';
import '../../utils/Shared_Pref.dart';
import 'Teams_Match.dart';

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
                              title: widget.list[index].title ?? '',
                              matchId: widget.list[index].matchId ?? 0000,
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
                        child: Center(child: Text(widget.list[index].title ?? "", maxLines: 1)),
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

                    //serviceProvider.justPostsModel.length

                    child: Center(
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
                          size: 33,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
  }
}
