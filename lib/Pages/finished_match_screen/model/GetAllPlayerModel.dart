// ignore_for_file: file_names, avoid_print

import 'dart:async';
import 'dart:convert';

class AllPlayerRunModel {
  late List<Playerslist> playerslist;
  String? allMatch;
  bool? success;
  String? msg;

  AllPlayerRunModel({required this.playerslist, this.allMatch, this.success, this.msg});

  AllPlayerRunModel.fromJson(Map<String, dynamic> json) {
    if (json['Playerslist'] != null) {
      playerslist = <Playerslist>[];
      json['Playerslist'].forEach((v) {
        playerslist.add(Playerslist.fromJson(v));
      });
    }
    allMatch = json['AllMatch'];
    success = json['success'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Playerslist'] = playerslist.map((v) => v.toJson()).toList();
    data['AllMatch'] = allMatch;
    data['success'] = success;
    data['msg'] = msg;
    return data;
  }
}

class Playerslist {
  late String teamName;
  late String playerName;
  late int matchId;
  late String teamRuns;
  late String playerImage;
  late int runs;
  late String teamSide;
  late int balls;
  late int four;
  late int six;
  late int seqno;
  late String outby;
  late int inning;
  late int isnotout;

  Playerslist(
      {required this.teamName,
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
      required this.isnotout});

  Playerslist.fromJson(Map<String, dynamic> json) {
    teamName = json['TeamName'];
    playerName = json['PlayerName'];
    matchId = json['MatchId'];
    teamRuns = json['TeamRuns'];
    playerImage = json['PlayerImage'];
    runs = json['Runs'];
    teamSide = json['TeamSide'];
    balls = json['Balls'];
    four = json['four'];
    six = json['six'];
    seqno = json['seqno'];
    outby = json['outby'];
    inning = json['inning'];
    isnotout = json['isnotout'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['TeamName'] = teamName;
    data['PlayerName'] = playerName;
    data['MatchId'] = matchId;
    data['TeamRuns'] = teamRuns;
    data['PlayerImage'] = playerImage;
    data['Runs'] = runs;
    data['TeamSide'] = teamSide;
    data['Balls'] = balls;
    data['four'] = four;
    data['six'] = six;
    data['seqno'] = seqno;
    data['outby'] = outby;
    data['inning'] = inning;
    data['isnotout'] = isnotout;
    return data;
  }
}

StreamController<AllPlayerRunModel> allPlayerController = StreamController();
late Stream<AllPlayerRunModel> dataStream;

Future<void> getAllPlayer(Map<String, dynamic> response) async {
  print(response);
  final dataBody = json.decode(response.toString());
  AllPlayerRunModel dataModel = AllPlayerRunModel.fromJson(dataBody);
  // add API response to stream controller sink
  allPlayerController.sink.add(dataModel);
  dataStream = allPlayerController.stream.asBroadcastStream();
}
