import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:siwl/core/ui_kit/extensions/context_extensions.dart';

import '../../constants/app_assets.dart';
import '../theme/app_colors.dart';

class MainBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const MainBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  static const List<_CustomNavItem> _items = [
    _CustomNavItem(iconPath: AppAssets.videoIcon, label: 'Editor'),
    _CustomNavItem(iconPath: AppAssets.profileIcon, label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: EdgeInsets.only(left: 16, right: 16, bottom: paddingBottom + 10),
      decoration: BoxDecoration(
        color: AppColors.primaryLight3,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.screenWidth*0.15, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            _items.length,
            (index) => _NavBarItemWidget(
              item: _items[index],
              isSelected: currentIndex == index,
              onTap: () => onTap(index),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavBarItemWidget extends StatelessWidget {
  final _CustomNavItem item;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavBarItemWidget({
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        width: context.screenWidth*0.22,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        padding: EdgeInsets.symmetric(vertical:8,horizontal: 8),
        decoration: isSelected
            ? BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.4),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              )
            : const BoxDecoration(color: Colors.transparent),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              item.iconPath,
              width: 30,
              fit: BoxFit.cover,
              height: 30,
              colorFilter: ColorFilter.mode(
                isSelected ? AppColors.white : AppColors.black,
                BlendMode.srcIn,
              ),
            ),
  /*          const SizedBox(height: 6),
            Text(
              item.label,
              style: TextStyle(
                color: isSelected ? AppColors.white : AppColors.black,
                fontSize: 14,
                fontFamily: AppAssets.montserrat,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}

class _CustomNavItem {
  final String iconPath;
  final String label;

  const _CustomNavItem({required this.iconPath, required this.label});
}
