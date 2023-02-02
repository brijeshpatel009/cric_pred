class livescoremodel {
  String jsonruns = "";
  String jsondata = "";
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
  Null? appversion;
  String adphone = "";
  String adimage = "";
  String admsg = "";

  livescoremodel(
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
        required  this.teamB,
        required this.seriesid,
        required  this.teamBImage,
        required  this.imgeURL,
        required  this.matchType,
        required  this.matchDate,
        required  this.matchId,
        this.appversion,
        required  this.adphone,
        required  this.adimage,
        required  this.admsg});

  livescoremodel.fromJson(Map<String, dynamic> json) {
    jsonruns = json['jsonruns'];
    jsondata = json['jsondata'];
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
    data['jsonruns'] = jsonruns;
    data['jsondata'] = jsondata;
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