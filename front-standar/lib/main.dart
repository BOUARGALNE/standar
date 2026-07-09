import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:siwl/core/di/service_locator.dart';
import 'package:siwl/core/networking/client/dio_client.dart';

import 'core/navigation/app_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/bloc/sign_up_bloc.dart';
import 'features/auth/presentation/bloc/forgot_password_bloc.dart';
import 'features/profile/presentation/bloc/profile_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp();

  // Initialize Google Sign-In (required for v7.x)
  await GoogleSignIn.instance.initialize();

  // Initialize DioClient before running the app
  DioClient.instance.init();
  setupServiceLocator();

  runApp(const SiwlApp());
}

class SiwlApp extends StatelessWidget {
  const SiwlApp({super.key});

  @override
  Widget build(BuildContext context) {
    final sl = ServiceLocator.instance;

    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>.value(value: sl.authBloc),
        BlocProvider<SignUpBloc>.value(value: sl.signUpBloc),
        BlocProvider<ForgotPasswordBloc>.value(value: sl.forgotPasswordBloc),
        BlocProvider<ProfileBloc>.value(value: sl.profileBloc),
      ],
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: MaterialApp.router(
        title: 'Control One',
        debugShowCheckedModeBanner: false,
        // Theme
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF01AFF6),
            brightness: Brightness.light,
          ),
          fontFamily: 'Inter',
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF01AFF6),
            brightness: Brightness.dark,
          ),
          fontFamily: 'Inter',
        ),
        themeMode: ThemeMode.system,

        // Router
        routerConfig: AppRouter.router,
        ),
      ),
    );
  }
}
