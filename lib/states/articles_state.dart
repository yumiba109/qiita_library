import 'package:freezed_annotation/freezed_annotation.dart';

part 'articles_state.freezed.dart';
part 'articles_state.g.dart';

@freezed
abstract class ArticlesState with _$ArticlesState {
  const factory ArticlesState({
    @Default([]) dynamic articles,
    @Default(true) bool hasNext,
    @Default('') String keyword,
  }) = _ArticlesState;

  factory ArticlesState.fromJson(Map<String, dynamic> json) =>
      _$ArticlesStateFromJson(json);
}
