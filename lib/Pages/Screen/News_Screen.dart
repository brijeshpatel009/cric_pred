// ignore_for_file: file_names, avoid_print

import 'dart:math';

import 'package:cric_pred/controller/GetNewsController.dart';
import 'package:cric_pred/widget/commonWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double size = min(height, width);
    double newsCardHeight = height * 0.2;

    final NewsController newsController = Get.find();

    Future<void> launchBrowser(String url) async {
      Uri openLink = Uri.parse(url);
      if (await canLaunchUrl(openLink)) {
        await launchUrl(openLink);
      } else {
        throw 'Could not launch $url';
      }
    }

    // bool loaded = false;
    // var img = Image.network(src);
    // var placeholder = AssetImage(assetName)

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      body: Container(
        height: double.infinity,
        color: const Color(0xff2E2445),
        child: SafeArea(
          child: Column(children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: height * 0.02),
              child: Center(
                child: Text(
                  widget.title,
                  style: TextStyle(color: Colors.white, fontSize: size * 0.07, fontWeight: FontWeight.w600, letterSpacing: 1),
                ),
              ),
            ),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(height * 0.05)),
                child: Container(
                  color: Colors.white,
                  child: Obx(() => newsController.isLoading.value
                      ? Center(
                          child: SizedBox(height: height * 0.04, width: height * 0.04, child: const CircularProgressIndicator()),
                        )
                      : ListView.builder(
                          itemCount: newsController.getNewsData.newsList!.length,
                          padding: EdgeInsets.only(bottom: height * 0.11, top: height * 0.025),
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return commonContainer(
                              radius: newsCardHeight * 0.25,
                              size: newsCardHeight,
                              child: Padding(
                                padding: EdgeInsets.all(newsCardHeight * 0.1),
                                child: GestureDetector(
                                  onTap: () {
                                    launchBrowser(newsController.getNewsData.newsList?[index].uRL ?? '');
                                    print(newsController.getNewsData.newsList?[index].uRL ?? '');
                                  },
                                  child: Row(
                                    children: [
                                      Flexible(
                                        flex: 4,
                                        child: newsController.getNewsData.newsList![index].uRLToImage! == ""
                                            ? Container(
                                                height: double.maxFinite,
                                                decoration: BoxDecoration(
                                                    color: const Color(0xff2E2445),
                                                    borderRadius: BorderRadius.all(Radius.circular(newsCardHeight * 0.15))),
                                                child: Image.asset(
                                                  'asset/cricImg.png',
                                                  fit: BoxFit.contain,
                                                ),
                                              )
                                            : PhysicalModel(
                                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                                color: const Color(0xff2E2445),
                                                borderRadius: BorderRadius.all(Radius.circular(newsCardHeight * 0.15)),
                                                child: FadeInImage.assetNetwork(
                                                  placeholder: 'asset/cricImg.png',
                                                  image: newsController.getNewsData.newsList![index].uRLToImage!.contains("http")
                                                      ? newsController.getNewsData.newsList![index].uRLToImage!
                                                      : "https:${newsController.getNewsData.newsList![index].uRLToImage!}",
                                                  fit: BoxFit.cover,
                                                  height: double.maxFinite,
                                                ),
                                              ),
                                      ),
                                      SizedBox(width: width * 0.02),
                                      Flexible(
                                        flex: 6,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              newsController.getNewsData.newsList![index].title!,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: newsCardHeight * 0.1,
                                                  fontFamily: 'PoppinsBold',
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Text(newsController.getNewsData.newsList![index].description!,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 3,
                                                style: TextStyle(color: Colors.grey, fontSize: newsCardHeight * 0.1, fontFamily: 'PoppinsReg')),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        )),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
