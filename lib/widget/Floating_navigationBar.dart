// ignore_for_file: file_names

import 'package:flutter/material.dart';

class FloatingNavigationBar extends StatefulWidget {
  const FloatingNavigationBar({Key? key}) : super(key: key);

  @override
  State<FloatingNavigationBar> createState() => _FloatingNavigationBarState();
}

class _FloatingNavigationBarState extends State<FloatingNavigationBar> with TickerProviderStateMixin {
   late final TabController _tab = TabController(length: 4, vsync: this);
   double iconSize = 30;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding:  EdgeInsets.only(bottom: size.height*0.05,top: size.height*0.79,right: 5,left: 5),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(15.0),
        ),
        child: Container(
          color: const Color(0xffFFAA59),
          child: TabBar(
            labelColor:  Colors.black87,
            unselectedLabelColor: Colors.black45,
            labelStyle: const TextStyle(fontSize: 13.0),
            indicatorColor: Colors.transparent,
            tabs:  <Widget>[
              tab(Icons.home,'Home'),
              tab(Icons.live_tv_rounded,'Live'),
              tab(Icons.people_alt,'Team'),
              tab( Icons.person_pin,'Profile'),
            ],
            controller: _tab,
          ),
        ),
      ),
    );
  }

  Widget tab(IconData icon,String name){
    return Tab(
      icon: Icon(
        icon,
        size: iconSize,
      ),
      text: name,
    );
  }
}
