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
                  itemCount: newsController.getNewsData.newsList!.length,
                  padding: EdgeInsets.only(bottom: height * 0.11),
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        SizedBox(
                          height: height * 0.25,
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: GestureDetector(
                              onTap: () {
                                launchBrowser(newsController.getNewsData.newsList![index].uRL!);
                              },
                              child: Row(
                                children: [
                                  Card(
                                    clipBehavior: Clip.antiAlias,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                    child: AspectRatio(
                                      aspectRatio: 0.8,
                                      child: newsController.getNewsData.newsList![index].uRLToImage! == ""
                                          ? Container(
                                              color: Colors.blue.shade100,
                                              child: Image.asset(
                                                'asset/cricImg.png',
                                                fit: BoxFit.contain,
                                              ),
                                            )
                                          : Image.network(
                                              newsController.getNewsData.newsList![index].uRLToImage!.contains("http")
                                                  ? newsController.getNewsData.newsList![index].uRLToImage!
                                                  : "https:${newsController.getNewsData.newsList![index].uRLToImage!}",
                                              fit: BoxFit.fill,
                                            ),
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  Flexible(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          newsController.getNewsData.newsList![index].title!,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                          style: const TextStyle(color: Colors.black, fontFamily: 'PoppinsBold', fontSize: 18),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(newsController.getNewsData.newsList![index].description!,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 5,
                                            style: const TextStyle(color: Colors.grey, fontFamily: 'PoppinsReg', fontSize: 12)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.0),
                          child: Divider(
                            height: 10,
                            color: Colors.black,
                          ),
                        )
                      ],
                    );
                  },
                ),

                // ListView.builder(
                //   padding: EdgeInsets.only(bottom: height * 0.13),
                //   itemCount:
                //   physics: const BouncingScrollPhysics(),
                //   itemBuilder: (context, index) => Padding(
                //     padding: const EdgeInsets.all(8.0),
                //     child: Card(
                //         color: Colors.white.withOpacity(0.1),
                //         child: Padding(
                //           padding: const EdgeInsets.all(8.0),
                //           child: ListTile(
                //               title: ClipRRect(
                //                   borderRadius: const BorderRadius.all(Radius.circular(18)),
                //                   child: Image.network()),
                //               subtitle: GestureDetector(
                //                 onTap: () {
                //                   launchBrowser(newsController.getNewsData?.newsList?[index].uRL ?? '');
                //                   print(newsController.getNewsData?.newsList?[index].uRL ?? '');
                //                 },
                //                 child: Text(,
                //                     style: const TextStyle(color: Colors.black, fontSize: 18)),
                //               )),
                //         )),
                //   ),
                // ),
              )),
      ),
    );
  }
}
