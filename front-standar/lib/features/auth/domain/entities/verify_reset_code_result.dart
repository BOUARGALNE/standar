/// Entity representing the verification of reset code
class VerifyResetCodeResult {
  const VerifyResetCodeResult({
    required this.success,
    required this.message,
    this.resetToken,
  });

  final bool success;
  final String message;
  final String? resetToken;
}
