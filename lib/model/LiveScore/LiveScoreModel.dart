import 'package:meta/meta.dart';
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

  factory LiveScoreModel.fromJson(Map<String, dynamic> json) =>
      LiveScoreModel(
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

  Map<String, dynamic> toJson() =>
      {
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
