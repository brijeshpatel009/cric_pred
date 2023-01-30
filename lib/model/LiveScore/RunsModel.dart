// To parse this JSON data, do
//
//     final jsonruns = jsonrunsFromJson(jsonString);


// ignore_for_file: file_names

import 'dart:convert';

// Jsonruns jsonrunsFromJson(String str) => Jsonruns.fromJson(json.decode(str));
List<Jsonruns> jsonrunsFromJson(String str) =>
    List<Jsonruns>.from(json.decode(str).map((x) => Jsonruns.fromJson(x)));

String jsonrunsToJson(Jsonruns data) => json.encode(data.toJson());

class Jsonruns {
  Jsonruns({
    required this.jsonruns,
  });

  JsonrunsClass jsonruns;

  factory Jsonruns.fromJson(Map<String, dynamic> json) => Jsonruns(
    jsonruns: JsonrunsClass.fromJson(json["jsonruns"]),
  );

  Map<String, dynamic> toJson() => {
    "jsonruns": jsonruns.toJson(),
  };
}

class JsonrunsClass {
  JsonrunsClass({
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

  factory JsonrunsClass.fromJson(Map<String, dynamic> json) => JsonrunsClass(
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
