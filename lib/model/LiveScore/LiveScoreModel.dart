class LiveScoreModel {
  List<Jsonruns> jsonruns = [];
  List<Jsondata> jsondata = [];
  String title = "";
  String matchtime = "";
  String venue = "";
  String result = "";
  int isfinished = 0;
  int ispriority = 0;
  String teamA = "";
  String teamAImage = "";
  String teamB = "";
  int seriesid = 0;
  String teamBImage = "";
  String imgeURL = "";
  String matchType = "";
  String matchDate = "";
  int matchId = 0;
  dynamic appversion;
  String adphone = "";
  String adimage = "";
  String admsg = "";

  LiveScoreModel(
      {required this.jsonruns,
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
        required this.imgeURL,
        required this.matchType,
        required this.matchDate,
        required this.matchId,
        this.appversion,
        required this.adphone,
        required this.adimage,
        required this.admsg});

  LiveScoreModel.fromJson(Map<String, dynamic> json) {
    if (json['jsonruns'] != null) {
      jsonruns = <Jsonruns>[];
      json['jsonruns'].forEach((v) {
        jsonruns.add(Jsonruns.fromJson(v));
      });
    }
    if (json['jsondata'] != null) {
      jsondata = <Jsondata>[];
      json['jsondata'].forEach((v) {
        jsondata.add(Jsondata.fromJson(v));
      });
    }
    title = json['Title'];
    matchtime = json['Matchtime'];
    venue = json['venue'];
    result = json['Result'];
    isfinished = json['isfinished'];
    ispriority = json['ispriority'];
    teamA = json['TeamA'];
    teamAImage = json['TeamAImage'];
    teamB = json['TeamB'];
    seriesid = json['seriesid'];
    teamBImage = json['TeamBImage'];
    imgeURL = json['ImgeURL'];
    matchType = json['MatchType'];
    matchDate = json['MatchDate'];
    matchId = json['MatchId'];
    appversion = json['Appversion'];
    adphone = json['adphone'];
    adimage = json['adimage'];
    admsg = json['admsg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (jsonruns != null) {
      data['jsonruns'] = jsonruns.map((v) => v.toJson()).toList();
    }
    if (jsondata != null) {
      data['jsondata'] = jsondata.map((v) => v.toJson()).toList();
    }
    data['Title'] = title;
    data['Matchtime'] = matchtime;
    data['venue'] = venue;
    data['Result'] = result;
    data['isfinished'] = isfinished;
    data['ispriority'] = ispriority;
    data['TeamA'] = teamA;
    data['TeamAImage'] = teamAImage;
    data['TeamB'] = teamB;
    data['seriesid'] = seriesid;
    data['TeamBImage'] = teamBImage;
    data['ImgeURL'] = imgeURL;
    data['MatchType'] = matchType;
    data['MatchDate'] = matchDate;
    data['MatchId'] = matchId;
    data['Appversion'] = appversion;
    data['adphone'] = adphone;
    data['adimage'] = adimage;
    data['admsg'] = admsg;
    return data;
  }
}

class Jsonruns {
  String runxa = "";
  String runxb = "";
  String fav = "";
  String rateA = "";
  String rateB = "";
  String sessionA = "";
  String sessionB = "";
  String sessionOver = "";
  String summary = "";
  String stat = "";

  Jsonruns(
      {required this.runxa,
        required this.runxb,
        required this.fav,
        required this.rateA,
        required this.rateB,
        required this.sessionA,
        required this.sessionB,
        required this.sessionOver,
        required this.summary,
        required this.stat});

