// ignore_for_file: file_names, avoid_print, no_leading_underscores_for_local_identifiers
import 'package:cric_pred/Custom/tab_bar_icon_icons.dart';
import 'package:flutter/material.dart';

import '../utils/variable.dart';
import 'Screen/Home_Screen.dart';
import 'Screen/News_Screen.dart';
import 'Screen/Team_Screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  double iconSize = 30;
  late final TabController _tab = TabController(length: 3, vsync: this);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _tab,
              children: [
                HomeScreen(
                  tab: _tab,
                ),
                const TeamScreen(
                  title: 'Teams',
                ),
                const NewsScreen(
                  title: "News",
                ),
                // const ProfileScreen(),
              ],
            ),
            Positioned(
              bottom: height * 0.05,
              right: 10,
              left: 10,
              child: Container(
                height: height * 0.1,
                decoration: const BoxDecoration(
                  color: Color(0xffFFFFFF),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black45,
                      blurRadius: 6,
                      spreadRadius: 1,
                      offset: Offset(0.0, 0.0),
                    )
                  ],
                ),
                child: TabBar(
                  onTap: (int val) {
                    setState(() {
                      tabIndex = val;
                    });
                  },
                  physics: const NeverScrollableScrollPhysics(),
                  labelColor: const Color(0xff2E2445),
                  unselectedLabelColor: Colors.grey,
                  labelStyle: const TextStyle(fontSize: 13.0, color: Color(0xff2E2445)),
                  indicatorColor: Colors.transparent,
                  tabs: <Widget>[
                    tab(TabBarIcon.home, 'Home', height),
                    tab(TabBarIcon.team, 'Team', height),
                    tab(TabBarIcon.news, 'News', height),
                    // tab(Icons.person_pin, 'Profile'),
                  ],
                  controller: _tab,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget tab(IconData icon, String name, double height) {
    return Tab(
      icon: Icon(
        icon,
        size: (height * 0.1) * 0.4,
      ),
      text: name,
    );
  }
}
