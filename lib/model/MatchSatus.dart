// ignore_for_file: file_names

import 'dart:convert';

List<MatchStatus> matchStatusFromJson(String str) => List<MatchStatus>.from(json.decode(str).map((x) => MatchStatus.fromJson(x)));

String matchStatusToJson(MatchStatus data) => json.encode(data.toJson());

class MatchStatus {
  MatchStatus({
    required this.matchst,
    required this.success,
    required this.msg,
  });

  List<Matchst> matchst;
  bool success;
  String msg;

  factory MatchStatus.fromJson(Map<String, dynamic> json) => MatchStatus(
        matchst: List<Matchst>.from(json["Matchst"].map((x) => Matchst.fromJson(x))),
        success: json["success"],
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "Matchst": List<dynamic>.from(matchst.map((x) => x.toJson())),
        "success": success,
        "msg": msg,
      };
}

class Matchst {
  Matchst({
    required this.matchname,
    required this.stat1Name,
    required this.stat2Name,
    required this.stat3Name,
    required this.stat1Descr,
    required this.stat2Descr,
    required this.stat3Descr,
    required this.matchId,
  });

  String matchname;
  String stat1Name;
  String stat2Name;
  String stat3Name;
  String stat1Descr;
  String stat2Descr;
  String stat3Descr;
  int matchId;

  factory Matchst.fromJson(Map<String, dynamic> json) => Matchst(
        matchname: json["matchname"],
        stat1Name: json["stat1name"],
        stat2Name: json["stat2name"],
        stat3Name: json["stat3name"],
        stat1Descr: json["stat1descr"],
        stat2Descr: json["stat2descr"],
        stat3Descr: json["stat3descr"],
        matchId: json["MatchId"],
      );

  Map<String, dynamic> toJson() => {
        "matchname": matchname,
        "stat1name": stat1Name,
        "stat2name": stat2Name,
        "stat3name": stat3Name,
        "stat1descr": stat1Descr,
        "stat2descr": stat2Descr,
        "stat3descr": stat3Descr,
        "MatchId": matchId,
      };
}
