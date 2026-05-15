import 'package:flutter/material.dart';
import 'package:health_congress/view/screens/forgot%20password/forgot_password_screen.dart';
import 'package:health_congress/view/screens/login/login_screen.dart';
import 'package:health_congress/view/screens/register/register_screen.dart';
import 'package:health_congress/view/screens/main/main_screen.dart';
import 'package:health_congress/view/screens/profile/edit_profile_screen.dart';
import 'package:health_congress/view/screens/agenda/agenda_screen.dart';

import 'app_page_transition.dart';

class AppRoutes {
  AppRoutes._();

  // ── Shell ──────────────────────────────────────────────────────
  static const String splash = '/';
  static const String main = '/main';

  // ── Profile ────────────────────────────────────────────────────
  static const String editProfile = '/edit-profile';

  // ── Auth ───────────────────────────────────────────────────────
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';

  // ── Home modules ───────────────────────────────────────────────
  static const String agenda = '/agenda';
  static const String speakers = '/speakers';
  static const String nameTag = '/name-tag';
  static const String voting = '/voting';
  static const String venue = '/venue';
  static const String askQuestion = '/ask-question';
  static const String photosVideos = '/photos-videos';
  static const String assetsDownload = '/assets';
  static const String claimCme = '/claim-cme';
  static const String survey = '/survey';
  static const String stations = '/stations';
  static const String nsm = '/nsm';

  // ── Route generator ────────────────────────────────────────────
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
      case login:
        return AppPageTransition.fadeSlideTransition(LoginScreen());

      case register:
        return AppPageTransition.fadeSlideTransition(RegisterScreen());

      case forgotPassword:
        return AppPageTransition.fadeSlideTransition(ForgotPasswordScreen());

      case main:
        return AppPageTransition.fadeSlideTransition(const MainScreen());

      case editProfile:
        return AppPageTransition.fadeSlideTransition(const EditProfileScreen());

      case agenda:
        return AppPageTransition.fadeSlideTransition(const AgendaScreen());

      // ── Module placeholder routes (replace bodies as features ship) ──
      case speakers:
      case nameTag:
      case voting:
      case venue:
      case askQuestion:
      case photosVideos:
      case assetsDownload:
      case claimCme:
      case survey:
      case stations:
      case nsm:
        return AppPageTransition.fadeSlideTransition(
          _ModulePlaceholderScreen(routeName: settings.name ?? ''),
        );

      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('No Route Found'))),
        );
    }
  }

  // ── Navigation helpers ─────────────────────────────────────────
  static Future<dynamic> push(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) => Navigator.pushNamed(context, routeName, arguments: arguments);

  static Future<dynamic> pushReplacement(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) =>
      Navigator.pushReplacementNamed(context, routeName, arguments: arguments);

  static Future<dynamic> pushAndRemoveUntil(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) => Navigator.pushNamedAndRemoveUntil(
    context,
    routeName,
    (route) => false,
    arguments: arguments,
  );

  static void pop(BuildContext context) => Navigator.pop(context);
}

// ─── Temporary placeholder used until each module screen is built ─────────────

class _ModulePlaceholderScreen extends StatelessWidget {
  final String routeName;

  const _ModulePlaceholderScreen({required this.routeName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF005EA8),
      appBar: AppBar(
        title: Text(
          routeName.replaceAll('/', '').replaceAll('-', ' ').toUpperCase(),
          style: const TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: const Center(
        child: Text(
          'Coming soon',
          style: TextStyle(color: Colors.white70, fontSize: 16),
        ),
      ),
    );
  }
}
