import 'dart:convert';
import 'dart:math';

import 'package:cric_pred/Pages/Screen/Home_Match_Scor.dart';
import 'package:cric_pred/Pages/Screen/Home_Screen.dart';
import 'package:cric_pred/controller/GetController.dart';
import 'package:cric_pred/model/GetAllPlayer.dart';
import 'package:cric_pred/model/LiveScore/LiveScoreModel.dart';
import 'package:cric_pred/model/LiveScoreModel/LiveScore.dart';
import 'package:cric_pred/model/MatchesResult.dart';
import 'package:cric_pred/model/News.dart';
import 'package:cric_pred/utils/variable.dart';
import 'package:cric_pred/widget/Match_List.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:http/http.dart' as http;

class LiveScore extends StatefulWidget {
  final String title;
  const LiveScore({Key? key, required this.title,}) : super(key: key);

  @override
  State<LiveScore> createState() => _LiveScoreState();
}

class _LiveScoreState extends State<LiveScore> {

  late double height = MediaQuery.of(context).size.height;
  late double width = MediaQuery.of(context).size.width;
  int run = Random().nextInt(200);
  int runs = Random().nextInt(200);
  int wickets = Random().nextInt(12);
  int wicket = Random().nextInt(12);
  static const int _len = 5;

  List<Color> matchesColor = [
    const Color(0xff525298),
    const Color(0xff42BDFE),
    const Color(0xffDD52E1),
    const Color(0xffFCBC03),
    const Color(0xff21B07E),
    const Color(0xff0505DD),
    const Color(0xff525298),
    const Color(0xff42BDFE),
    const Color(0xffDD52E1),
    const Color(0xffFCBC03),
    const Color(0xff21B07E),
    const Color(0xff0505DD),
    const Color(0xff525298),
    const Color(0xff42BDFE),
    const Color(0xffDD52E1),
    const Color(0xffFCBC03),
    const Color(0xff21B07E),
    const Color(0xff0505DD),
    const Color(0xff525298),
    const Color(0xff42BDFE),
    const Color(0xffDD52E1),
    const Color(0xffFCBC03),
    const Color(0xff21B07E),
    const Color(0xff0505DD),
    const Color(0xff525298),
    const Color(0xff42BDFE),
    const Color(0xffDD52E1),
    const Color(0xffFCBC03),
    const Color(0xff21B07E),
    const Color(0xff0505DD),
    const Color(0xff525298),
    const Color(0xff42BDFE),
    const Color(0xffDD52E1),
    const Color(0xffFCBC03),
    const Color(0xff21B07E),
    const Color(0xff0505DD),
    const Color(0xff525298),
    const Color(0xff42BDFE),
    const Color(0xffDD52E1),
    const Color(0xffFCBC03),
    const Color(0xff21B07E),
    const Color(0xff0505DD),
    const Color(0xff525298),
    const Color(0xff42BDFE),
    const Color(0xffDD52E1),
    const Color(0xffFCBC03),
    const Color(0xff21B07E),
    const Color(0xff0505DD),
    const Color(0xff525298),
    const Color(0xff42BDFE),
    const Color(0xffDD52E1),
    const Color(0xffFCBC03),
    const Color(0xff21B07E),
    const Color(0xff0505DD),
    const Color(0xff525298),
    const Color(0xff42BDFE),
    const Color(0xffDD52E1),
    const Color(0xffFCBC03),
    const Color(0xff21B07E),
    const Color(0xff0505DD),
    const Color(0xff525298),
    const Color(0xff42BDFE),
    const Color(0xffDD52E1),
    const Color(0xffFCBC03),
    const Color(0xff21B07E),
    const Color(0xff0505DD),
    const Color(0xff525298),
    const Color(0xff42BDFE),
    const Color(0xffDD52E1),
    const Color(0xffFCBC03),
    const Color(0xff21B07E),
    const Color(0xff0505DD),
    const Color(0xff525298),
    const Color(0xff42BDFE),
    const Color(0xffDD52E1),
    const Color(0xffFCBC03),
    const Color(0xff21B07E),
    const Color(0xff0505DD),
    const Color(0xff525298),
    const Color(0xff42BDFE),
    const Color(0xffDD52E1),
    const Color(0xffFCBC03),
    const Color(0xff21B07E),
    const Color(0xff0505DD),
    const Color(0xff525298),
    const Color(0xff42BDFE),
    const Color(0xffDD52E1),
    const Color(0xffFCBC03),
    const Color(0xff21B07E),
    const Color(0xff0505DD),
  ];

