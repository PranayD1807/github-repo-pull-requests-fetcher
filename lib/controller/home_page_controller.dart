import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:task_github_request_viewer/api/api.dart';
import 'package:task_github_request_viewer/model/pull_request.dart';

class HomeController extends GetxController {
  int pageSize = 2;

  final PagingController<int, PullRequestModel> pagingControllerClosedPR =
      PagingController(firstPageKey: 1);
  final PagingController<int, PullRequestModel> pagingControllerOpenPR =
      PagingController(firstPageKey: 1);
  @override
  void onInit() {
    super.onInit();
    pagingControllerClosedPR.addPageRequestListener((pageKey) {
      _fetchPage(pageKey, pagingControllerClosedPR);
    });
    pagingControllerOpenPR.addPageRequestListener((pageKey) {
      _fetchPage(pageKey, pagingControllerOpenPR);
    });
  }

  List<Widget> tabs = [
    const Tab(text: "Closed"),
    const Tab(text: "Open"),
  ];

  Future<void> _fetchPage(int pageKey, PagingController controller) async {
    try {
      final newItems = await Api.getPullRequests(
        perPage: pageSize,
        pageNumber: pageKey,
        owner: "PranayD1807",
        repo: "github-repo-pull-requests-fetcher",
        state: controller == pagingControllerClosedPR ? "closed" : null,
      );
      final isLastPage = newItems.length < pageSize;
      if (isLastPage) {
        controller.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        controller.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      controller.error = error;
    }
  }
}
