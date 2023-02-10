// ignore_for_file: file_names

import 'dart:convert';

class LiveScoreRunModel {
  LiveScoreRunModel({
    required this.jsonruns,
  });

  Jsonruns jsonruns;

  factory LiveScoreRunModel.fromRawJson(String str) => LiveScoreRunModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LiveScoreRunModel.fromJson(Map<String, dynamic> json) => LiveScoreRunModel(
        jsonruns: Jsonruns.fromJson(json["jsonruns"]),
      );

  Map<String, dynamic> toJson() => {
        "jsonruns": jsonruns.toJson(),
      };
}

class Jsonruns {
  Jsonruns({
    required this.runxa,
    required this.runxb,
    required this.fav,
    required this.rateA,
    required this.rateB,
    required this.sessionA,
    required this.sessionB,
    required this.sessionOver,
    required this.summary,
    required this.stat,
  });

  String runxa;
  String runxb;
  String fav;
  String rateA;
  String rateB;
  String sessionA;
  String sessionB;
  String sessionOver;
  String summary;
  String stat;

  factory Jsonruns.fromRawJson(String str) => Jsonruns.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Jsonruns.fromJson(Map<String, dynamic> json) => Jsonruns(
        runxa: json["runxa"],
        runxb: json["runxb"],
        fav: json["fav"],
        rateA: json["rateA"],
        rateB: json["rateB"],
        sessionA: json["sessionA"],
        sessionB: json["sessionB"],
        sessionOver: json["sessionOver"],
        summary: json["summary"],
        stat: json["stat"],
      );

  Map<String, dynamic> toJson() => {
        "runxa": runxa,
        "runxb": runxb,
        "fav": fav,
        "rateA": rateA,
        "rateB": rateB,
        "sessionA": sessionA,
        "sessionB": sessionB,
        "sessionOver": sessionOver,
        "summary": summary,
        "stat": stat,
      };
}
