import 'package:dio/dio.dart';
import 'package:qiita_library/models/qiita_article.dart';

class QiitaApiClient {
  dynamic fetchArticles(int page, String keyword) async {
    final response = await Dio().get(
      'https://qiita.com/api/v2/items?per_page=20',
      queryParameters: {
        'page': page,
        'per_page': 20,
        if (keyword != '') 'query': 'body:$keyword or tag:$keyword',
      },
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "Authorization": " Bearer 9b71d2f82f8fa8577cdb22c6f2d556b0e590168b",
        },
      ),
    );

    var articles = response.data
        .map((dynamic i) => QiitaArticle.fromJson(i as Map<String, dynamic>))
        .toList();

    return articles;
  }
}
