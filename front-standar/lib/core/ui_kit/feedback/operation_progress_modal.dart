import 'dart:ui';
import 'package:flutter/material.dart';
import '../atoms/buttons/simple_button.dart';
import '../theme/app_colors.dart';

/// A general-purpose modal dialog used to display the progress of ongoing operations.
class OperationProgressModal extends StatelessWidget {
  const OperationProgressModal({
    super.key,
    required this.title,
    required this.description,
    this.progress = 0.0,
    this.percentageText = "0%",
    required this.statusText,
    this.progressNotifier,
    this.onCancel,
    this.cancelText = "Cancel Operation",
    this.topWidget,
  });

  final String title;
  final String description;
  final double progress;
  final String percentageText;
  final String statusText;
  final ValueNotifier<double>? progressNotifier;
  final VoidCallback? onCancel;
  final String cancelText;
  final Widget? topWidget;

  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    required String description,
    double progress = 0.0,
    String percentageText = "0%",
    required String statusText,
    ValueNotifier<double>? progressNotifier,
    VoidCallback? onCancel,
    String cancelText = "Cancel Operation",
    Widget? topWidget,
    bool barrierDismissible = false,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (dialogContext) => OperationProgressModal(
        title: title,
        description: description,
        progress: progress,
        percentageText: percentageText,
        statusText: statusText,
        progressNotifier: progressNotifier,
        onCancel: () {
          Navigator.of(dialogContext).pop();
          if (onCancel != null) onCancel();
        },
        cancelText: cancelText,
        topWidget: topWidget,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final notifier = progressNotifier ?? ValueNotifier<double>(progress);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      backgroundColor: AppColors.background,
      surfaceTintColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (topWidget != null) ...[
              topWidget!,
              const SizedBox(height: 24),
            ],
            
            // Progress Indicator Container
            Center(
              child: Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  color: AppColors.primaryLight3.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: ValueListenableBuilder<double>(
                  valueListenable: notifier,
                  builder: (context, value, child) {
                    final bool isIndeterminate = value < 0;
                    final int percentage = (value * 100).clamp(0, 100).toInt();
                    final displayPercentageText = progressNotifier != null 
                        ? (isIndeterminate ? "" : "$percentage%") 
                        : percentageText;
                    
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        // Circular Progress
                        SizedBox(
                          width: 120,
                          height: 120,
                          child: CircularProgressIndicator(
                            value: isIndeterminate ? null : value,
                            strokeWidth: 8,
                            backgroundColor: AppColors.white.withValues(alpha: 0.5),
                            color: AppColors.primary, 
                            strokeCap: StrokeCap.round,
                          ),
                        ),
                        // Inner Text
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (!isIndeterminate || (progressNotifier == null && percentageText.isNotEmpty && percentageText != "0%")) ...[
                              Text(
                                displayPercentageText,
                                style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 4),
                            ],
                            Text(
                              isIndeterminate ? statusText.toUpperCase() : "DOWNLOADING",
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.5,
                                color: Color(0xFF4DB6AC),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Title
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            
            const SizedBox(height: 12),
            
            // Description
            Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
                height: 1.5,
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Cancel Button
            SimpleButton(
              text: cancelText,
              onPressed: onCancel ?? () => Navigator.of(context).pop(),
              isFilled: false,
              textColor: AppColors.textPrimary,
              borderColor: const Color(0xFFDCDCE6), // Subtle border
            ),
          ],
        ),
      ),
    );
  }
}

/// A pre-built banner widget that matches the design of the video thumbnail
/// with a glassmorphism pill displaying the file name.
class OperationThumbnailBanner extends StatelessWidget {
  const OperationThumbnailBanner({
    super.key,
    required this.fileName,
    this.imageProvider,
  });

  final String fileName;
  final ImageProvider? imageProvider;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.primaryLight3.withValues(alpha: 0.2),
        image: imageProvider != null 
            ? DecorationImage(image: imageProvider!, fit: BoxFit.cover)
            : null,
      ),
      alignment: Alignment.bottomLeft,
      padding: const EdgeInsets.all(12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.white.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.white.withValues(alpha: 0.3)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.insert_drive_file_outlined,
                  size: 16,
                  color: Color(0xFF1F4C6B),
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    fileName,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1F4C6B),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
