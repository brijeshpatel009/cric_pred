// ignore_for_file: file_names

import 'dart:io';

import 'package:cric_pred/Pages/Login_Page.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../utils/String.dart';
import '../../utils/User_Data.dart';
import '../../utils/variable.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int statement = 0;
  int profile = 0;
  double borderWidth = 1;
  double padding = 15;
  bool enableName = false;
  bool enableEmail = false;
  bool enableMobile = false;
  XFile? image;
  ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    imageSelectorGallery() async {
      image = await picker.pickImage(source: ImageSource.gallery);
      setState(() {});
    }

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
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
                        matchStreamingCategoryIndex = 3;
                      });
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
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('asset/background.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              top: height * 0.05,
              right: 10,
              left: 10,
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xff70CDFF), width: 15),
                      borderRadius: BorderRadius.circular((height * 0.15) * 2),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular((height * 0.15) * 2),
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          image == null
                              ? Container(
                                  height: height * 0.19,
                                  width: height * 0.19,
                                  color: Colors.brown,
                                )
                              : Image.file(
                                  File(image!.path),
                                  fit: BoxFit.cover,
                                  height: height * 0.15,
                                  width: width * 0.325,
                                ),
                          GestureDetector(
                            onTap: imageSelectorGallery,
                            child: Container(
                              height: (height * 0.15) * 0.2,
                              width: width * 0.325,
                              color: Colors.black.withOpacity(0.4),
                              child: const Center(
                                child: Icon(
                                  Icons.monochrome_photos_outlined,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: padding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: height * 0.07,
                          width: width * 0.13,
                          decoration: const BoxDecoration(
                            color: Color(0xff70CDFF),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              bottomLeft: Radius.circular(15),
                            ),
                          ),
                          child: const Center(
                            child: Icon(Icons.person, size: 33),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              profile == 0 ? profile = 1 : profile = 0;
                            });
                          },
                          child: Container(
                            height: height * 0.07,
                            width: width * 0.75,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(13),
                                topRight: Radius.circular(13),
                              ),
                              color: Color(0xff9BDCFF),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10, left: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(Strings.myProfile),
                                  Icon(profile == 0 ? Icons.chevron_right_outlined : Icons.keyboard_arrow_down_outlined),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (profile == 1)
                    SizedBox(
                      width: 270,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 30,
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(color: const Color(0xff000000).withOpacity(0.44), width: borderWidth),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Name: ',
                                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                                  ),
                                  Expanded(
                                    child: TextField(
                                      controller: user,
                                      enabled: enableName,
                                      autofocus: true,
                                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                                      decoration: const InputDecoration(
                                        isDense: true,
                                        focusColor: Colors.black,
                                        floatingLabelBehavior: FloatingLabelBehavior.never,
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    splashRadius: 0.1,
                                    onPressed: () {
                                      setState(() {
                                        if (enableName == false) {
                                          enableName = true;
                                        } else {
                                          enableName = false;
                                          userName = user.text;
                                        }
                                      });
                                    },
                                    icon: Icon(enableName == false ? Icons.edit : Icons.done, size: 18),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 30,
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(color: const Color(0xff000000).withOpacity(0.44), width: borderWidth),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Email: ',
                                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                                  ),
                                  Expanded(
                                    child: TextField(
                                      controller: email,
                                      enabled: enableEmail,
                                      autofocus: true,
                                      keyboardType: TextInputType.emailAddress,
                                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                                      decoration: const InputDecoration(
                                        isDense: true,
                                        focusColor: Colors.black,
                                        floatingLabelBehavior: FloatingLabelBehavior.never,
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    splashRadius: 0.1,
                                    onPressed: () {
                                      setState(() {
                                        if (enableEmail == false) {
                                          enableEmail = true;
                                        } else {
                                          enableEmail = false;
                                          userEmail = email.text;
                                        }
                                      });
                                    },
                                    icon: Icon(enableEmail == false ? Icons.edit : Icons.done, size: 18),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 30,
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(color: const Color(0xff000000).withOpacity(0.44), width: borderWidth),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Mobile: ',
                                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                                  ),
                                  Expanded(
                                    child: TextField(
                                      controller: mobileNumber,
                                      enabled: enableMobile,
                                      autofocus: true,
                                      keyboardType: TextInputType.number,
                                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                                      decoration: const InputDecoration(
                                        isDense: true,
                                        focusColor: Colors.black,
                                        floatingLabelBehavior: FloatingLabelBehavior.never,
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    splashRadius: 0.1,
                                    onPressed: () {
                                      setState(() {
                                        if (enableMobile == false) {
                                          enableMobile = true;
                                        } else {
                                          enableMobile = false;
                                          userMobileNumber = mobileNumber.text;
                                        }
                                      });
                                    },
                                    icon: Icon(enableMobile == false ? Icons.edit : Icons.done, size: 18),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  Padding(
                    padding: EdgeInsets.only(bottom: padding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: height * 0.07,
                          width: width * 0.13,
                          decoration: const BoxDecoration(
                            color: Color(0xff70CDFF),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              bottomLeft: Radius.circular(15),
                            ),
                          ),
                          child: const Center(
                            child: Icon(Icons.lock, size: 30),
                          ),
                        ),
                        Container(
                          height: height * 0.07,
                          width: width * 0.75,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(13),
                              topRight: Radius.circular(13),
                            ),
                            color: Color(0xff9BDCFF),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10, left: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text('Change password'),
                                Icon(Icons.chevron_right_outlined),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: padding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: height * 0.07,
                          width: width * 0.13,
                          decoration: const BoxDecoration(
                            color: Color(0xff70CDFF),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              bottomLeft: Radius.circular(15),
                            ),
                          ),
                          child: const Center(
                            child: Icon(Icons.mobile_screen_share, size: 30),
                          ),
                        ),
                        Container(
                          height: height * 0.07,
                          width: width * 0.75,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(13),
                              topRight: Radius.circular(13),
                            ),
                            color: Color(0xff9BDCFF),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10, left: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text('Share'),
                                Icon(Icons.chevron_right_outlined),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: padding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: height * 0.07,
                          width: width * 0.13,
                          decoration: const BoxDecoration(
                            color: Color(0xff70CDFF),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              bottomLeft: Radius.circular(15),
                            ),
                          ),
                          child: const Center(
                            child: Icon(Icons.star_rate_rounded, size: 30),
                          ),
                        ),
                        Container(
                          height: height * 0.07,
                          width: width * 0.75,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(13),
                              topRight: Radius.circular(13),
                            ),
                            color: Color(0xff9BDCFF),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10, left: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text('Rate Us'),
                                Icon(Icons.chevron_right_outlined),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) {
                          return const LoginScreen();
                        },
                      ));
                    },
                    child: Padding(
                      padding: EdgeInsets.only(bottom: padding),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: height * 0.07,
                            width: width * 0.13,
                            decoration: const BoxDecoration(
                              color: Color(0xff70CDFF),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                bottomLeft: Radius.circular(15),
                              ),
                            ),
                            child: const Center(
                              child: Icon(Icons.exit_to_app, size: 30),
                            ),
                          ),
                          Container(
                            height: height * 0.07,
                            width: width * 0.75,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(13),
                                topRight: Radius.circular(13),
                              ),
                              color: Color(0xff9BDCFF),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10, left: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text('Log Out'),
                                  Icon(Icons.chevron_right_outlined),
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
            ),
          ),
        ),
      ),
    );
  }
}
