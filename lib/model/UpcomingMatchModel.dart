import 'dart:convert';

class UpComingModel {
  UpComingModel({
    required this.playerslist,
    required this.allMatch,
    required this.success,
    required this.msg,
  });

  dynamic playerslist;
  List<UpComingModelAllMatch> allMatch;
  bool success;
  String msg;

  factory UpComingModel.fromRawJson(String str) => UpComingModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UpComingModel.fromJson(Map<String, dynamic> json) => UpComingModel(
        playerslist: json["Playerslist"],
        allMatch: List<UpComingModelAllMatch>.from(json["AllMatch"].map((x) => UpComingModelAllMatch.fromJson(x))),
        success: json["success"],
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "Playerslist": playerslist,
        "AllMatch": List<dynamic>.from(allMatch.map((x) => x.toJson())),
        "success": success,
        "msg": msg,
      };
}

class UpComingModelAllMatch {
  UpComingModelAllMatch({
    required this.title,
    required this.matchtime,
    required this.venue,
    required this.matchId,
    required this.teamA,
    required this.teamB,
    required this.teamAImage,
    required this.matchtype,
    required this.teamBImage,
    required this.result,
    required this.imageUrl,
  });

  String title;
  String matchtime;
  String venue;
  int matchId;
  String teamA;
  String teamB;
  String teamAImage;
  dynamic matchtype;
  String teamBImage;
  dynamic result;
  String imageUrl;

  factory UpComingModelAllMatch.fromRawJson(String str) => UpComingModelAllMatch.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UpComingModelAllMatch.fromJson(Map<String, dynamic> json) => UpComingModelAllMatch(
        title: json["Title"],
        matchtime: json["Matchtime"],
        venue: json["Venue"],
        matchId: json["MatchId"],
        teamA: json["TeamA"],
        teamB: json["TeamB"],
        teamAImage: json["TeamAImage"],
        matchtype: json["Matchtype"],
        teamBImage: json["TeamBImage"],
        result: json["Result"],
        imageUrl: json["ImageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "Title": title,
        "Matchtime": matchtime,
        "Venue": venue,
        "MatchId": matchId,
        "TeamA": teamA,
        "TeamB": teamB,
        "TeamAImage": teamAImage,
        "Matchtype": matchtype,
        "TeamBImage": teamBImage,
        "Result": result,
        "ImageUrl": imageUrl,
      };
}
