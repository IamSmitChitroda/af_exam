import 'package:af_exam/presentation/back_up/ui/back_up_screen.dart';
import 'package:af_exam/presentation/home/ui/home_screen.dart';
import 'package:get/get.dart';

class Routes {
  static String home = "/HomeScreen";
  static String backUp = "/BackUpScreen";

  static List<GetPage> pages = <GetPage>[
    GetPage(name: home, page: () => const HomeScreen()),
    GetPage(name: backUp, page: () => const BackUpScreen()),
  ];
}
