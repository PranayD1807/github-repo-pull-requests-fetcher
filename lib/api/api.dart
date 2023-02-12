import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:task_github_request_viewer/consts/app_strings.dart';
import 'package:task_github_request_viewer/model/pull_request.dart';

class Api {
  static const uri = AppStrings.githubURL;

  static Future<List<PullRequestModel>> getPullRequests(
      {required int perPage,
      required int pageNumber,
      String? owner = "flutter",
      String? repo = "flutter",
      String? state = "open"}) async {
    try {
      http.Response res = await http.get(
          Uri.parse(
            "$uri/$owner/$repo/pulls?state=$state&per_page=$perPage&page=$pageNumber",
          ),
          headers: {
            "Authorization": "token ${AppStrings.githubToken}",
          });
      if (res.statusCode == 403 || res.statusCode == 404) {
        return [];
      }
      List data = jsonDecode(res.body);
      return data.map((e) => PullRequestModel.fromJson(e)).toList();
    } on Exception catch (e) {
      log(e.toString());
    }
    return [];
  }
}
