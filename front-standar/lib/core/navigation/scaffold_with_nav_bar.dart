import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../ui_kit/layout/app_scaffold.dart';
import 'app_routes.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({
    required this.child,
    super.key,
    this.backgroundColor,
  });
  final Color? backgroundColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthBloc>().state;
    final String avatarUrl = authState.maybeWhen(
      success: (session) => session.profilePicture,
      orElse: () => "",
    );

    return AppScaffold(
      body: child,
      backgroundColor: backgroundColor,
      currentIndex: _calculateSelectedIndex(context),
      onNavTap: (index) => _onTap(context, index),
      onLogoTap: () => context.go(AppRoutes.editor),
      onProfileTap: () => context.go(AppRoutes.profile),
      onNotificationTap: () => context.push(AppRoutes.notifications),
      avatarUrl: avatarUrl,
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();
    if (location.startsWith(AppRoutes.editor)) return 0;
    if (location.startsWith(AppRoutes.profile)) return 1;
    if (location.startsWith(AppRoutes.notifications)) return -1;
    return 0; // Default to Swipe
  }

  void _onTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go(AppRoutes.editor);
        break;
      case 1:
        context.go(AppRoutes.profile);
        break;
    }
  }
}