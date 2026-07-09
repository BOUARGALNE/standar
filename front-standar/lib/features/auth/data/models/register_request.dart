import 'package:json_annotation/json_annotation.dart';

part 'register_request.g.dart';

/// Request model for user registration
@JsonSerializable(fieldRename: FieldRename.snake)
class RegisterRequest {
  const RegisterRequest({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.password,
    required this.country,
  });

  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String password;
  final String country;

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);
}
