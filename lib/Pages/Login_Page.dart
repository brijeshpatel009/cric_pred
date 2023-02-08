// ignore_for_file: file_names, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Paint/LoginScreen_Paint.dart';
import '../controller/GetAllMatchController.dart';
import '../utils/Colors.dart';
import 'SignUp_Page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    // TODO: implement initState
    //   getCricketData();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  GetAllMatchesController dataController = Get.put(GetAllMatchesController());

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xff98F6CB),
        body: Stack(
          children: [
            LoginPaint(
              width: width,
              height: height,
            ),
            // Material(
            //   elevation: 10,
            //   shape: WaveBorder(height: height,width: width),
            //   clipBehavior: Clip.antiAlias,
            // ),
            innerContainer(height * 0.37, width * 0.06),
            textContainer(height * 0.37, width * 0.06, Icons.email, 'Enter Email', false, TextInputAction.next),
            innerContainer(height * 0.46, width * 0.06),
            textContainer(height * 0.46, width * 0.06, Icons.key, 'Enter Password', true, TextInputAction.done),
            Positioned(
              top: height * 0.665,
              left: width * 0.5 - 100,
              child: Container(
                height: 45,
                width: 200,
                decoration: const BoxDecoration(color: Color(0xff1EB2A6), borderRadius: BorderRadius.all(Radius.circular(44))),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(44))),
                    backgroundColor: const Color(0xff1EB2A6),
                  ),
                  child: const Center(
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 23,
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return const SignUpScreen();
                      },
                    ));
                    print('login');
                  },
                ),
              ),
            ),
            Positioned(
              bottom: height * 0.05,
              right: width * 0.10,
              child: Column(
                children: [
                  const Text(
                    'or',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          print('Google');
                        },
                        child: const Image(
                          image: AssetImage("asset/goglImg.png"),
                          height: 50,
                          width: 50,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          print('FaceBook');
                        },
                        child: const Image(
                          image: AssetImage('asset/fbImg.png'),
                          height: 50,
                          width: 50,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          print('Twitter');
                        },
                        child: const Image(
                          image: AssetImage('asset/twtImg.png'),
                          height: 50,
                          width: 50,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget innerContainer(double top, double left) {
    return Positioned(
      top: top,
      left: left,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.054,
        width: MediaQuery.of(context).size.width * 0.6,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(55), bottomLeft: Radius.circular(55)),
            boxShadow: [
              BoxShadow(color: const Color(0xff000000).withOpacity(0.5), blurRadius: 5, spreadRadius: 1, blurStyle: BlurStyle.outer),
            ],
            color: Colors.white),
      ),
    );
  }

  Widget textContainer(double top, double left, IconData icon, String label, bool bool, TextInputAction action) {
    return Positioned(
      top: top,
      left: left,
      child: Padding(
        padding: const EdgeInsets.only(left: 5),
        child: Row(
          children: [
            Icon(
              icon,
              color: iconColor,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.054,
                width: MediaQuery.of(context).size.width * 0.61,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(55)),
                    boxShadow: [
                      BoxShadow(color: const Color(0xff000000).withOpacity(0.5), blurRadius: 5, spreadRadius: 1, blurStyle: BlurStyle.outer),
                    ],
                    color: Colors.white),
                child: TextFormField(
                  textInputAction: action,
                  maxLines: 1,
                  obscureText: bool,
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: Colors.black.withOpacity(0.1),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(left: 5),
                    isDense: true,
                    focusColor: Colors.black,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    labelText: label,
                    labelStyle: const TextStyle(fontSize: 15),
                    border: InputBorder.none,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
