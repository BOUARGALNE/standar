import 'package:freezed_annotation/freezed_annotation.dart';

part 'verify_reset_code_response.freezed.dart';
part 'verify_reset_code_response.g.dart';


/// Data payload containing the reset token
@freezed
abstract class VerifyResetCodeResponseData with _$VerifyResetCodeResponseData {
  const factory VerifyResetCodeResponseData({
    @JsonKey(name: 'reset_token') required String resetToken,
  }) = _VerifyResetCodeResponseData;

  factory VerifyResetCodeResponseData.fromJson(Map<String, dynamic> json) =>
      _$VerifyResetCodeResponseDataFromJson(json);
}
