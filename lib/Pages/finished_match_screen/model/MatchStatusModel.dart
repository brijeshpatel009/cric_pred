// ignore_for_file: file_names

class MatchStatModel {
  late List<Matchst> matchst;
  late bool success;
  late String msg;

  MatchStatModel({required this.matchst, required this.success, required this.msg});

  MatchStatModel.fromJson(Map<String, dynamic> json) {
    if (json['Matchst'] != null) {
      matchst = <Matchst>[];
      json['Matchst'].forEach((v) {
        matchst.add(Matchst.fromJson(v));
      });
    }
    success = json['success'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Matchst'] = matchst.map((v) => v.toJson()).toList();
    data['success'] = success;
    data['msg'] = msg;
    return data;
  }
}

class Matchst {
  late String matchname;
  late String stat1name;
  late String stat2name;
  late String stat3name;
  late String stat1descr;
  late String stat2descr;
  late String stat3descr;
  late int matchId;

  Matchst(
      {required this.matchname,
      required this.stat1name,
      required this.stat2name,
      required this.stat3name,
      required this.stat1descr,
      required this.stat2descr,
      required this.stat3descr,
      required this.matchId});

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
