/// User entity representing authenticated user in the domain layer
/// This is a pure domain object without any serialization logic
class User {
  const User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.phone,
    this.country,
    this.avatar="",
    this.hasPassword = false,
  });

  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String? phone;
  final String? country;
  final String? avatar;
  final bool hasPassword;

  /// Get full name
  String get name => '$firstName $lastName'.trim();

  /// Check if user has a profile picture
  bool get hasAvatar => avatar != null && avatar!.isNotEmpty;
}
