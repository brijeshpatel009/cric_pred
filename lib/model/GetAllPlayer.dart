// To parse this JSON data, do
//
//     final allPlayer = allPlayerFromJson(jsonString);

// ignore_for_file: file_names, constant_identifier_names, avoid_print

import 'dart:async';
import 'dart:convert';

class AllPlayer {
  AllPlayer({
   required this.playerslist,
   required this.allMatch,
   required this.success,
   required this.msg,
  });

  List<Playerslist> playerslist;
  dynamic allMatch;
  bool success;
  String msg;

  factory AllPlayer.fromRawJson(String str) => AllPlayer.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AllPlayer.fromJson(Map<String, dynamic> json) => AllPlayer(
    playerslist: List<Playerslist>.from(json["Playerslist"].map((x) => Playerslist.fromJson(x))),
    allMatch: json["AllMatch"],
    success: json["success"],
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "Playerslist": List<dynamic>.from(playerslist.map((x) => x.toJson())),
    "AllMatch": allMatch,
    "success": success,
    "msg": msg,
  };
}

class Playerslist {
  Playerslist({
   required this.teamName,
   required this.playerName,
   required this.matchId,
   required this.teamRuns,
   required this.playerImage,
   required this.runs,
   required this.teamSide,
   required this.balls,
   required this.four,
   required this.six,
   required this.seqno,
   required this.outby,
   required this.inning,
   required this.isnotout,
  });

  TeamName teamName;
  String playerName;
  int matchId;
  TeamRuns teamRuns;
  String playerImage;
  int runs;
  TeamSide teamSide;
  int balls;
  int four;
  int six;
  int seqno;
  String outby;
  int inning;
  int isnotout;

  factory Playerslist.fromRawJson(String str) => Playerslist.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Playerslist.fromJson(Map<String, dynamic> json) => Playerslist(
    teamName: teamNameValues.map[json["TeamName"]]!,
    playerName: json["PlayerName"],
    matchId: json["MatchId"],
    teamRuns: teamRunsValues.map[json["TeamRuns"]]!,
    playerImage: json["PlayerImage"],
    runs: json["Runs"],
    teamSide: teamSideValues.map[json["TeamSide"]]!,
    balls: json["Balls"],
    four: json["four"],
    six: json["six"],
    seqno: json["seqno"],
    outby: json["outby"],
    inning: json["inning"],
    isnotout: json["isnotout"],
  );

  Map<String, dynamic> toJson() => {
    "TeamName": teamNameValues.reverse[teamName],
    "PlayerName": playerName,
    "MatchId": matchId,
    "TeamRuns": teamRunsValues.reverse[teamRuns],
    "PlayerImage": playerImage,
    "Runs": runs,
    "TeamSide": teamSideValues.reverse[teamSide],
    "Balls": balls,
    "four": four,
    "six": six,
    "seqno": seqno,
    "outby": outby,
    "inning": inning,
    "isnotout": isnotout,
  };
}

enum TeamName { M_RENEGADES, M_STARS }

final teamNameValues = EnumValues({
  "M Renegades": TeamName.M_RENEGADES,
  "M Stars": TeamName.M_STARS
});

enum TeamRuns { THE_141720, THE_108920 }

final teamRunsValues = EnumValues({
  "108/9 (20": TeamRuns.THE_108920,
  "141/7 (20": TeamRuns.THE_141720
});

enum TeamSide { TEAM_A, TEAM_B }

final teamSideValues = EnumValues({
  "Team A": TeamSide.TEAM_A,
  "Team B": TeamSide.TEAM_B
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap!;
  }
}



StreamController<AllPlayer> allPlayerController = StreamController();
late Stream<AllPlayer> dataStream;
Future<void> getAllPlayer(Map<String , dynamic> response) async {
  print(response);
  final dataBody = json.decode(response.toString());
  AllPlayer dataModel = AllPlayer.fromJson(dataBody);
  // add API response to stream controller sink
  allPlayerController.sink.add(dataModel);
  dataStream = allPlayerController.stream.asBroadcastStream();
}