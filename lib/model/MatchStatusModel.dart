class MatchStatModel {
  List<Matchst>? matchst;
  bool? success;
  String? msg;

  MatchStatModel({this.matchst, this.success, this.msg});

  MatchStatModel.fromJson(Map<String, dynamic> json) {
    if (json['Matchst'] != null) {
      matchst = <Matchst>[];
      json['Matchst'].forEach((v) {
        matchst!.add(Matchst.fromJson(v));
      });
    }
    success = json['success'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (matchst != null) {
      data['Matchst'] = matchst!.map((v) => v.toJson()).toList();
    }
    data['success'] = success;
    data['msg'] = msg;
    return data;
  }
}

class Matchst {
  String? matchname;
  String? stat1name;
  String? stat2name;
  String? stat3name;
  String? stat1descr;
  String? stat2descr;
  String? stat3descr;
  int? matchId;

  Matchst({this.matchname, this.stat1name, this.stat2name, this.stat3name, this.stat1descr, this.stat2descr, this.stat3descr, this.matchId});

  Matchst.fromJson(Map<String, dynamic> json) {
    matchname = json['matchname'];
    stat1name = json['stat1name'];
    stat2name = json['stat2name'];
    stat3name = json['stat3name'];
    stat1descr = json['stat1descr'];
    stat2descr = json['stat2descr'];
    stat3descr = json['stat3descr'];
    matchId = json['MatchId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['matchname'] = matchname;
    data['stat1name'] = stat1name;
    data['stat2name'] = stat2name;
    data['stat3name'] = stat3name;
    data['stat1descr'] = stat1descr;
    data['stat2descr'] = stat2descr;
    data['stat3descr'] = stat3descr;
    data['MatchId'] = matchId;
    return data;
  }
}
