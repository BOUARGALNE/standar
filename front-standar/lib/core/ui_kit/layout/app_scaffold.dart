import 'package:flutter/material.dart';

import '../organisms/main_app_bar.dart';
import '../organisms/main_bottom_nav_bar.dart';


class AppScaffold extends StatelessWidget {
  final Widget body;
  final int currentIndex;
  final ValueChanged<int> onNavTap;
  final Color? backgroundColor;
  final bool resizeToAvoidBottomInset;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onLogoTap;
  final VoidCallback? onProfileTap;
  final String? avatarUrl;

  const AppScaffold({
    super.key,
    required this.body,
    required this.currentIndex,
    required this.onNavTap,
    this.backgroundColor,
    this.resizeToAvoidBottomInset = false,
    this.onNotificationTap,
    this.onLogoTap,
    this.onProfileTap,
    this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? const Color(0xFFecf2ff),
      extendBodyBehindAppBar: true,
      extendBody: true,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      appBar: CustomAppBar(
        onNotificationTap: onNotificationTap,
        onLogoTap: onLogoTap,
        onProfileTap: onProfileTap,
        avatarUrl: avatarUrl,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: kToolbarHeight + 35),
        child: body,
      ),
      bottomNavigationBar: MainBottomNavBar(
        currentIndex: currentIndex,
        onTap: onNavTap,
      ),
    );
  }
}
