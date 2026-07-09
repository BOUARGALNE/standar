import 'package:freezed_annotation/freezed_annotation.dart';

part 'verify_reset_code_request.freezed.dart';
part 'verify_reset_code_request.g.dart';

/// Request model for verify reset code API
@freezed
abstract class VerifyResetCodeRequest with _$VerifyResetCodeRequest {
  const factory VerifyResetCodeRequest({
    required String email,
    required String code,
  }) = _VerifyResetCodeRequest;

  factory VerifyResetCodeRequest.fromJson(Map<String, dynamic> json) =>
      _$VerifyResetCodeRequestFromJson(json);
}
