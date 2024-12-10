import 'package:dh/screens/auth%5Bv2%5D/forgot_password.dart';
import 'package:dh/screens/auth%5Bv2%5D/forgot_password_phone_field.dart';
import 'package:dh/screens/auth%5Bv2%5D/login.dart';
import 'package:dh/screens/auth%5Bv2%5D/new_password.dart';
import 'package:dh/screens/auth%5Bv2%5D/otp_screen.dart';
import 'package:dh/screens/auth%5Bv2%5D/profile_picture.dart';
import 'package:dh/screens/auth%5Bv2%5D/profile_setup_screen.dart';
import 'package:dh/screens/auth%5Bv2%5D/signup.dart';
import 'package:dh/screens/auth%5Bv2%5D/two_step_verification.dart';
import 'package:dh/screens/screens.dart';
import 'package:dh/screens/splash/introduction_screen.dart';
import 'package:go_router/go_router.dart';

class MyAppRouter {
  static final MyAppRouter instance = MyAppRouter._internal();

  factory MyAppRouter() => instance;

  MyAppRouter._internal();
  final GoRouter appRouter = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => InitalScreen(),
      ),
      GoRoute(
        path: '/introduction',
        builder: (context, state) => IntroductionScreen(),
      ),
      GoRoute(
          path: '/auth',
          builder: (context, state) => LoginScreen(),
          routes: [
            GoRoute(
              path: 'sign-in',
              builder: (context, state) => LoginScreen(),
            ),
            GoRoute(
              path: '2-step-verification',
              builder: (context, state) => TwoStepVerificationScreen(),
            ),
            GoRoute(
              path: 'forgot-password',
              builder: (context, state) => ForgetPasswordScreen(),
            ),
            GoRoute(
              path: 'forgot-password-phone',
              builder: (context, state) => ForgetPasswordPhoneFieldScreen(),
            ),
            GoRoute(
              path: 'new-password',
              builder: (context, state) => NewPasswordScreen(),
            ),
            GoRoute(
              path: 'sign-up',
              builder: (context, state) => SignUpByPhoneScreen(),
            ),
            GoRoute(
              path: 'otp',
              builder: (context, state) {
                final bool isFromSignUp = state.extra as bool? ??
                    false; // Default to false if no extra provided
                return OTPVerificationScreen(isFromSignUp: isFromSignUp);
              },
            ),
            GoRoute(
              path: 'setup-profile',
              builder: (context, state) => ProfileSetupScreen(),
            ),
            GoRoute(
              path: 'profile-image',
              builder: (context, state) => ProfilePictureScreen(),
            ),
          ]),
    ],
  );
}
