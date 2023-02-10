// ignore_for_file: file_names, avoid_print

import 'package:cric_pred/controller/GetNewsController.dart';
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

    NewsController newsController = Get.put(NewsController());

    Future<void> launchBrowser(String url) async {
      Uri openLink = Uri.parse(url);
      if (await canLaunchUrl(openLink)) {
        await launchUrl(openLink);
      } else {
        throw 'Could not launch $url';
      }
    }

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        title: Text(widget.title, style: const TextStyle(color: Colors.black)),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage('asset/appbar.png'), fit: BoxFit.fill),
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('asset/background.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Obx(() => newsController.isLoading.value
            ? const Center(
                child: SizedBox(height: 20, width: 20, child: CircularProgressIndicator()),
              )
            : SafeArea(
                child: ListView.builder(
                  padding: EdgeInsets.only(bottom: height * 0.13),
                  itemCount: newsController.getNewsData?.newsList?.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                        color: Colors.white.withOpacity(0.1),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                              title: ClipRRect(
                                  borderRadius: const BorderRadius.all(Radius.circular(18)),
                                  child: Image.network(newsController.getNewsData?.newsList?[index].uRLToImage ?? '')),
                              subtitle: GestureDetector(
                                onTap: () {
                                  launchBrowser(newsController.getNewsData?.newsList?[index].uRL ?? '');
                                  print(newsController.getNewsData?.newsList?[index].uRL ?? '');
                                },
                                child: Text(newsController.getNewsData?.newsList?[index].title ?? '',
                                    style: const TextStyle(color: Colors.black, fontSize: 18)),
                              )),
                        )),
                  ),
                ),
              )),
      ),
    );
  }
}
