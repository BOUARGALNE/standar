import 'package:flutter/material.dart';

import '../atoms/buttons/primary_button.dart';
import '../theme/app_colors.dart';

class CustomRefresh extends StatelessWidget {
  final String? title;
  final String? description;
  final VoidCallback onRefresh;

  const CustomRefresh({
    super.key,
    required this.onRefresh,
    this.title,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error, size: 50, color: AppColors.primary),
            const SizedBox(height: 25),
            Text(
              title ?? "Impossible de charger les données",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),
            Text(
              description ?? "Veuillez réessayer dans un instant.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade600),
            ),
            const SizedBox(height: 50),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.45,
              child: PrimaryButton(
                onTap: onRefresh,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                label: "Réessayer",
                backgroundColor: AppColors.primary,
                icon: Icon(Icons.refresh, color: AppColors.white, size: 25),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