  Jsonruns.fromJson(Map<String, dynamic> json) {
    runxa = json['runxa'];
    runxb = json['runxb'];
    fav = json['fav'];
    rateA = json['rateA'];
    rateB = json['rateB'];
    sessionA = json['sessionA'];
    sessionB = json['sessionB'];
    sessionOver = json['sessionOver'];
    summary = json['summary'];
    stat = json['stat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['runxa'] = runxa;
    data['runxb'] = runxb;
    data['fav'] = fav;
    data['rateA'] = rateA;
    data['rateB'] = rateB;
    data['sessionA'] = sessionA;
    data['sessionB'] = sessionB;
    data['sessionOver'] = sessionOver;
    data['summary'] = summary;
    data['stat'] = stat;
    return data;
  }
}

class Jsondata {
  String batsman = "";
  String batsmanimage = "";
  String appversion = "";
  String s4 = "";
  String s6 = "";
  String ns4 = "";
  String ns6 = "";
  String bowler = "";
  String oversA = "";
  String oversB = "";
  String rateA = "";
  String score = "";
  String sessionA = "";
  String sessionB = "";
  String sessionOver = "";
  String teamA = "";
  String teamB = "";
  String totalballs = "";
  String title = "";
  String wicketA = "";
  String wicketB = "";
  String last6Balls = "";
  String teamABanner = "";
  String teamBBanner = "";
  String imgurl = "";
  String admsg = "";
  String matchtype = "";
  String testTeamA = "";
  String testTeamARate1 = "";
  String testTeamARate2 = "";
  String testTeamB = "";
  String testTeamBRate1 = "";
  String testTeamBRate2 = "";
  String testdraw = "";
  String testdrawRate1 = "";
  String testdrawRate2 = "";
  String netfooterad2 = "";
  String netfooterurl2 = "";
  String netfooterredirect2 = "";
  String matchId = "";
  String partnership = "";
  String lastwicket = "";
  String bowler1 = "";
  String bover1 = "";
  String brun1 = "";
  String bwicket1 = "";
  String beco1= "";
  String bowler2 = "";
  String bover2 = "";
  String brun2 = "";
  String bwicket2 = "";
  String beco2 = "";
  String bowler3 = "";
  String bover3 = "";
  String brun3 = "";
  String bwicket3 = "";
  String beco3 = "";
  String bowler4 = "";
  String bover4 = "";
  String brun4 = "";
  String bwicket4 = "";
  String beco4 = "";
  String bowler5 = "";
  String bover5 = "";
  String brun5 = "";
  String bwicket5 = "";
  String beco5 = "";
  String bowler6 = "";
  String bover6 = "";
  String brun6 = "";
  String bwicket6 = "";
  String beco6 = "";
  String bowler7 = "";
  String bover7 = "";
  String brun7 = "";
  String bwicket7 = "";
  String beco7 = "";
  String bowler8 = "";
  String bover8 = "";
  String brun8 = "";
  String bwicket8 = "";
  String beco8 = "";
  String cbowler1 = "";
  String cover1 = "";
  String crun1 = "";
  String cwicket1 = "";
  String ceco1 = "";
  String lambiA = "";
  String lambiB = "";

  Jsondata(
      {required this.batsman,
        required this.batsmanimage,
        required this.appversion,
        required this.s4,
        required this.s6,
        required this.ns4,
        required this.ns6,
        required this.bowler,
        required this.oversA,
        required this.oversB,
        required this.rateA,
        required this.score,
        required this.sessionA,
        required this.sessionB,
        required this.sessionOver,
        required this.teamA,
        required this.teamB,
        required this.totalballs,
        required this.title,
        required this.wicketA,
        required this.wicketB,
        required this.last6Balls,
        required this.teamABanner,
        required this.teamBBanner,
        required this.imgurl,
        required this.admsg,
        required this.matchtype,
        required this.testTeamA,
        required this.testTeamARate1,
        required this.testTeamARate2,
        required this.testTeamB,
        required this.testTeamBRate1,
        required this.testTeamBRate2,
        required this.testdraw,
        required this.testdrawRate1,
        required this.testdrawRate2,
        required this.netfooterad2,
        required this.netfooterurl2,
        required this.netfooterredirect2,
        required this.matchId,
        required this.partnership,
        required this.lastwicket,
        required this.bowler1,
        required this.bover1,
        required this.brun1,
        required this.bwicket1,
        required this.beco1,
        required this.bowler2,
        required this.bover2,
        required this.brun2,
        required this.bwicket2,
        required this.beco2,
        required this.bowler3,
        required this.bover3,
        required this.brun3,
        required this.bwicket3,
        required this.beco3,
        required this.bowler4,
        required this.bover4,
        required this.brun4,
        required this.bwicket4,
        required this.beco4,
        required this.bowler5,
        required this.bover5,
        required this.brun5,
        required this.bwicket5,
        required this.beco5,
        required this.bowler6,
        required this.bover6,
        required this.brun6,
        required this.bwicket6,
        required this.beco6,
        required this.bowler7,
        required this.bover7,
        required this.brun7,
        required this.bwicket7,
        required this.beco7,
        required this.bowler8,
        required this.bover8,
        required this.brun8,
        required this.bwicket8,
        required this.beco8,
        required this.cbowler1,
        required this.cover1,
        required this.crun1,
        required this.cwicket1,
        required this.ceco1,
        required this.lambiA,
        required this.lambiB});

