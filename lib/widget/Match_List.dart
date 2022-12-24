
// ignore_for_file: file_names, avoid_print

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timer_builder/timer_builder.dart';

import '../Pages/Screen/Home_Match_Scor.dart';
import '../controller/variable.dart';

class MatchesList extends StatefulWidget {
  const MatchesList({Key? key,required this.itemCount}) : super(key: key);
  final int itemCount;

  @override
  State<MatchesList> createState() => _MatchesListState();
}

class _MatchesListState extends State<MatchesList> {
  List<Color> matchesColor = [
     const Color(0xff525298),
     const Color(0xff42BDFE),
     const Color(0xffDD52E1),
     const Color(0xffFCBC03),
     const Color(0xff21B07E),
     const Color(0xff0505DD),
  ];
  List<String> teamsOne=[
    'RCB',
    'KKR',
    'CSK',
    'SRH',
    'KKR',
    'RCB',
  ];
  List<String> teamTwo =[
    'DC',
    'MI',
    'RR',
    'LSG',
    'RCB',
    'CSK',
  ];

  String getSystemTime() {
    var now = DateTime.now();
    return DateFormat("dd MMM - hh:mm a").format(now);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(top: 15,bottom: 100),
      itemCount: widget.itemCount,
      itemBuilder: (context, index) {
        return Container(
          height: 100,
          margin: const EdgeInsets.only(left: 15, right: 15,),
          child: Stack(
            children: [
              Container(
                width: 85,
                height: 85,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(blurStyle: BlurStyle.outer, color: Colors.black.withOpacity(0.4), blurRadius: 4),
                  ],
                  border: Border.all(width: 8, color: matchesColor[index]),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(170),
                  ),
                ),
              ),
              Positioned(
                right: 3,
                child: GestureDetector(
                  // behavior: HitTestBehavior.translucent,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return HomeMatchScoreScreen(color: matchesColor[index], teamOne: teamsOne[index], teamTwo: teamTwo[index],);
                    },));
                    print(index);
                  },
                  child: Container(
                    width: 285,
                    height: 85,
                    decoration: BoxDecoration(
                      color: const Color(0xffFFFFFF),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xff000000).withOpacity(0.5),
                          blurRadius: 5,
                        ),
                      ],
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 50, right: 20, top: 2.5, bottom: 2.5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Text(
                                teamsOne[index],
                                style: const TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w700),
                              ),
                              const Text(
                                ' vs ',
                                style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w400),
                              ),
                              Text(
                                teamTwo[index],
                                style: const TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w700),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 15,
                                width: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.black),
                                ),
                                child: const Text(
                                  textAlign: TextAlign.center,
                                  'IPL',
                                  style: TextStyle(color: Colors.black, fontSize: 11),
                                ),
                              ),
                              matchCategoryIndex == 0
                                  ? Row(
                                children:  const [
                                  Text('Live'),
                                  Icon(
                                    Icons.circle,
                                    size: 8,
                                    color: Colors.red,
                                  ),
                                ],
                              )
                                  : Row(
                                children:  const [
                                  Text('Upcoming'),
                                  Icon(
                                    Icons.circle,
                                    size: 8,
                                    color: Colors.blue,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          TimerBuilder.periodic(const Duration(seconds: 1), builder: (context) {
                            return Text(
                              "Starts:${getSystemTime()}",
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 10,
                top: 10,
                child: Container(
                  height: 65,
                  width: 65,
                  decoration: BoxDecoration(
                    color: matchesColor[index],
                    borderRadius: BorderRadius.circular(165),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Image(image: AssetImage('asset/cricImg.png'), height: 30),
                      Text(
                        'IPL',
                        style: TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.w500),
                      )
                    ],
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
