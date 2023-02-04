// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import '../Paint/LoginScreen_Paint.dart';
import '../utils/Colors.dart';
import '../utils/User_Data.dart';
import 'Home_Page.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String errorTextValue = '';
  late double height = MediaQuery.of(context).size.height;
  late double width = MediaQuery.of(context).size.width;

  // String nested = "{\"jsonruns\":{\"runxa\":\"28\",\"runxb\":\"21\",\"fav\":\"India\",\"rateA\":\"4\",\"rateB\":\"5\",\"sessionA\":\"172\",\"sessionB\":\"173\",\"sessionOver\":\"20\",\"summary\":\"PLZ RATE US 5 STARS\\n*****\\nNew Zealand tour of India, 2023\\n3rd ODI MATCH\\n\\nIndia Vs New Zealand\\n\\nToss - New Zealand won the toss and opted to bowl first\\n\\nRate Open 30-32 IND\\n\\nIndia Sessions\\nOver    Open       runs/wk            Rate    \\n10 Over (56-58) 82 Runs/0wk (10-12 IND)\\n20 Over (144-146) \\n\\n\\nLIVE ON STAR SPORTS 1\\n\\nVenue: Holkar Cricket Stadium, Indore\\n\\n\\nShare This App and Rate us on Playstore\\n\",\"stat\":\"\"}}";

  @override
  Widget build(BuildContext context) {
    // String replaceString = nested.replaceAll("\"", "");
    //  replaceString = nested.replaceAll("\n", "");
    //  replaceString = nested.replaceAll("\n\n\n", " ");
    //  var jsonData = jsonDecode(replaceString);
    // print(replaceString);
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
            Positioned(
              top: height * 0.29,
              left: width * 0.03,
              child: SizedBox(
                height: (height * 0.054) * 5.5,
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        innerContainer(),
                        innerContainer(),
                        innerContainer(),
                        innerContainer(),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        textContainer(Icons.person, 'Username', false, TextInputAction.next,user),
                        textContainer(Icons.email, 'Enter Email', false, TextInputAction.next,email),
                        textContainer(Icons.call, 'Mobile number', false, TextInputAction.next,mobileNumber),
                        textContainer(Icons.key, 'Password', true, TextInputAction.done,password),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: height * 0.665,
              left: width * 0.5 - 100,
              child: SizedBox(
                height: 45,
                width: 200,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(44))),
                    backgroundColor: const Color(0xff1EB2A6),
                  ),
                  child: const Center(
                    child: Text(
                      'Sign up',
                      style: TextStyle(
                        fontSize: 23,
                      ),
                    ),
                  ),
                  onPressed: () {
                    userName = user.text;
                    userEmail = email.text;
                    userMobileNumber = mobileNumber.text;
                    userPassword = password.text;
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return const HomePage();
                    },));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget innerContainer() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.054,
      width: MediaQuery.of(context).size.width * 0.52,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(55), bottomLeft: Radius.circular(55)),
          boxShadow: [
            BoxShadow(color: const Color(0xff000000).withOpacity(0.5), blurRadius: 5, spreadRadius: 1, blurStyle: BlurStyle.outer),
          ],
          color: Colors.white),
    );
  }

  Widget textContainer(IconData icon, String label, bool bool, TextInputAction action,TextEditingController userData) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(left: width*0.04),
      child: Row(
        children: [
          Icon(
            icon,
            color: iconColor,
          ),
          Padding(
            padding: EdgeInsets.only(left: width*0.02),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.054,
              width: MediaQuery.of(context).size.width * 0.57,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(55)),
                  boxShadow: [
                    BoxShadow(color: const Color(0xff000000).withOpacity(0.5), blurRadius: 5, spreadRadius: 1, blurStyle: BlurStyle.outer),
                  ],
                  color: Colors.white),
              child: TextFormField(
                controller: userData,
                textInputAction: action,
                maxLines: 1,
                obscureText: bool,
                keyboardType: TextInputType.emailAddress,
                cursorColor: Colors.black.withOpacity(0.1),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: width*0.05),
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
    );
  }
}
