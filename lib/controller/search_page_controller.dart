import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:task_github_request_viewer/api/api.dart';
import 'package:task_github_request_viewer/model/pull_request.dart';

class SearchController extends GetxController {
  int pageSize = 2;
  // Text Controllers
  TextEditingController ownerName = TextEditingController();
  TextEditingController repoName = TextEditingController();

  bool validate() {
    ownerName.text.trim();
    if (ownerName.text == "") return false;
    repoName.text.trim();
    if (repoName.text == "") return false;
    return true;
  }

  InputDecoration inputDecor(String hintText) => InputDecoration(
        hintText: hintText,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        labelStyle: const TextStyle(
          // fontSize: 12,
          color: Colors.black,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Color.fromRGBO(48, 48, 48, 0.2),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.red,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.red,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.black,
          ),
        ),
      );

  /// Page Controllers
  final PagingController<int, PullRequestModel> pagingControllerClosedPR =
      PagingController(firstPageKey: 1);
  final PagingController<int, PullRequestModel> pagingControllerOpenPR =
      PagingController(firstPageKey: 1);

  List<Widget> tabs = [
    const Tab(text: "Closed"),
    const Tab(text: "open"),
  ];

  /// Search For Pull Requests
  void searchPullRequests() {
    // Reset
    pagingControllerClosedPR.refresh();
    // pagingControllerClosedPR.removePageRequestListener((pageKey) {});

    // Request New Data
    pagingControllerClosedPR.addPageRequestListener((pageKey) {
      _fetchPage(
        pageKey: pageKey,
        controller: pagingControllerClosedPR,
        owner: ownerName.text.trim(),
        repo: repoName.text.trim(),
      );
    });

    // Reset
    pagingControllerOpenPR.refresh();
    // pagingControllerOpenPR.removePageRequestListener((pageKey) {});

    // Request New Data
    pagingControllerOpenPR.addPageRequestListener((pageKey) {
      _fetchPage(
        pageKey: pageKey,
        controller: pagingControllerOpenPR,
        owner: ownerName.text,
        repo: repoName.text,
      );
    });
  }

  @override
  void onInit() {
    super.onInit();
    ownerName.text = "flutter";
    repoName.text = "flutter";
    pagingControllerClosedPR.addPageRequestListener((pageKey) {
      _fetchPage(
        pageKey: pageKey,
        controller: pagingControllerClosedPR,
      );
    });
    pagingControllerOpenPR.addPageRequestListener((pageKey) {
      _fetchPage(
        pageKey: pageKey,
        controller: pagingControllerOpenPR,
      );
    });
  }

  /// Fetch Page Filled with DATA
  Future<void> _fetchPage(
      {required int pageKey,
      required PagingController controller,
      String? owner,
      String? repo}) async {
    try {
      final newItems = await Api.getPullRequests(
        perPage: pageSize,
        pageNumber: pageKey,
        owner: owner,
        repo: repo,
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
