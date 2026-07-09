import 'package:flutter/material.dart';
import '../../../constants/app_assets.dart';
import '../../theme/app_colors.dart';
import '../../extensions/context_extensions.dart';

/// A card with a background image used for selecting interests.
///
/// Has a dark bottom gradient to make the text readable and
/// a top-right circular checkmark badge when selected.
class ImageSelectionCard extends StatelessWidget {
  const ImageSelectionCard({
    super.key,
    required this.title,
    required this.imagePath,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final String imagePath;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: context.responsiveHeight(130),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.transparent,
            width: 2, // Slight border if selected, or just rely on badge
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(22), // accounts for border
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Background Image
              // Fallback to a grey container if asset is missing, to keep UI working
              Image.asset(
                imagePath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: AppColors.inputFill,
                  child: const Center(
                    child: Icon(Icons.image_not_supported, color: AppColors.textHint),
                  ),
                ),
              ),

              // Bottom Dark Gradient
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: context.responsiveHeight(60),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        AppColors.black.withValues(alpha: 0.8),
                        AppColors.transparent,
                      ],
                    ),
                  ),
                ),
              ),

              // Title Text
              Positioned(
                bottom: context.responsiveHeight(12),
                left: context.responsiveWidth(16),
                right: context.responsiveWidth(16),
                child: Text(
                  title,
                  style: TextStyle(
                    fontFamily: AppAssets.montserrat,
                    fontSize: context.responsiveFontSize(14),
                    fontWeight: FontWeight.w700,
                    color: AppColors.surface, // white
                  ),
                ),
              ),

              // Top-Right Checkmark Badge
              if (isSelected)
                Positioned(
                  top: context.responsiveHeight(12),
                  right: context.responsiveWidth(12),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.surface, width: 1.5),
                    ),
                    child: Icon(
                      Icons.check,
                      size: context.responsiveFontSize(14),
                      color: AppColors.surface,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
