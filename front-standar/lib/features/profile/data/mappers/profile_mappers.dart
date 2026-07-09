import '../../domain/entities/user.dart';
import '../models/user_model.dart';

/// Extension on UserModel to map to User entity
extension UserModelMapper on UserModel {
  /// Convert UserModel to User entity
  User toEntity() {
    return User(
      id: id,
      firstName: firstName,
      lastName: lastName,
      email: email,
      phone: phone,
      country: country,
      avatar: profilePhoto,
      hasPassword: hasPassword,
    );
  }
}