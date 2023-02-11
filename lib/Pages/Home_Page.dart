// ignore_for_file: file_names, avoid_print, no_leading_underscores_for_local_identifiers
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
    Size size = MediaQuery.of(context).size;
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
              bottom: size.height * 0.05,
              right: 5,
              left: 5,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(15.0),
                ),
                child: Container(
                  height: 64,
                  color: const Color(0xffFFAA59),
                  child: TabBar(
                    onTap: (int val) {
                      setState(() {
                        tabIndex = val;
                      });
                    },
                    physics: const NeverScrollableScrollPhysics(),
                    labelColor: Colors.black87,
                    unselectedLabelColor: Colors.black45,
                    labelStyle: const TextStyle(fontSize: 13.0),
                    indicatorColor: Colors.transparent,
                    tabs: <Widget>[
                      tab(Icons.home, 'Home'),
                      tab(Icons.people_alt, 'Team'),
                      tab(Icons.newspaper_rounded, 'News'),
                      // tab(Icons.person_pin, 'Profile'),
                    ],
                    controller: _tab,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget tab(IconData icon, String name) {
    return Tab(
      icon: Icon(
        icon,
        size: iconSize,
      ),
      text: name,
    );
  }
}
