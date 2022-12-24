// ignore_for_file: file_names

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../Custom/my_icons_icons.dart';
import '../../controller/variable.dart';

class HomeMatchScoreScreen extends StatefulWidget {
  const HomeMatchScoreScreen({Key? key, required this.color, required this.teamOne, required this.teamTwo}) : super(key: key);
  final Color color;
  final String teamOne;
  final String teamTwo;

  @override
  State<HomeMatchScoreScreen> createState() => _HomeMatchScoreScreenState();
}

class _HomeMatchScoreScreenState extends State<HomeMatchScoreScreen> {
  late double height = MediaQuery.of(context).size.height;
  late double width = MediaQuery.of(context).size.width;
  int run = Random().nextInt(200);
  int runs = Random().nextInt(200);
  int wickets = Random().nextInt(12);
  int wicket = Random().nextInt(12);
  static const int _len = 5;

  @override
  void initState() {
    super.initState();
  }

  String getSystemTime() {
    var now = DateTime.now();
    return DateFormat("dd MMM - hh:mm a").format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage('asset/appbar.png'), fit: BoxFit.fill),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(MyIcons.backArrow),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 6, bottom: 7,right: 7),
                      child: Container(
                        height: 43,
                        width: 43,
                        decoration: BoxDecoration(
                          color: widget.color,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(MyIcons.batBall, color: Colors.white),
                            Text(
                              'IPL',
                              style: TextStyle(fontSize: 10, color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Text(widget.teamOne, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 17)),
                        const Text('vs'),
                        Text(widget.teamTwo, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 17)),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  child: matchCategoryIndex == 0
                      ? Row(
                          children: const [
                            Text('Live'),
                            Icon(
                              Icons.circle,
                              size: 8,
                              color: Colors.red,
                            ),
                          ],
                        )
                      : Row(
                          children: const [
                            Text('Upcoming'),
                            Icon(
                              Icons.circle,
                              size: 8,
                              color: Colors.blue,
                            ),
                          ],
                        ),
                ),
              ],
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('asset/background.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: height * 0.05,
              ),
              Container(
                width: width * 0.9,
                height: height * 0.13,
                decoration: const BoxDecoration(
                  color: Color(0xffFFFFFF),
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 5,
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(2.5),
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(25),
                                ),
                                border: Border.all(color: Colors.black)),
                            child: matchCategoryIndex == 0
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Text(
                                        'Live',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      Icon(
                                        Icons.circle,
                                        color: Colors.red,
                                        size: 8,
                                      ),
                                    ],
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Text('Upcoming', style: TextStyle(fontSize: 12)),
                                      Icon(
                                        Icons.circle,
                                        color: Colors.blue,
                                        size: 8,
                                      ),
                                    ],
                                  ),
                          ),
                          SizedBox(width: (width * 0.9) * 0.03),
                          Text(
                            'Start: ${getSystemTime()}',
                            style: const TextStyle(fontSize: 15),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${widget.teamOne} (B)',
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text('$run/$wickets (0.0)')
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${widget.teamTwo} (W)',
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text('$runs/$wicket (0.0)')
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              Flexible(
                child: ListView.builder(
                  itemCount: _len,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(bottom: height * 0.02, right: width * 0.06, left: width * 0.06),
                      height: height * 0.1,
                      decoration: const BoxDecoration(
                        color: Color(0xff9BDCFF),
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: Text(
                              'Who win the match?',
                            ),
                          ),
                          Container(
                            width: width * 0.35,
                            decoration: const BoxDecoration(
                              color: Color(0xff70CDFF),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: (width * 0.35) * 0.1, vertical: (height * 0.08) * 0.1),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: (height * 0.11) * 0.35,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black, width: 1),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 2),
                                      child: Row(
                                        children: [
                                          Text(widget.teamOne),
                                          const Spacer(),
                                          const Text('(0.0)'),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: (height * 0.11) * 0.35,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black, width: 1),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 2),
                                      child: Row(
                                        children: [
                                          Text(widget.teamTwo),
                                          const Spacer(),
                                          const Text('(0.0)'),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
