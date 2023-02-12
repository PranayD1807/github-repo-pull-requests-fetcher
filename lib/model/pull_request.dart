import 'dart:developer';

class PullRequestModel {
  PullRequestModel({
    this.closedDate,
    this.createdDate,
    this.userName,
    this.userImage,
    this.id,
    this.title,
  });

  factory PullRequestModel.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic>? userData =
        json.containsKey("user") ? json["user"] : null;

    return PullRequestModel(
        id: json.containsKey("id") ? json["id"].toString() : null,
        title: json.containsKey("title") ? json["title"].toString() : null,
        createdDate: json.containsKey("created_at")
            ? DateTime.tryParse(json["created_at"])
            : null,
        closedDate: json.containsKey("closed_at") && json["closed_at"] != null
            ? DateTime.tryParse(json["closed_at"])
            : null,
        userImage: userData != null && userData.containsKey("avatar_url")
            ? userData["avatar_url"].toString()
            : null,
        userName: userData != null && userData.containsKey("login")
            ? userData["login"].toString()
            : null);
  }

  final String? id;
  final String? title;
  final DateTime? createdDate;
  final DateTime? closedDate;
  final String? userName;
  final String? userImage;
}
