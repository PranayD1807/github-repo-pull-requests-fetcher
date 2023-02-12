import 'package:flutter/material.dart';
import 'package:task_github_request_viewer/consts/app_color.dart';
import 'package:task_github_request_viewer/screens/tabs_screen.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Github',
      theme: ThemeData(
        fontFamily: "SofiaSans",
        scaffoldBackgroundColor: AppColor.appBarBackgroundColor,
        primarySwatch: AppColor.appPrimarySwatch,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColor.appBarBackgroundColor,
          elevation: 1,
        ),
      ),
      home: const TabsScreen(),
    );
  }
}
