import 'package:cric_pred/utils/utils.dart';
import 'package:flutter/material.dart';

class Strings {
  static const String team = "Team";
  static const String news = "News";
  static const String home = "Home";
  static const String live = "Live";
  static const String liveMatch = "Live Match";
  static const String upcoming = "Upcoming";
  static const String matchNotLiveText = "Currently Not Live Any Match";
  static const String international = "International";
  static const String t20 = "T20";
  static const String IPL = "IPL";
  static const String CPL = "CPL";
  static const String BPL = "BPL";
  static const String Test = "Test";
  static const String favorite = "Favorite";
  static const String dataNotAvailable = "Data Not Available";
  static const String myProfile = "My Profile";
  static const String noData = "Data Not Available!";
}

class StringStyle {
  static TextStyle batsmanH = const TextStyle(color: Colors.grey);
  static TextStyle batsmanN = const TextStyle(color: Colors.black, fontWeight: FontWeight.w500);
  static TextStyle teamNameStyle = TextStyle(
    fontSize: logoHeight * 0.1,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );
  static TextStyle scoreStyle = TextStyle(color: Colors.white, fontSize: height * 0.02);
}
