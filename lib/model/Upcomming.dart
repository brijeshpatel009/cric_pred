class Upcomming {
  Null? playerslist;
  List<AllMatch> allMatch = [];
  bool? success;
  String msg = "";

  Upcomming({this.playerslist, required this.allMatch, this.success, required this.msg});

  Upcomming.fromJson(Map<String, dynamic> json) {
    playerslist = json['Playerslist'];
    if (json['AllMatch'] != null) {
      allMatch = <AllMatch>[];
      json['AllMatch'].forEach((v) {
        allMatch.add(AllMatch.fromJson(v));
      });
    }
    success = json['success'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Playerslist'] = playerslist;
    if (allMatch != null) {
      data['AllMatch'] = allMatch.map((v) => v.toJson()).toList();
    }
    data['success'] = success;
    data['msg'] = msg;
    return data;
  }
}

class AllMatch {
  String? title;
  String? matchtime;
  String? venue;
  int? matchId;
  String? teamA;
  String? teamB;
  String? teamAImage;
  Null? matchtype;
  String? teamBImage;
  Null? result;
  String? imageUrl;

  AllMatch(
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

  AllMatch.fromJson(Map<String, dynamic> json) {
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