  Future<LiveScoreModel> futurelivescore() async {
    final http.Response response = await http.get(Uri.parse("http://cricpro.cricnet.co.in/api/values/LiveLine"));

    if (response.statusCode == 200) {
      return LiveScoreModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update album.');
    }
  }

  @override
  void initState() {
    matchStreamingCategoryIndex = 0;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  GetDataController matchDataController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            height: double.maxFinite,
            decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage('asset/appbar.png'), fit: BoxFit.fill),
            ),
          ),
          title: Text(widget.title, style: const TextStyle(color: Colors.black)),
          centerTitle: true,
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
          child: FutureBuilder<LiveScoreModel>(
           future: futurelivescore(),
              builder: (context, snapshot) {
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Container(
                      height: height * 0.13,
                      margin: EdgeInsets.only(
                        top: height*0.03,
                        left: width*0.03,
                        right: width*0.03,
                      ),
                      child: Stack(
                        children: [
                          Container(
                            width: height * 0.115,
                            height: height * 0.115,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(blurStyle: BlurStyle.outer, color: Colors.black.withOpacity(0.4), blurRadius: 4),
                              ],
                              border: Border.all(width: (height * 0.1152) * 0.08, color: matchesColor[index],),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(170),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 3,
                            child: Container(
                              width: width * 0.82,
                              height: height * 0.115,
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
                                padding: EdgeInsets.only(left: (height * 0.115) * 0.6, right: (width * 0.82) * 0.05),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      children: [
                                        const Text(
                                          "Live",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w700),
                                        ),
                                        SizedBox(width: width*0.01,),
                                        const Icon(Icons.circle,size: 10,color: Colors.red,),
                                        SizedBox(width: width*0.02,),
                                        const Text("Starts: 31 jan - 7:30 PM",style: TextStyle(color: Colors.black,fontSize: 13,fontWeight: FontWeight.w500)),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          textAlign: TextAlign.center,
                                          "RCB (B)",
                                          style: TextStyle(color: Colors.black, fontSize: 15),
                                        ),
                                        matchStreamingCategoryIndex == 0
                                            ? Column(
                                          children: [
                                            Container(
                                              height: height*0.015,
                                              width: width*0.09,
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                                color: Colors.white,
                                                border: Border.symmetric(horizontal: BorderSide(color: Colors.black),vertical: BorderSide(color: Colors.black)),
                                              ),
                                              child: const Center(child: Text("IPL",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 10))),
                                            ),
                                            SizedBox(height: height*0.0045,),
                                            const Text('112/1 (12.3)',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w700,color: Colors.black,)),
                                            Row(
                                              children: const [
                                                Text('169/10 (19.5)',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w700,color: Colors.black,)),
                                              ],
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
                                      ],
                                    ),
                                    const Text(
                                      "CSK (W)",
                                      style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w400),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: height*0.0003),
                                      child: const Center(
                                        child: Text("RCB Needs 57 runs in 45 balls",style: TextStyle(fontSize: 10,color: Colors.red,fontWeight: FontWeight.w500)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: width * 0.025,
                            top: (height * 0.115) * 0.1,
                            child: Container(
                              height: (height * 0.115) * 0.8,
                              width: (height * 0.115) * 0.8,
                              decoration: BoxDecoration(
                                color:  matchesColor[index],
                                borderRadius: BorderRadius.circular(165),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Image(image: AssetImage('asset/cricImg.png'), height: 30),
                                  Text(
                                    "IPL",
                                    style: TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },);
              },
          ),
        ),
      ),
    );
  }
}
