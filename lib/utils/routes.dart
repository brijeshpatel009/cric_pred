import 'package:cric_pred/Pages/Home_Page.dart';
import 'package:get/get.dart';

mixin Routes {
  static const defaultTransition = Transition.cupertinoDialog;

  // get started
  static const String home = '/home';

  static List<GetPage<dynamic>> routes = [
    GetPage<dynamic>(
      name: home,
      page: () => const HomePage(),
      transition: defaultTransition,
    ),
  ];
}
