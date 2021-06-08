import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qiita_library/repositories/article_repository.dart';
import 'package:qiita_library/states/articles_state.dart';

final articleViewModel = StateNotifierProvider(
  (_) => ArticleViewModel(
    ArticleRepository(),
  ),
);

class ArticleViewModel extends StateNotifier<ArticlesState> {
  ArticleViewModel(this.repository) : super(ArticlesState()) {
    getArticles();
  }

  final ArticleRepository repository;

  Future<void> getArticles() async {
    final articles = await repository.fetchArticles();

    state = state.copyWith(
      articles: articles,
    );
  }
}
