import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:qiita_library/models/qiita_article.dart';

part 'articles_state.freezed.dart';
part 'articles_state.g.dart';

@freezed
abstract class ArticlesState with _$ArticlesState {
  const factory ArticlesState({
    @Default([]) dynamic articles,
  }) = _ArticlesState;

  factory ArticlesState.fromJson(Map<String, dynamic> json) =>
      _$ArticlesStateFromJson(json);
}
