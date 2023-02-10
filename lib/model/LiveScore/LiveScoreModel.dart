// ignore_for_file: file_names

import 'dart:convert';

List<LiveScoreModel> liveScoreModelFromJson(String str) => List<LiveScoreModel>.from(json.decode(str).map((x) => LiveScoreModel.fromJson(x)));

String liveScoreModelToJson(List<LiveScoreModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LiveScoreModel {
  LiveScoreModel({
    required this.jsonruns,
    required this.jsondata,
    required this.title,
    required this.matchtime,
    required this.venue,
    required this.result,
    required this.isfinished,
    required this.ispriority,
    required this.teamA,
    required this.teamAImage,
    required this.teamB,
    required this.seriesid,
    required this.teamBImage,
    required this.imgeUrl,
    required this.matchType,
    required this.matchDate,
    required this.matchId,
    required this.appversion,
    required this.adphone,
    required this.adimage,
    required this.admsg,
  });

  String jsonruns;
  String jsondata;
  String title;
  String matchtime;
  String venue;
  String result;
  int isfinished;
  int ispriority;
  String teamA;
  String teamAImage;
  String teamB;
  int seriesid;
  String teamBImage;
  String imgeUrl;
  String matchType;
  String matchDate;
  int matchId;
  dynamic appversion;
  String adphone;
  String adimage;
  String admsg;

  factory LiveScoreModel.fromJson(Map<String, dynamic> json) => LiveScoreModel(
        jsonruns: json["jsonruns"],
        jsondata: json["jsondata"],
        title: json["Title"],
        matchtime: json["Matchtime"],
        venue: json["venue"],
        result: json["Result"],
        isfinished: json["isfinished"],
        ispriority: json["ispriority"],
        teamA: json["TeamA"],
        teamAImage: json["TeamAImage"],
        teamB: json["TeamB"],
        seriesid: json["seriesid"],
        teamBImage: json["TeamBImage"],
        imgeUrl: json["ImgeURL"],
        matchType: json["MatchType"],
        matchDate: json["MatchDate"],
        matchId: json["MatchId"],
        appversion: json["Appversion"],
        adphone: json["adphone"],
        adimage: json["adimage"],
        admsg: json["admsg"],
      );

  Map<String, dynamic> toJson() => {
        "jsonruns": jsonruns,
        "jsondata": jsondata,
        "Title": title,
        "Matchtime": matchtime,
        "venue": venue,
        "Result": result,
        "isfinished": isfinished,
        "ispriority": ispriority,
        "TeamA": teamA,
        "TeamAImage": teamAImage,
        "TeamB": teamB,
        "seriesid": seriesid,
        "TeamBImage": teamBImage,
        "ImgeURL": imgeUrl,
        "MatchType": matchType,
        "MatchDate": matchDate,
        "MatchId": matchId,
        "Appversion": appversion,
        "adphone": adphone,
        "adimage": adimage,
        "admsg": admsg,
      };
}
