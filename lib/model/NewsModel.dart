import 'dart:convert';

import 'package:flutter/foundation.dart';

class NewsModel {
  List<NewsList>? newsList;
  bool? success;
  String? msg;

  NewsModel({this.newsList, this.success, this.msg});

  NewsModel.fromJson(Map<String, dynamic> json) {
    if (json['NewsList'] != null) {
      newsList = <NewsList>[];
      json['NewsList'].forEach((v) {
        newsList!.add(NewsList.fromJson(v));
      });
    }
    success = json['success'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (newsList != null) {
      data['NewsList'] = newsList!.map((v) => v.toJson()).toList();
    }
    data['success'] = success;
    data['msg'] = msg;
    return data;
  }
}

class NewsList {
  String? author;
  String? title;
  String? description;
  String? uRL;
  String? uRLToImage;
  String? publishedAT;
  String? content;

  NewsList(
      {this.author,
        this.title,
        this.description,
        this.uRL,
        this.uRLToImage,
        this.publishedAT,
        this.content});

  NewsList.fromJson(Map<String, dynamic> json) {
    author = json['author'];
    title = json['title'];
    description = json['description'];
    uRL = json['URL'];
    uRLToImage = json['URLToImage'];
    publishedAT = json['PublishedAT'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['author'] = author;
    data['title'] = title;
    data['description'] = description;
    data['URL'] = uRL;
    data['URLToImage'] = uRLToImage;
    data['PublishedAT'] = publishedAT;
    data['content'] = content;
    return data;
  }
}



Future<void> getNews(Map<String , dynamic> response) async {
  if (kDebugMode) {
    print(response);
  }
  final dataBody = json.decode(response.toString());
  NewsModel dataModel = NewsModel.fromJson(dataBody);
}