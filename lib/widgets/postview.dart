import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:task_github_request_viewer/consts/app_color.dart';
import 'package:task_github_request_viewer/model/pull_request.dart';

class PostView extends StatelessWidget {
  const PostView({
    super.key,
    required this.pagingController,
  });

  final PagingController<int, PullRequestModel> pagingController;

  @override
  Widget build(BuildContext context) {
    return PagedListView<int, PullRequestModel>.separated(
      separatorBuilder: (context, index) {
        return const Divider();
      },
      pagingController: pagingController,
      builderDelegate: PagedChildBuilderDelegate<PullRequestModel>(
        itemBuilder: (context, item, index) => PostItem(
          pullRequest: item,
        ),
      ),
    );
  }
}

class PostItem extends StatelessWidget {
  const PostItem({
    Key? key,
    required this.pullRequest,
  }) : super(key: key);

  final PullRequestModel pullRequest;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage: pullRequest.userImage != null
                ? NetworkImage(
                    pullRequest.userImage!,
                  )
                : null,
            backgroundColor: AppColor.black,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  pullRequest.title ?? "Title Not Found",
                  textScaleFactor: 1.2,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "By : ${pullRequest.userName ?? "Anonymous"}",
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  "Created On : ${DateFormat.jm().addPattern(" - ").add_yMMMEd().format(pullRequest.createdDate ?? DateTime.now())}",
                  style: const TextStyle(
                    color: AppColor.grey,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                if (pullRequest.closedDate != null)
                  Text(
                    "Closed On : ${DateFormat.jm().addPattern(" - ").add_yMMMEd().format(pullRequest.closedDate!)}",
                    style: const TextStyle(
                      color: AppColor.grey,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
