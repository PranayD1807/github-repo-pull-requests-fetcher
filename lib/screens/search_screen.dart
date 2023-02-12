import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_github_request_viewer/consts/app_assets.dart';
import 'package:task_github_request_viewer/consts/app_color.dart';
import 'package:task_github_request_viewer/controller/search_page_controller.dart';
import 'package:task_github_request_viewer/widgets/postview.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key, required this.scaffoldKey});
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    SearchController searchController = Get.put(SearchController());
    return DefaultTabController(
      length: 2,
      child: CustomScrollView(slivers: [
        SliverAppBar(
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
          foregroundColor: AppColor.black,
          snap: true,
          pinned: true,
          floating: true,
          bottom: TabBar(
            physics: const BouncingScrollPhysics(),
            labelColor: AppColor.black,
            tabs: searchController.tabs,
            indicatorSize: TabBarIndicatorSize.label,
          ),
          title: const Text("Search Public Repo"),
          centerTitle: true,
        ),
        SliverFillRemaining(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: searchController.ownerName,
                          decoration: searchController.inputDecor("Owner Name"),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: searchController.repoName,
                          decoration: searchController.inputDecor("Repo Name"),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  CircleAvatar(
                    child: IconButton(
                      onPressed: () {
                        bool isValid = searchController.validate();
                        if (isValid) {
                          searchController.searchPullRequests();
                        }
                      },
                      icon: const Icon(Icons.search),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: TabBarView(
                children: [
                  PostView(
                    pagingController: searchController.pagingControllerClosedPR,
                  ),
                  PostView(
                    pagingController: searchController.pagingControllerOpenPR,
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
