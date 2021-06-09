import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:qiita_library/models/qiita_user.dart';

part 'qiita_article.freezed.dart';
part 'qiita_article.g.dart';

@freezed
abstract class QiitaArticle with _$QiitaArticle {
  factory QiitaArticle({
    String? title,
    String? url,
    QiitaUser? user,
    List? tags,
    @JsonKey(name: 'created_at') String? createdAt,
  }) = _QiitaArticle;

  factory QiitaArticle.fromJson(Map<String, dynamic> json) =>
      _$QiitaArticleFromJson(json);
}
