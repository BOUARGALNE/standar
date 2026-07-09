import 'package:freezed_annotation/freezed_annotation.dart';

part 'check_auth_response.freezed.dart';
part 'check_auth_response.g.dart';

@freezed
abstract class CheckAuthResponse with _$CheckAuthResponse {
  const factory CheckAuthResponse({
    required bool authenticated,
    @JsonKey(name: 'user_id') String? userId,
  }) = _CheckAuthResponse;

  factory CheckAuthResponse.fromJson(Map<String, dynamic> json) =>
      _$CheckAuthResponseFromJson(json);
}
