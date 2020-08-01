import 'package:newsaty/Config/APIsKeys.dart';
import 'package:newsaty/Model/DataModels/NewsByCategory.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewsService {
  Future<NewsByCategory> getHeadlinesByCategory(String category) async {
    final queryParams = {
      "apiKey": APIsKeys.newsApi,
      "country": "us",
      "category": category
    };
    final uri =
        Uri.https('newsapi.org', '/v2/top-headlines', queryParams);
    final res = await http.get(uri);
    print(res.statusCode);
    if (res.statusCode == 200) {
      return NewsByCategory.fromJson(json.decode(res.body));
    } else {
      return null;
    }
  }
}
