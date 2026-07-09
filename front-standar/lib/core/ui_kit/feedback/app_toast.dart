import 'package:flutter/material.dart';
import '../../constants/app_assets.dart';
import '../theme/app_colors.dart';
import '../extensions/context_extensions.dart';

/// Toast type enum for different notification styles
enum ToastType { success, error, warning, info }

/// Custom Toast widget for displaying notifications
/// Supports success, error, warning, and info types
class AppToast extends StatelessWidget {
  const AppToast({
    super.key,
    required this.message,
    required this.type,
    this.title,
    this.onDismiss,
    this.duration = const Duration(seconds: 3),
  });

  /// The message to display
  final String message;

  /// Optional title for the toast
  final String? title;

  /// Type of toast (success, error, warning, info)
  final ToastType type;

  /// Callback when toast is dismissed
  final VoidCallback? onDismiss;

  /// Duration before auto-dismiss
  final Duration duration;

  /// Get colors based on toast type
  Color get _backgroundColor {
    switch (type) {
      case ToastType.success:
        return const Color(0xFFE8F5E9); // Light green
      case ToastType.error:
        return const Color(0xFFFFEBEE); // Light red
      case ToastType.warning:
        return const Color(0xFFFFF8E1); // Light orange
      case ToastType.info:
        return const Color(0xFFE3F2FD); // Light blue
    }
  }

  Color get _accentColor {
    switch (type) {
      case ToastType.success:
        return AppColors.green;
      case ToastType.error:
        return AppColors.red;
      case ToastType.warning:
        return AppColors.orange;
      case ToastType.info:
        return AppColors.primary;
    }
  }

  Color get _textColor {
    switch (type) {
      case ToastType.success:
        return AppColors.green; // Dark green
      case ToastType.error:
        return AppColors.red; // Dark red
      case ToastType.warning:
        return AppColors.orange; // Dark orange
      case ToastType.info:
        return AppColors.primary;
    }
  }

  IconData get _icon {
    switch (type) {
      case ToastType.success:
        return Icons.check_circle_rounded;
      case ToastType.error:
        return Icons.error_rounded;
      case ToastType.warning:
        return Icons.warning_rounded;
      case ToastType.info:
        return Icons.info_rounded;
    }
  }

  String get _defaultTitle {
    switch (type) {
      case ToastType.success:
        return 'Succès';
      case ToastType.error:
        return 'Erreur';
      case ToastType.warning:
        return 'Attention';
      case ToastType.info:
        return 'Information';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: context.responsiveWidth(16),
        vertical: context.responsiveHeight(8),
      ),
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _accentColor.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: IntrinsicHeight(
          child: Row(
            children: [
              // Left accent bar
              Container(
                width: 8,
                color: _accentColor,
              ),
              // Content
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(context.responsiveWidth(12)),
                  child: Row(
                    children: [
                      // Icon
                      Icon(
                        _icon,
                        color: _accentColor,
                        size: context.responsiveWidth(24),
                      ),
                      SizedBox(width: context.responsiveWidth(12)),
                      // Text content
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              title ?? _defaultTitle,
                              style: TextStyle(
                                fontSize: context.responsiveFontSize(14),
                                fontWeight: FontWeight.w600,
                                color: _textColor,
                                fontFamily: AppAssets.montserrat,
                              ),
                            ),
                            SizedBox(height: context.responsiveHeight(4)),
                            Text(
                              message,
                              style: TextStyle(
                                fontSize: context.responsiveFontSize(12),
                                fontWeight: FontWeight.w400,
                                color: _textColor.withValues(alpha: 0.8),
                                fontFamily: AppAssets.montserrat,
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      // Close button
                      if (onDismiss != null)
                        GestureDetector(
                          onTap: onDismiss,
                          child: Icon(
                            Icons.close,
                            color: _textColor.withValues(alpha: 0.5),
                            size: context.responsiveWidth(20),
                          ),
                        ),
                    ],
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

/// Helper class to show toasts using overlay
class AppToastHelper {
  static OverlayEntry? _currentToast;

  /// Show a toast message
  static void show(
    BuildContext context, {
    required String message,
    required ToastType type,
    String? title,
    Duration duration = const Duration(seconds: 5),
  }) {
    _currentToast?.remove();

    final overlay = Overlay.of(context, rootOverlay: true);

    _currentToast = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + 16,
        left: 0,
        right: 0,
        child: Material(
          color: Colors.transparent,
          child: _AnimatedToast(
            message: message,
            type: type,
            title: title,
            onDismiss: () {
              _currentToast?.remove();
              _currentToast = null;
            },
          ),
        ),
      ),
    );

    overlay.insert(_currentToast!);

    // Auto-dismiss after duration
    Future.delayed(duration, () {
      _currentToast?.remove();
      _currentToast = null;
    });
  }

  /// Show success toast
  static void success(
    BuildContext context,
    String message, {
    String? title,
    Duration duration = const Duration(seconds: 5),
  }) {
    show(
      context,
      message: message,
      type: ToastType.success,
      title: title,
      duration: duration,
    );
  }

  /// Show error toast
  static void error(
    BuildContext context,
    String message, {
    String? title,
    Duration duration = const Duration(seconds: 5),
  }) {
    print(message);
    show(
      context,
      message: message,
      type: ToastType.error,
      title: title,
      duration: duration,
    );
  }

  /// Show warning toast
  static void warning(
    BuildContext context,
    String message, {
    String? title,
    Duration duration = const Duration(seconds: 5),
  }) {
    show(
      context,
      message: message,
      type: ToastType.warning,
      title: title,
      duration: duration,
    );
  }

  /// Show info toast
  static void info(
    BuildContext context,
    String message, {
    String? title,
    Duration duration = const Duration(seconds: 5),
  }) {
    show(
      context,
      message: message,
      type: ToastType.info,
      title: title,
      duration: duration,
    );
  }
}

/// Animated toast wrapper for slide-in effect
class _AnimatedToast extends StatefulWidget {
  const _AnimatedToast({
    required this.message,
    required this.type,
    this.title,
    this.onDismiss,
  });

  final String message;
  final ToastType type;
  final String? title;
  final VoidCallback? onDismiss;

  @override
  State<_AnimatedToast> createState() => _AnimatedToastState();
}

class _AnimatedToastState extends State<_AnimatedToast>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: AppToast(
          message: widget.message,
          type: widget.type,
          title: widget.title,
          onDismiss: widget.onDismiss,
        ),
      ),
    );
  }
}
