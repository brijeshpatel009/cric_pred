import 'dart:developer';

import 'package:cric_pred/Custom/my_icons_icons.dart';
import 'package:cric_pred/controller/GetAllMatchController.dart';
import 'package:cric_pred/controller/GetAllPlayerController.dart';
import 'package:cric_pred/model/LiveScore/LiveScoreModel.dart';
import 'package:cric_pred/model/LiveScore/MatchDataModel.dart';
import 'package:cric_pred/model/LiveScore/MatchRunsModel.dart';
import 'package:cric_pred/model/UpcomingMatchModel.dart';
import 'package:cric_pred/utils/variable.dart';
import 'package:cric_pred/widget/commonWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/Shared_Pref.dart';

class PridictionPage extends StatefulWidget {
  const PridictionPage({Key? key}) : super(key: key);

  @override
  State<PridictionPage> createState() => _PridictionPageState();
}

class _PridictionPageState extends State<PridictionPage> {

  late double height = MediaQuery.of(context).size.height;
  late double width = MediaQuery.of(context).size.width;
  LiveScoreRunModel? liveMatchRun;
  MatchDataModel? liveMatchData;

  late GetPlayerAndRunController getAllPlayerController;
  final GetAllMatchesController getMatchController = Get.find();
  bool isvalid = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isvalid = SharedPreferencesDatas.getBool(SharedPreferencesDatas.isSelcted);
    print(isvalid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: Container(
        height: double.infinity,
        color: const Color(0xff2E2445),
        child: Stack(
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: height * 0.025, horizontal: width * 0.05),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(MyIcons.backArrow,
                        color: Colors.white),
                  ),
                ),
                Text(
                  "Team A",
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                      color: Colors.white),
                ),
                const Text(
                  ' vs ',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                      color: Colors.white),
                ),
                Text(
                  "Team B",
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                      color: Colors.white),
                ),
              ],
            ),
               Padding(
                 padding: EdgeInsets.only(top: height*0.07),
                 child: Container(
                   height: height,
                   width: width,
                   decoration: BoxDecoration(
                     color: Colors.white,
                     borderRadius: BorderRadius.only(topRight: Radius.circular(height*0.035),topLeft: Radius.circular(height*0.035)),
                   ),
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.start,
                     crossAxisAlignment: CrossAxisAlignment.center,
                     children: [
                       Padding(
                         padding: EdgeInsets.only(top: height*0.02),
                         child: Container(
                           height: height * 0.3,
                           width: width / 1.15,
                           decoration: BoxDecoration(
                             color: const Color(0xffF1F5FE),
                             borderRadius: BorderRadius.all(
                                 Radius.circular(height * 0.03)),
                             boxShadow: const [
                               BoxShadow(
                                 color: Colors.black45,
                                 blurRadius: 10,
                                 spreadRadius: -1.8,
                                 offset: Offset(0.0, 0.0),
                               ),
                             ],
                           ),
                           // child: SimplePollsWidget(
                           //   onSelection: (PollFrameModel model,
                           //       PollOptions?
                           //       selectedOptionModel) {
                           //     log('Now total polls are : ${model.totalPolls}');
                           //     log('Selected option has label : ${selectedOptionModel!.label}');
                           //   },
                           //   onReset: (PollFrameModel model) {
                           //     log('Poll has been reset, this happens only in case of editable polls');
                           //   },
                           //   optionsBorderShape:
                           //   const StadiumBorder(),
                           //   optionsStyle: TextStyle(
                           //     fontSize: 13,
                           //     fontWeight: FontWeight.w500,
                           //     color: Theme.of(context)
                           //         .primaryColor,
                           //   ),
                           //   padding: const EdgeInsets.all(15),
                           //   margin: const EdgeInsets.all(15),
                           //   model: PollFrameModel(
                           //     title: Container(
                           //       alignment: Alignment.centerLeft,
                           //       child: const Text(
                           //         'Who Will Win The Match ??',
                           //         style: TextStyle(
                           //           fontSize: 15,
                           //           fontWeight: FontWeight.w500,
                           //         ),
                           //       ),
                           //     ),
                           //     totalPolls: 100,
                           //     endTime: DateTime.now()
                           //         .toUtc()
                           //         .add(
                           //         Duration(days: 5)),
                           //     // hasVoted: isvalid ? false : true,
                           //     hasVoted: isvalid ? true : false,
                           //     editablePoll: false,
                           //     options: <PollOptions>[
                           //       PollOptions(
                           //         label: "${"Team A"}",
                           //         pollsCount: 40,
                           //         isSelected: false,
                           //         id: 1,
                           //       ),
                           //       PollOptions(
                           //         label: "Draw",
                           //         pollsCount: 25,
                           //         isSelected: false,
                           //         id: 2,
                           //       ),
                           //       PollOptions(
                           //         label: "${"Team B"}",
                           //         pollsCount: 35,
                           //         isSelected: false,
                           //         id: 3,
                           //       ),
                           //     ],
                           //   ),
                           // ),
                         ),
                       ),
                       SizedBox(height: height*0.05,),
                       Flexible(
                         child: SizedBox(
                           child: SingleChildScrollView(
                             physics: BouncingScrollPhysics(),
                             child: Column(
                               children: [
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                                   crossAxisAlignment: CrossAxisAlignment.center,
                                   children: [
                                     Text("Next Ball : "),
                                     SizedBox(width: width*0.15,),
                                     Text("Six"),
                                   ],
                                 ),
                                 SizedBox(height: height*0.02,),
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                                   crossAxisAlignment: CrossAxisAlignment.center,
                                   children: [
                                     Text("Second Next Ball : "),
                                     SizedBox(width: width*0.15,),
                                     Text("Four"),
                                   ],
                                 ),
                                 SizedBox(height: height*0.02,),
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                                   crossAxisAlignment: CrossAxisAlignment.center,
                                   children: [
                                     Text("Third Next Ball : "),
                                     SizedBox(width: width*0.15,),
                                     Text("Six"),
                                   ],
                                 ),
                                 SizedBox(height: height*0.02,),
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                                   crossAxisAlignment: CrossAxisAlignment.center,
                                   children: [
                                     Text("Fourth Next Ball : "),
                                     SizedBox(width: width*0.15,),
                                     Text("Wide"),
                                   ],
                                 ),
                                 SizedBox(height: height*0.02,),
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                                   crossAxisAlignment: CrossAxisAlignment.center,
                                   children: [
                                     Text("Fifth Next Ball : "),
                                     SizedBox(width: width*0.15,),
                                     Text("0"),
                                   ],
                                 ),
                                 SizedBox(height: height*0.02,),
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                                   crossAxisAlignment: CrossAxisAlignment.center,
                                   children: [
                                     Text("last Next Ball : "),
                                     SizedBox(width: width*0.15,),
                                     Text("0"),
                                   ],
                                 ),
                                 SizedBox(height: height*0.04,),
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                                   crossAxisAlignment: CrossAxisAlignment.center,
                                   children: [
                                     Text("Next Over : "),
                                     SizedBox(width: width*0.6,),
                                   ],
                                 ),
                                 SizedBox(height: height*0.02,),
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                                   crossAxisAlignment: CrossAxisAlignment.center,
                                   children: [
                                     Text("First Ball : "),
                                     SizedBox(width: width*0.15,),
                                     Text("Four"),
                                   ],
                                 ),
                                 SizedBox(height: height*0.02,),
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                                   crossAxisAlignment: CrossAxisAlignment.center,
                                   children: [
                                     Text("Next Ball : "),
                                     SizedBox(width: width*0.15,),
                                     Text("0"),
                                   ],
                                 ),
                                 SizedBox(height: height*0.02,),
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                                   crossAxisAlignment: CrossAxisAlignment.center,
                                   children: [
                                     Text("Second Next Ball : "),
                                     SizedBox(width: width*0.06,),
                                     Text("0"),
                                   ],
                                 ),
                                 SizedBox(height: height*0.02,),
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                                   crossAxisAlignment: CrossAxisAlignment.center,
                                   children: [
                                     Text("Third Next Ball : "),
                                     SizedBox(width: width*0.08,),
                                     Text("0"),
                                   ],
                                 ),
                                 SizedBox(height: height*0.02,),
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                                   crossAxisAlignment: CrossAxisAlignment.center,
                                   children: [
                                     Text("Fourth Next Ball : "),
                                     SizedBox(width: width*0.06,),
                                     Text("Four"),
                                   ],
                                 ),
                                 SizedBox(height: height*0.02,),
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                                   crossAxisAlignment: CrossAxisAlignment.center,
                                   children: [
                                     Text("Last Ball : "),
                                     SizedBox(width: width*0.06,),
                                     Text("Six"),
                                   ],
                                 ),
                                 SizedBox(height: height*0.04,),
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                                   crossAxisAlignment: CrossAxisAlignment.center,
                                   children: [
                                     Text("Next Over : "),
                                     SizedBox(width: width*0.6,),
                                   ],
                                 ),
                                 SizedBox(height: height*0.02,),
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                                   crossAxisAlignment: CrossAxisAlignment.center,
                                   children: [
                                     Text("First Ball : "),
                                     SizedBox(width: width*0.15,),
                                     Text("Wide"),
                                   ],
                                 ),
                                 SizedBox(height: height*0.02,),
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                                   crossAxisAlignment: CrossAxisAlignment.center,
                                   children: [
                                     Text("Next Ball : "),
                                     SizedBox(width: width*0.15,),
                                     Text("0"),
                                   ],
                                 ),
                                 SizedBox(height: height*0.02,),
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                                   crossAxisAlignment: CrossAxisAlignment.center,
                                   children: [
                                     Text("Second Next Ball : "),
                                     SizedBox(width: width*0.06,),
                                     Text("Six"),
                                   ],
                                 ),
                                 SizedBox(height: height*0.02,),
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                                   crossAxisAlignment: CrossAxisAlignment.center,
                                   children: [
                                     Text("Third Next Ball : "),
                                     SizedBox(width: width*0.08,),
                                     Text("0"),
                                   ],
                                 ),
                                 SizedBox(height: height*0.02,),
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                                   crossAxisAlignment: CrossAxisAlignment.center,
                                   children: [
                                     Text("Fourth Next Ball : "),
                                     SizedBox(width: width*0.06,),
                                     Text("0"),
                                   ],
                                 ),
                                 SizedBox(height: height*0.02,),
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                                   crossAxisAlignment: CrossAxisAlignment.center,
                                   children: [
                                     Text("Last Ball : "),
                                     SizedBox(width: width*0.06,),
                                     Text("Four"),
                                   ],
                                 ),
                               ],
                             ),
                           ),
                         ),
                       ),
                     ],
                   ),
                 ),
               ),
            ],
          ),
        ),
      );
  }
}
