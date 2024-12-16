import 'package:dh_flutter_v2/screens/auth%5Bv2%5D/forgot_password.dart';
import 'package:dh_flutter_v2/screens/auth%5Bv2%5D/forgot_password_phone_field.dart';
import 'package:dh_flutter_v2/screens/auth%5Bv2%5D/login.dart';
import 'package:dh_flutter_v2/screens/auth%5Bv2%5D/new_password.dart';
import 'package:dh_flutter_v2/screens/auth%5Bv2%5D/otp_screen.dart';
import 'package:dh_flutter_v2/screens/auth%5Bv2%5D/profile_picture.dart';
import 'package:dh_flutter_v2/screens/auth%5Bv2%5D/profile_setup_screen.dart';
import 'package:dh_flutter_v2/screens/auth%5Bv2%5D/signup.dart';
import 'package:dh_flutter_v2/screens/auth%5Bv2%5D/two_step_verification.dart';
import 'package:dh_flutter_v2/screens/home/dashboard_screen.dart';
import 'package:dh_flutter_v2/screens/messages/group_chat_screen.dart';
import 'package:dh_flutter_v2/screens/messages/messages_screen.dart';
import 'package:dh_flutter_v2/screens/screens.dart';
import 'package:dh_flutter_v2/screens/splash/introduction_screen.dart';
import 'package:dh_flutter_v2/screens/workspace.dart';
import 'package:go_router/go_router.dart';

class MyAppRouter {
  static final MyAppRouter instance = MyAppRouter._internal();

  factory MyAppRouter() => instance;

  MyAppRouter._internal();
  final GoRouter appRouter = GoRouter(
    initialLocation: '/workspace',
    routes: [
      GoRoute(
        path: '/workspace',
        builder: (context, state) => Workspace(),
        routes: [
          GoRoute(
              path: 'messages',
              builder: (context, state) => MessagesScreen(),
              routes: [
                GoRoute(
                  path: 'group-chat',
                  builder: (context, state) => GroupChatScreen(),
                ),
              ]),
          GoRoute(
            path: 'dashboard',
            builder: (context, state) => DashboardScreen(),
          ),
          GoRoute(
            path: 'profile',
            builder: (context, state) => ProfileScreen(),
          ),
        ],
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
          ]),
      GoRoute(
        path: 'profile-image',
        builder: (context, state) => ProfilePictureScreen(),
      ),
      GoRoute(
        path: 'setup-profile',
        builder: (context, state) => ProfileSetupScreen(),
      ),
    ],
  );
}
