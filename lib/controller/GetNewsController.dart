// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../model/NewsModel.dart';

class NewsController extends GetxController {
  NewsModel? getNewsData;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    newsDataFetch();
    super.onInit();
  }

  Future<void> newsDataFetch() async {
    isLoading.value = true;
    print(">>>>>>News Api Calling<<<<<<");

    final http.Response newsDataResponse = await http.post(
      Uri.parse('http://onlineid.cricnet.co.in/api/values/SportsNews'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      },
    );

    print(">>>>>>News Api Called<<<<<<");
    print(newsDataResponse.body);

    if (newsDataResponse.statusCode == 200) {
      getNewsData = NewsModel.fromJson(jsonDecode(newsDataResponse.body));
      print(getNewsData?.newsList?[0].title);
    } else {
      print(newsDataResponse.statusCode);
    }
  }
}