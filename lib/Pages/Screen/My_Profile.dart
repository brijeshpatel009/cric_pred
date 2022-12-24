import 'package:flutter/material.dart';

import '../../Custom/my_icons_icons.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  late double height = MediaQuery.of(context).size.height;
  late double width = MediaQuery.of(context).size.width;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage('asset/appbar.png'), fit: BoxFit.fill),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(MyIcons.backArrow),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 17),
                  child: Text(widget.title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                )
              ],
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('asset/background.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width - (width * 0.95),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * 0.05),
                const Text('Name'),
                Container(
                  height: height * 0.07,
                  width: width * 0.9,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(13),
                      topRight: Radius.circular(13),
                      topLeft: Radius.circular(13),
                      bottomLeft: Radius.circular(13),
                    ),
                    color: Color(0xff9BDCFF),
                  ),
                ),
                SizedBox(height: height * 0.03),
                const Text('E-mail'),
                Container(
                  height: height * 0.07,
                  width: width * 0.9,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(13),
                      topRight: Radius.circular(13),
                      topLeft: Radius.circular(13),
                      bottomLeft: Radius.circular(13),
                    ),
                    color: Color(0xff9BDCFF),
                  ),
                ),
                SizedBox(height: height * 0.03),
                const Text('UserName'),
                Container(
                  height: height * 0.07,
                  width: width * 0.9,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(13),
                      topRight: Radius.circular(13),
                      topLeft: Radius.circular(13),
                      bottomLeft: Radius.circular(13),
                    ),
                    color: Color(0xff9BDCFF),
                  ),
                ),
                SizedBox(height: height * 0.03),
                const Text('Mobile'),
                Container(
                  height: height * 0.07,
                  width: width * 0.9,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(13),
                      topRight: Radius.circular(13),
                      topLeft: Radius.circular(13),
                      bottomLeft: Radius.circular(13),
                    ),
                    color: Color(0xff9BDCFF),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
