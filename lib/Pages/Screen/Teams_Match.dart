// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../../Custom/my_icons_icons.dart';

class TeamsMatch extends StatefulWidget {
  const TeamsMatch({Key? key,required this.title}) : super(key: key);
  final String title;

  @override
  State<TeamsMatch> createState() => _TeamsMatchState();
}

class _TeamsMatchState extends State<TeamsMatch> {
  late double height = MediaQuery.of(context).size.height;
  late double width = MediaQuery.of(context).size.width;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          height: double.maxFinite,
          decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage('asset/appbar.png'), fit: BoxFit.fill),
          ),
          child: Row(
            children: [
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(MyIcons.backArrow)),
               Text(
                 "${widget.title}'s  Teams",
                style: const TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage('asset/background.png'), fit: BoxFit.fill),
        ),
      ),
    );
  }
}
