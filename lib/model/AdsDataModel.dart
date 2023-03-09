import 'dart:convert';

class AdsDataModel {
  AdsDataModel({
    required this.banner,
    required this.inter,
    required this.reward,
    required this.appOpen,
    required this.counter,
    required this.isAds,
  });

  String banner;
  String inter;
  String reward;
  String appOpen;
  int counter;
  bool isAds;

  factory AdsDataModel.fromRawJson(String str) => AdsDataModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AdsDataModel.fromJson(Map<String, dynamic> json) => AdsDataModel(
        banner: json["banner"],
        inter: json["inter"],
        reward: json["reward"],
        appOpen: json["appOpen"],
        counter: json["counter"],
        isAds: json["isAds"],
      );

  Map<String, dynamic> toJson() => {
        "banner": banner,
        "inter": inter,
        "reward": reward,
        "appOpen": appOpen,
        "counter": counter,
        "isAds": isAds,
      };
}
