import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../constants/app_assets.dart';
import '../extensions/context_extensions.dart';
import '../theme/app_colors.dart';


class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onNotificationTap;
  final VoidCallback? onLogoTap;
  final VoidCallback? onProfileTap;
  final String? avatarUrl;

  const CustomAppBar({
    super.key,
    this.onNotificationTap,
    this.onLogoTap,
    this.onProfileTap,
    this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrl = avatarUrl ?? '';
    return Container(
      height: context.mediaQuery.size.height * 0.13,
      color: AppColors.background, // Match lightweight transparent style
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      child: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Avatar on left
            InkWell(
              onTap: onProfileTap,
              borderRadius: BorderRadius.circular(28),
              child: ClipOval(
                child: Skeletonizer(
                  enabled: false,
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    width: 44,
                    height: 44,
                    fit: BoxFit.cover,
                    placeholder: (_, __) => Container(
                      width: 44,
                      height: 44,
                      color: Colors.grey.shade300,
                    ),
                    errorWidget: (_, __, ___) => Container(
                      width: 44,
                      height: 44,
                      color: Colors.grey.shade200,
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.person,
                        size: 26,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Match "THE PULSE" text styling or use Logo SVG if present.
            // Usually the dating app has text logo
            InkWell(
              onTap: onLogoTap,
              child: Text(
                'Siwl',
                style: TextStyle(
                  color: AppColors.primary, // Bright pinkish red
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.italic,
                  letterSpacing: -0.5,
                  fontFamily: AppAssets.montserrat,
                ),
              ),
            ),
            SizedBox(),
/*            // Notification bell on right
            InkWell(
              onTap: onNotificationTap,
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Stack(
                  children: [
                    const Icon(
                      Icons.notifications_rounded,
                      color: AppColors.textHint, // Red bell
                      size: 28,
                    ),
                    Positioned(
                      right: 2,
                      top: 2,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: AppColors.secondary,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),*/
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
