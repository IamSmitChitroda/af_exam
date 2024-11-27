import 'package:af_exam/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/theme_controller.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.put(ThemeController());
    return Obx(
      () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: themeController.isDarkMode.value
            ? ThemeData.dark()
            : ThemeData.light(),
        home: const HomeView(),
      ),
    );
  }
}
