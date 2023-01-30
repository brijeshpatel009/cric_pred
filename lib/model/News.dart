// To parse this JSON data, do
//
//     final news = newsFromJson(jsonString);
// ignore_for_file: file_names, avoid_print


import 'dart:async';
import 'dart:convert';

class News {
  News({
   required this.newsList,
   required this.success,
   required this.msg,
  });

  List<NewsList> newsList;
  bool success;
  String msg;

  factory News.fromRawJson(String str) => News.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory News.fromJson(Map<String, dynamic> json) => News(
    newsList: List<NewsList>.from(json["NewsList"].map((x) => NewsList.fromJson(x))),
    success: json["success"],
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "NewsList": List<dynamic>.from(newsList.map((x) => x.toJson())),
    "success": success,
    "msg": msg,
  };
}

class NewsList {
  NewsList({
   required this.author,
   required this.title,
   required this.description,
   required this.url,
   required this.urlToImage,
   required this.publishedAt,
   required this.content,
  });

  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String publishedAt;
  String content;

  factory NewsList.fromRawJson(String str) => NewsList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NewsList.fromJson(Map<String, dynamic> json) => NewsList(
    author: json["author"],
    title: json["title"],
    description: json["description"],
    url: json["URL"],
    urlToImage: json["URLToImage"],
    publishedAt: json["PublishedAT"],
    content: json["content"],
  );

  Map<String, dynamic> toJson() => {
    "author": author,
    "title": title,
    "description": description,
    "URL": url,
    "URLToImage": urlToImage,
    "PublishedAT": publishedAt,
    "content": content,
  };
}

StreamController<News> newsController = StreamController();
late Stream<News> dataStream;
Future<void> getNews(Map<String , dynamic> response) async {
  print(response);
  final dataBody = json.decode(response.toString());
  News dataModel = News.fromJson(dataBody);
  // add API response to stream controller sink
  newsController.sink.add(dataModel);
  dataStream = newsController.stream.asBroadcastStream();
}