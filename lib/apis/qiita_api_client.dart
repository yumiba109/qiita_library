import 'package:dio/dio.dart';
import 'package:qiita_library/models/qiita_article.dart';

class QiitaApiClient {
  dynamic fetchArticles(int page) async {
    final response = await Dio().get(
      'https://qiita.com/api/v2/items?per_page=20',
      queryParameters: {
        'page': page,
        'per_page': 20,
      },
    );

    var articles = response.data
        .map((dynamic i) => QiitaArticle.fromJson(i as Map<String, dynamic>))
        .toList();

    return articles;
  }
}
