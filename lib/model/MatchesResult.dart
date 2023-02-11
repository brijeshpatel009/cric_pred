// ignore_for_file: file_names, prefer_void_to_null, unnecessary_question_mark

class MatchResultModel {
  Null? playerslist;
  List<AllMatchData>? allMatch;
  bool? success;
  String? msg;

  MatchResultModel({this.playerslist, this.allMatch, this.success, this.msg});

  MatchResultModel.fromJson(Map<String, dynamic> json) {
    playerslist = json['Playerslist'];
    if (json['AllMatch'] != null) {
      allMatch = <AllMatchData>[];
      json['AllMatch'].forEach((v) {
        allMatch!.add(AllMatchData.fromJson(v));
      });
    }
    success = json['success'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Playerslist'] = playerslist;
    if (allMatch != null) {
      data['AllMatch'] = allMatch!.map((v) => v.toJson()).toList();
    }
    data['success'] = success;
    data['msg'] = msg;
    return data;
  }
}

class AllMatchData {
  String? title;
  String? matchtime;
  String? venue;
  int? matchId;
  String? teamA;
  String? teamB;
  String? teamAImage;
  String? matchtype;
  String? teamBImage;
  String? result;
  String? imageUrl;

  AllMatchData(
      {this.title,
      this.matchtime,
      this.venue,
      this.matchId,
      this.teamA,
      this.teamB,
      this.teamAImage,
      this.matchtype,
      this.teamBImage,
      this.result,
      this.imageUrl});

  AllMatchData.fromJson(Map<String, dynamic> json) {
    title = json['Title'];
    matchtime = json['Matchtime'];
    venue = json['Venue'];
    matchId = json['MatchId'];
    teamA = json['TeamA'];
    teamB = json['TeamB'];
    teamAImage = json['TeamAImage'];
    matchtype = json['Matchtype'];
    teamBImage = json['TeamBImage'];
    result = json['Result'];
    imageUrl = json['ImageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Title'] = title;
    data['Matchtime'] = matchtime;
    data['Venue'] = venue;
    data['MatchId'] = matchId;
    data['TeamA'] = teamA;
    data['TeamB'] = teamB;
    data['TeamAImage'] = teamAImage;
    data['Matchtype'] = matchtype;
    data['TeamBImage'] = teamBImage;
    data['Result'] = result;
    data['ImageUrl'] = imageUrl;
    return data;
  }
}
