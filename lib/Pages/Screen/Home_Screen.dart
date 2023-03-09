import 'dart:async';
import 'dart:math';
import 'dart:developer' as developer;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:cric_pred/DialogBox/DialogBox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../../utils/User_Data.dart';
import '../../utils/variable.dart';
import '../../widget/Match_List.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.tab}) : super(key: key);
  final TabController tab;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final tabController = TabController(length: 2, vsync: this, animationDuration: const Duration(seconds: 1));

  late StreamSubscription subscription;
  bool networkIsCheck = true;
  bool isDeviceConnected = false;
  bool isAlertSet = false;


  @override
  void initState() {
    matchStreamingCategoryIndex = 0;
    super.initState();
    // var subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) async {
    //   if (result != ConnectivityResult.none) {
    //     print('YAY!------------------ Network Is connected');
    //   } else {
    //     networkIsCheck = false;
    //     alertBox("Internet not available", Alignment.center);
    //   }
    // });
    getConnectivity();
  }

  getConnectivity(){
    if(isDeviceConnected){
      showDialogBox();
    }
    subscription = Connectivity().onConnectivityChanged.listen(
          (ConnectivityResult result) async {
        isDeviceConnected = result != ConnectivityResult.none;
        if (!isDeviceConnected && isAlertSet == false) {
          showDialogBox();
          setState(() => isAlertSet = true);
        }else{
          print("Network Connected Successfully");
          setState(() => isDeviceConnected = true);
        }
      },
    );
  }

  double cardHeight = Get.height*0.15;
  double height = Get.height;
  double width = Get.width;

  @override
  Widget build(BuildContext context) {

    double size = min(height, width);

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Container(
        height: double.infinity,
        color: const Color(0xff2E2445),
        child: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: height * 0.02, horizontal: width * 0.04),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular((height * 0.07) * 0.15)),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            tabIndex = 0;
                            widget.tab.animateTo(tabIndex);
                          });
                          print('profile');
                        },
                        child: SizedBox(
                            height: height * 0.07,
                            width: height * 0.07,
                            child: const Image(image: AssetImage('asset/cricImg.png'), fit: BoxFit.fill)),
                      ),
                    ),
                  ),
                  Text(
                    userName,
                    style: TextStyle(fontSize: size * 0.05, fontWeight: FontWeight.w600, color: Colors.white),
                  ),
                ],
              ),

              //Match Category
              // SizedBox(
              //   height: 76,
              //   width: double.infinity,
              //   child: ListView.builder(
              //     physics: const BouncingScrollPhysics(),
              //     itemCount: 6,
              //     scrollDirection: Axis.horizontal,
              //     itemBuilder: (context, index) {
              //       return Padding(
              //         padding: const EdgeInsets.symmetric(horizontal: 10),
              //         child: Column(
              //           children: [
              //             GestureDetector(
              //               onTap: () {
              //                 print(index);
              //               },
              //               child: Container(
              //                 width: 60,
              //                 decoration: BoxDecoration(color: colors[index], borderRadius: BorderRadius.circular(20)),
              //                 child: Padding(
              //                   padding: const EdgeInsets.all(15),
              //                   child: Image(
              //                     image: AssetImage(imagePath[index]),
              //                   ),
              //                 ),
              //               ),
              //             ),
              //             Text(
              //               matchType[index],
              //               style: const TextStyle(fontWeight: FontWeight.w400),
              //             )
              //           ],
              //         ),
              //       );
              //     },
              //   ),
              // ),
              // const SizedBox(
              //   height: 30,
              // ),

              //Live Or Upcoming Category Tab
              TabBar(
                  overlayColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
                    return states.contains(MaterialState.focused) ? null : Colors.transparent;
                  }),
                  onTap: (int val) {
                    setState(() {
                      matchStreamingCategoryIndex = val;
                    });
                    // print(val);
                  },
                  physics: const NeverScrollableScrollPhysics(),
                  isScrollable: false,
                  unselectedLabelStyle: const TextStyle(color: Color(0xffFFFFFF)),
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorColor: const Color(0xffF97900),
                  indicatorWeight: height * 0.005,
                  labelColor: const Color(0xffF97900),
                  labelStyle: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                  unselectedLabelColor: Colors.white,
                  controller: tabController,
                  tabs: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: height * 0.03,
                        bottom: height * 0.01,
                      ),
                      child: Text('Live Match', style: TextStyle(fontSize: width * 0.05, fontWeight: FontWeight.w400)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: height * 0.03,
                        bottom: height * 0.01,
                      ),
                      child: Text('Upcoming', style: TextStyle(fontSize: width * 0.05, fontWeight: FontWeight.w400)),
                    ),
                  ]),

              //Matches List View

              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(height * 0.04)),
                  child: Container(
                    color: Colors.white,
                    child: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: tabController,
                      children: [
                        MatchesList(
                          matchStreamingCategoryIndex: matchStreamingCategoryIndex,
                        ),
                        MatchesList(
                          matchStreamingCategoryIndex: matchStreamingCategoryIndex,
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
    );
  }
  showDialogBox() => showCupertinoDialog<String>(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) => WillPopScope(
      onWillPop: () => Future.value(false),
      child: AlertDialog(
        title: Text('No Connection',),
        content: Text('Please check your internet connectivity',),
        actions: <Widget>[
          Center(
            child: TextButton(
              onPressed: () async {
                Navigator.pop(context);
                setState(() => isAlertSet = false);
                isDeviceConnected = await InternetConnectionChecker().hasConnection;
                if (!isDeviceConnected && isAlertSet == false) {
                  showDialogBox();
                  setState(() => isAlertSet = true);
                }
              },
              child: const Text('OK'),
            ),
          ),
        ],
      ),
    ),
  );
}