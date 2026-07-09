import 'dart:io';

import '../entities/user.dart';

abstract class ProfileRepository {
  Future<User> getProfile();
  Future<void> updateProfilePhoto(File file);
  Future<User> updateProfileInfo({String? firstName, String? lastName, String? phone, String? country});
  Future<void> changePassword({String? oldPassword, required String newPassword, required String confirmPassword});
  Future<void> deleteAccount();
}
