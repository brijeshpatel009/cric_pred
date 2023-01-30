// To parse this JSON data, do
//
//     final matchResult = matchResultFromJson(jsonString);


import 'dart:convert';

class MatchResultModel {
  MatchResultModel({
    required this.playerslist,
    required this.allMatch,
    required this.success,
    required this.msg,
  });

  dynamic playerslist;
  List<AllMatchData> allMatch;
  bool success;
  String msg;

  factory MatchResultModel.fromRawJson(String str) => MatchResultModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MatchResultModel.fromJson(Map<String, dynamic> json) => MatchResultModel(
    playerslist: json["Playerslist"],
    allMatch: List<AllMatchData>.from(json["AllMatch"].map((x) => AllMatchData.fromJson(x))),
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

class AllMatchData {
  AllMatchData({
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
  Matchtype matchtype;
  String teamBImage;
  String result;
  String imageUrl;

  factory AllMatchData.fromRawJson(String str) => AllMatchData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AllMatchData.fromJson(Map<String, dynamic> json) => AllMatchData(
    title: json["Title"],
    matchtime: json["Matchtime"],
    venue: json["Venue"],
    matchId: json["MatchId"],
    teamA: json["TeamA"],
    teamB: json["TeamB"],
    teamAImage: json["TeamAImage"],
    matchtype: matchtypeValues.map[json["Matchtype"]]!,
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
    "Matchtype": matchtypeValues.reverse[matchtype],
    "TeamBImage": teamBImage,
    "Result": result,
    "ImageUrl": imageUrl,
  };
}

enum Matchtype { T20, ODI }

final matchtypeValues = EnumValues({
  "ODI": Matchtype.ODI,
  "T20": Matchtype.T20
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
