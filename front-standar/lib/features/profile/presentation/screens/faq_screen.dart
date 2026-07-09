import 'package:flutter/material.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/ui_kit/theme/app_colors.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final faqs = [
      {
        'question': 'How to download a video?',
        'answer': 'In the video tab, you paste the URL of the video, choose the "download video" operation, select the quality, and once the video downloads, you will find it in your phone.'
      },
      {
        'question': 'Does it support any video url?',
        'answer': 'Yes, you can download juste YouTube video '
      },
      {
        'question': 'How can I change my profile picture?',
        'answer': 'Navigate to the Profile tab, tap on the camera icon next to your avatar, and choose a new picture from your gallery.'
      },
      {
        'question': 'How do I update my personal information?',
        'answer': 'In the Profile tab, tap on "Personal Information" to update your name, phone number, and other details.'
      },
      {
        'question': 'How can I change my password?',
        'answer': 'Go to the Profile tab and tap on "Change Password". Enter your current password and your new password to update it.'
      },
      {
        'question': 'Is my data secure?',
        'answer': 'Yes, we use industry-standard security protocols to ensure your videos and personal data are kept safe.'
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text(
          'FAQ',
          style: TextStyle(
            fontFamily: AppAssets.montserrat,
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(24.0),
        itemCount: faqs.length,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final faq = faqs[index];
          return Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
            ),
            child: Theme(
              data: Theme.of(context).copyWith(dividerColor: AppColors.transparent),
              child: ExpansionTile(
                title: Text(
                  faq['question']!,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                    fontSize: 16,
                  ),
                ),
                childrenPadding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                children: [
                  Text(
                    faq['answer']!,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
