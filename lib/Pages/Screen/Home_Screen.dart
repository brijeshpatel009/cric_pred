// ignore_for_file: file_names, avoid_print

import 'package:cric_pred/utils/User_Data.dart';
import 'package:flutter/material.dart';

import '../../utils/variable.dart';
import '../../widget/Match_List.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.tab}) : super(key: key);
  final TabController tab;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  List<Color> colors = [
    Colors.deepOrangeAccent.withOpacity(0.4),
    Colors.lightBlueAccent.withOpacity(0.4),
    Colors.indigo.withOpacity(0.4),
    Colors.deepOrange.withOpacity(0.4),
    Colors.pink.withOpacity(0.4),
    const Color(0xff21B152).withOpacity(0.4),
  ];

  List<String> imagePath = [
    'asset/menuImg.png',
    'asset/cricImg.png',
    'asset/cricImg.png',
    'asset/cricImg.png',
    'asset/cricImg.png',
    'asset/cricImg.png',
  ];

  late final tabController = TabController(length: 2, vsync: this, animationDuration: const Duration(seconds: 1));

  @override
  void initState() {
    matchStreamingCategoryIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage('asset/appbar.png'), fit: BoxFit.fill),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(12), bottomRight: Radius.circular(3), topRight: Radius.circular(3), topLeft: Radius.circular(3)),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        tabIndex = 2;
                        widget.tab.animateTo(tabIndex);
                      });
                      print('profile');
                    },
                    child: const Image(image: AssetImage('asset/prflImg.png'), fit: BoxFit.fill, color: Colors.brown),
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        userName,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
            ],
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
              const SizedBox(
                height: 30,
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
              SizedBox(
                height: 30,
                child: TabBar(
                    overlayColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
                      return states.contains(MaterialState.focused) ? null : Colors.transparent;
                    }),
                    onTap: (int val) {
                      setState(() {
                        matchStreamingCategoryIndex = val;
                      });
                      print(val);
                    },
                    physics: const BouncingScrollPhysics(),
                    isScrollable: false,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorColor: const Color(0xffF97900),
                    indicatorWeight: 3,
                    labelColor: Colors.black,
                    labelStyle: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                    unselectedLabelColor: Colors.blueGrey,
                    controller: tabController,
                    tabs: const [
                      Text('Live Match'),
                      Text('Upcoming'),
                    ]),
              ),

              //Matches List View

              Flexible(
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
            ],
          ),
        ),
      ),
    );
  }
}
