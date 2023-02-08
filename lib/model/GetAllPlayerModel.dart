import 'dart:async';
import 'dart:convert';

class AllPlayerRunModel {
  List<Playerslist>? playerslist;
  String? allMatch;
  bool? success;
  String? msg;

  AllPlayerRunModel({this.playerslist, this.allMatch, this.success, this.msg});

  AllPlayerRunModel.fromJson(Map<String, dynamic> json) {
    if (json['Playerslist'] != null) {
      playerslist = <Playerslist>[];
      json['Playerslist'].forEach((v) {
        playerslist!.add(Playerslist.fromJson(v));
      });
    }
    allMatch = json['AllMatch'];
    success = json['success'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (playerslist != null) {
      data['Playerslist'] = playerslist!.map((v) => v.toJson()).toList();
    }
    data['AllMatch'] = allMatch;
    data['success'] = success;
    data['msg'] = msg;
    return data;
  }
}

class Playerslist {
  String? teamName;
  String? playerName;
  int? matchId;
  String? teamRuns;
  String? playerImage;
  int? runs;
  String? teamSide;
  int? balls;
  int? four;
  int? six;
  int? seqno;
  String? outby;
  int? inning;
  int? isnotout;

  Playerslist(
      {this.teamName,
      this.playerName,
      this.matchId,
      this.teamRuns,
      this.playerImage,
      this.runs,
      this.teamSide,
      this.balls,
      this.four,
      this.six,
      this.seqno,
      this.outby,
      this.inning,
      this.isnotout});

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
