import 'package:freezed_annotation/freezed_annotation.dart';

part 'qiita_user.freezed.dart';
part 'qiita_user.g.dart';

@freezed
abstract class QiitaUser with _$QiitaUser {
  factory QiitaUser({
    String? id,
    @JsonKey(name: 'profile_image_url') String? profileImageUrl,
  }) = _QiitaUser;

  factory QiitaUser.fromJson(Map<String, dynamic> json) =>
      _$QiitaUserFromJson(json);
}
