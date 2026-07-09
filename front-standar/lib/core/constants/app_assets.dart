abstract class AppAssets {
  // Base path pour le package
  static const String _basePath = 'assets';

  // ===== FONTS =====
  static const String urbanist = 'Urbanist';
  static const String montserrat = 'Montserrat';
  static const String lunasima = 'Lunasima';
  static const String sansation = 'Sansation';
  static const String roboto = 'Roboto';
  // ===== ICONS =====

  // Auth Icons
  static const String _authIcons = '$_basePath/icons/auth';
  static const String appleIcon = '$_authIcons/apple.svg';
  static const String facebookIcon = '$_authIcons/facebook.svg';
  static const String gmailIcon = '$_authIcons/gmail.svg';
  static const String inscriptionIcon = '$_authIcons/inscription.svg';

  // Navigation Icons
  static const String _navigationIcons = '$_basePath/icons/navigation';
  static const String videoIcon = '$_navigationIcons/video.svg';
  static const String eventIcon = '$_navigationIcons/event.svg';
  static const String likeIcon = '$_navigationIcons/like.svg';
  static const String messageIcon = '$_navigationIcons/message.svg';
  static const String profileIcon = '$_navigationIcons/profile.svg';

  // Profile Icons
  //static const String _profileIcons = '$_basePath/icons/profile';

  // Shared Icons
  static const String _sharedIcons = '$_basePath/icons/shared';
  static const String logoIcon = '$_sharedIcons/logo.svg';
  static const String notificationsIcon = '$_sharedIcons/notifications.svg';

  // Onboarding Images
  static const String _onboardingImages = '$_basePath/images/onboarding';
  static const String introImage = '$_onboardingImages/intro.png';
  static const String authBottomImage1 =
      '$_onboardingImages/authBottomImage1.png';
  static const String authBottomImage2 =
      '$_onboardingImages/authBottomImage2.png';
  static const String logoName = '$_basePath/images/logo.png';
}
