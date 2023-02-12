import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:task_github_request_viewer/consts/app_assets.dart';
import 'package:task_github_request_viewer/consts/app_color.dart';
import 'package:task_github_request_viewer/consts/app_strings.dart';
import 'package:task_github_request_viewer/controller/home_page_controller.dart';
import 'package:task_github_request_viewer/widgets/postview.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.scaffoldKey});
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController());
    return DefaultTabController(
      length: 2,
      child: CustomScrollView(slivers: [
        SliverAppBar(
          foregroundColor: AppColor.black,
          snap: true,
          pinned: true,
          floating: true,
          bottom: TabBar(
            labelColor: AppColor.black,
            tabs: homeController.tabs,
            indicatorSize: TabBarIndicatorSize.label,
          ),
          title: const Text("Github Repo Fetcher"),
          leading: const Center(
            child: SizedBox(
              height: 30,
              width: 30,
              child: Image(
                image: AssetImage(
                  AppAssets.githubLogo,
                ),
                fit: BoxFit.contain,
              ),
            ),
          ),
          centerTitle: true,
        ),
        SliverFillRemaining(
            child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 20.0, top: 20, right: 20),
              child: Text(
                AppStrings.mainPageRepo,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  PostView(
                    pagingController: homeController.pagingControllerClosedPR,
                  ),
                  PostView(
                    pagingController: homeController.pagingControllerOpenPR,
                  ),
                ],
              ),
            ),
          ],
        ))
      ]),
    );
  }
}
