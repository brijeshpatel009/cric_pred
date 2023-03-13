// ignore_for_file: unused_import
import 'package:cric_pred/Pages/SignUp_Page.dart';
import 'package:cric_pred/utils/Shared_Pref.dart';
import 'package:cric_pred/utils/routes.dart';
import 'package:cric_pred/utils/utils.dart';
import 'package:cric_pred/widget/MyBehavior.dart';
import 'package:cric_pred/widget/app_binding.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'Pages/Home_Page.dart';
import 'Pages/Login_Page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await SharedPreferencesDatas.initialPreference();
  await MobileAds.instance.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: Routes.home,
      getPages: Routes.routes,
      builder: (context, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: GestureDetector(
            onTap: () {
              Utils.hideKeyboard(context);
            },
            child: ScrollConfiguration(behavior: MyBehavior(), child: child!),
          ),
        );
      },
    );
  }
}
