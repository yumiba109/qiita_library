import 'package:qiita_library/apis/qiita_api_client.dart';

class ArticleRepository {
  final _api = QiitaApiClient();

  dynamic fetchArticles(int page, String keyword) async {
    return await _api.fetchArticles(page, keyword);
  }
}