  Jsondata.fromJson(Map<String, dynamic> json) {
    batsman = json['batsman'];
    batsmanimage = json['batsmanimage'];
    appversion = json['appversion'];
    s4 = json['s4'];
    s6 = json['s6'];
    ns4 = json['ns4'];
    ns6 = json['ns6'];
    bowler = json['bowler'];
    oversA = json['oversA'];
    oversB = json['oversB'];
    rateA = json['rateA'];
    score = json['score'];
    sessionA = json['sessionA'];
    sessionB = json['sessionB'];
    sessionOver = json['sessionOver'];
    teamA = json['teamA'];
    teamB = json['teamB'];
    totalballs = json['totalballs'];
    title = json['title'];
    wicketA = json['wicketA'];
    wicketB = json['wicketB'];
    last6Balls = json['Last6Balls'];
    teamABanner = json['TeamABanner'];
    teamBBanner = json['TeamBBanner'];
    imgurl = json['imgurl'];
    admsg = json['admsg'];
    matchtype = json['matchtype'];
    testTeamA = json['TestTeamA'];
    testTeamARate1 = json['TestTeamARate1'];
    testTeamARate2 = json['TestTeamARate2'];
    testTeamB = json['TestTeamB'];
    testTeamBRate1 = json['TestTeamBRate1'];
    testTeamBRate2 = json['TestTeamBRate2'];
    testdraw = json['Testdraw'];
    testdrawRate1 = json['TestdrawRate1'];
    testdrawRate2 = json['TestdrawRate2'];
    netfooterad2 = json['netfooterad2'];
    netfooterurl2 = json['netfooterurl2'];
    netfooterredirect2 = json['netfooterredirect2'];
    matchId = json['MatchId'];
    partnership = json['partnership'];
    lastwicket = json['lastwicket'];
    bowler1 = json['bowler1'];
    bover1 = json['bover1'];
    brun1 = json['brun1'];
    bwicket1 = json['bwicket1'];
    beco1 = json['beco1'];
    bowler2 = json['bowler2'];
    bover2 = json['bover2'];
    brun2 = json['brun2'];
    bwicket2 = json['bwicket2'];
    beco2 = json['beco2'];
    bowler3 = json['bowler3'];
    bover3 = json['bover3'];
    brun3 = json['brun3'];
    bwicket3 = json['bwicket3'];
    beco3 = json['beco3'];
    bowler4 = json['bowler4'];
    bover4 = json['bover4'];
    brun4 = json['brun4'];
    bwicket4 = json['bwicket4'];
    beco4 = json['beco4'];
    bowler5 = json['bowler5'];
    bover5 = json['bover5'];
    brun5 = json['brun5'];
    bwicket5 = json['bwicket5'];
    beco5 = json['beco5'];
    bowler6 = json['bowler6'];
    bover6 = json['bover6'];
    brun6 = json['brun6'];
    bwicket6 = json['bwicket6'];
    beco6 = json['beco6'];
    bowler7 = json['bowler7'];
    bover7 = json['bover7'];
    brun7 = json['brun7'];
    bwicket7 = json['bwicket7'];
    beco7 = json['beco7'];
    bowler8 = json['bowler8'];
    bover8 = json['bover8'];
    brun8 = json['brun8'];
    bwicket8 = json['bwicket8'];
    beco8 = json['beco8'];
    cbowler1 = json['cbowler1'];
    cover1 = json['cover1'];
    crun1 = json['crun1'];
    cwicket1 = json['cwicket1'];
    ceco1 = json['ceco1'];
    lambiA = json['LambiA'];
    lambiB = json['LambiB'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['batsman'] = batsman;
    data['batsmanimage'] = batsmanimage;
    data['appversion'] = appversion;
    data['s4'] = s4;
    data['s6'] = s6;
    data['ns4'] = ns4;
    data['ns6'] = ns6;
    data['bowler'] = bowler;
    data['oversA'] = oversA;
    data['oversB'] = oversB;
    data['rateA'] = rateA;
    data['score'] = score;
    data['sessionA'] = sessionA;
    data['sessionB'] = sessionB;
    data['sessionOver'] = sessionOver;
    data['teamA'] = teamA;
    data['teamB'] = teamB;
    data['totalballs'] = totalballs;
    data['title'] = title;
    data['wicketA'] = wicketA;
    data['wicketB'] = wicketB;
    data['Last6Balls'] = last6Balls;
    data['TeamABanner'] = teamABanner;
    data['TeamBBanner'] = teamBBanner;
    data['imgurl'] = imgurl;
    data['admsg'] = admsg;
    data['matchtype'] = matchtype;
    data['TestTeamA'] = testTeamA;
    data['TestTeamARate1'] = testTeamARate1;
    data['TestTeamARate2'] = testTeamARate2;
    data['TestTeamB'] = testTeamB;
    data['TestTeamBRate1'] = testTeamBRate1;
    data['TestTeamBRate2'] = testTeamBRate2;
    data['Testdraw'] = testdraw;
    data['TestdrawRate1'] = testdrawRate1;
    data['TestdrawRate2'] = testdrawRate2;
    data['netfooterad2'] = netfooterad2;
    data['netfooterurl2'] = netfooterurl2;
    data['netfooterredirect2'] = netfooterredirect2;
    data['MatchId'] = matchId;
    data['partnership'] = partnership;
    data['lastwicket'] = lastwicket;
    data['bowler1'] = bowler1;
    data['bover1'] = bover1;
    data['brun1'] = brun1;
    data['bwicket1'] = bwicket1;
    data['beco1'] = beco1;
    data['bowler2'] = bowler2;
    data['bover2'] = bover2;
    data['brun2'] = brun2;
    data['bwicket2'] = bwicket2;
    data['beco2'] = beco2;
    data['bowler3'] = bowler3;
    data['bover3'] = bover3;
    data['brun3'] = brun3;
    data['bwicket3'] = bwicket3;
    data['beco3'] = beco3;
    data['bowler4'] = bowler4;
    data['bover4'] = bover4;
    data['brun4'] = brun4;
    data['bwicket4'] = bwicket4;
    data['beco4'] = beco4;
    data['bowler5'] = bowler5;
    data['bover5'] = bover5;
    data['brun5'] = brun5;
    data['bwicket5'] = bwicket5;
    data['beco5'] = beco5;
    data['bowler6'] = bowler6;
    data['bover6'] = bover6;
    data['brun6'] = brun6;
    data['bwicket6'] = bwicket6;
    data['beco6'] = beco6;
    data['bowler7'] = bowler7;
    data['bover7'] = bover7;
    data['brun7'] = brun7;
    data['bwicket7'] = bwicket7;
    data['beco7'] = beco7;
    data['bowler8'] = bowler8;
    data['bover8'] = bover8;
    data['brun8'] = brun8;
    data['bwicket8'] = bwicket8;
    data['beco8'] = beco8;
    data['cbowler1'] = cbowler1;
    data['cover1'] = cover1;
    data['crun1'] = crun1;
    data['cwicket1'] = cwicket1;
    data['ceco1'] = ceco1;
    data['LambiA'] = lambiA;
    data['LambiB'] = lambiB;
    return data;
  }
}
