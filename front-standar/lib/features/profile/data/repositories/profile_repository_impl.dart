import 'dart:io';

import '../../domain/entities/user.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_remote_datasource.dart';
import '../mappers/profile_mappers.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  const ProfileRepositoryImpl(this._remoteDataSource);

  final ProfileRemoteDataSource _remoteDataSource;

  @override
  Future<User> getProfile() async {
    final userModel = await _remoteDataSource.getProfile();
    return userModel.toEntity();
  }

  @override
  Future<void> updateProfilePhoto(File file) {
    return _remoteDataSource.updateProfilePhoto(file);
  }

  @override
  Future<User> updateProfileInfo({String? firstName, String? lastName, String? phone, String? country}) async {
    final userModel = await _remoteDataSource.updateProfileInfo(
      firstName: firstName,
      lastName: lastName,
      phone: phone,
      country: country,
    );
    return userModel.toEntity();
  }

  @override
  Future<void> changePassword({
    String? oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) {
    return _remoteDataSource.changePassword(
      oldPassword: oldPassword,
      newPassword: newPassword,
      confirmPassword: confirmPassword,
    );
  }

  @override
  Future<void> deleteAccount() {
    return _remoteDataSource.deleteAccount();
  }
}
