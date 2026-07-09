import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/navigation/app_routes.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/ui_kit/theme/app_colors.dart';
import '../../../../core/ui_kit/atoms/buttons/primary_button.dart';
import '../bloc/splash_bloc.dart';
import '../components/splash_animation.dart';

/// Page Splash pour l'initialisation de l'app
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    // Dispatch the started event
    ServiceLocator.instance.splashBloc.add(const SplashEvent.started());
  }

  void _setupAnimations() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: ServiceLocator.instance.splashBloc,
      child: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          state.whenOrNull(
            authenticated: () => context.go(AppRoutes.editor),
            unauthenticated: () => context.go(AppRoutes.login),
            firstTime: () => context.go(AppRoutes.onboarding),
          );
        },
        child: Scaffold(
          body: BlocBuilder<SplashBloc, SplashState>(
            builder: (context, state) {
              return state.maybeWhen(
                failure: (message) => _buildErrorView(message, context),
                orElse: () => _buildSplashView(),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSplashView() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(color: AppColors.background),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Center(child: Image.asset(AppAssets.logoName, width: 200)),
           Positioned(
            bottom: 50,
            child: SplashAnimation(
              width: 90,
              height: 18,
              containerColor: Colors.transparent,
              pillColor: AppColors.primary,
              borderColor: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorView(String message, BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: AppColors.background,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.erro.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.error_outline_rounded,
              size: 64,
              color: AppColors.erro,
            ),
          ),
          const SizedBox(height: 32),
          const Text(
            'Oops! Something went wrong.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
              fontFamily: AppAssets.montserrat,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 48),
          SizedBox(
            width: double.infinity,
            child: PrimaryButton(
              label: 'Try Again',
              onTap: () => ServiceLocator.instance.splashBloc.add(const SplashEvent.started()),
            ),
          ),
        ],
      ),
    );
  }
}
