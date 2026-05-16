import 'package:flutter/material.dart';
import 'package:health_congress/view/screens/forgot%20password/forgot_password_screen.dart';
import 'package:health_congress/view/screens/login/login_screen.dart';
import 'package:health_congress/view/screens/cme/cme_screen.dart';
import 'package:health_congress/view/screens/splash/splash_screen.dart';
import 'package:health_congress/view/screens/register/register_screen.dart';
import 'package:health_congress/view/screens/main/main_screen.dart';
import 'package:health_congress/view/screens/profile/edit_profile_screen.dart';
import 'package:health_congress/view/screens/agenda/agenda_screen.dart';
import 'package:health_congress/view/screens/speakers/speakers_screen.dart';
import 'package:health_congress/view/screens/media/photos_videos_screen.dart';
import 'package:health_congress/view/screens/assets/assets_screen.dart';
import 'package:health_congress/view/screens/stations/stations_screen.dart';
import 'package:health_congress/view/screens/nsm/nsm_screen.dart';
import 'package:health_congress/view/screens/venue/venue_screen.dart';
import 'package:health_congress/view/screens/ask_question/ask_question_screen.dart';
import 'package:health_congress/view/screens/survey/survey_screen.dart';
import 'package:health_congress/view/screens/change_password/change_password_screen.dart';
import 'package:health_congress/view/screens/name_tag/name_tag_screen.dart';
import 'package:health_congress/view/screens/voting/voting_screen.dart';

import 'app_page_transition.dart';

class AppRoutes {
  AppRoutes._();

  // ── Shell ──────────────────────────────────────────────────────
  static const String splash = '/';
  static const String main = '/main';

  // ── Profile ────────────────────────────────────────────────────
  static const String editProfile = '/edit-profile';
  static const String changePassword = '/change-password';

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
        return AppPageTransition.fadeSlideTransition(const SplashScreen());

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

      case speakers:
        return AppPageTransition.fadeSlideTransition(const SpeakersScreen());

      case photosVideos:
        return AppPageTransition.fadeSlideTransition(
          const PhotosVideosScreen(),
        );

      case assetsDownload:
        return AppPageTransition.fadeSlideTransition(const AssetsScreen());

      case stations:
        return AppPageTransition.fadeSlideTransition(const StationsScreen());

      case nsm:
        return AppPageTransition.fadeSlideTransition(const NsmScreen());

      case venue:
        return AppPageTransition.fadeSlideTransition(const VenueScreen());

      case askQuestion:
        return AppPageTransition.fadeSlideTransition(const AskQuestionScreen());

      case claimCme:
        return AppPageTransition.fadeSlideTransition(const CmeScreen());

      case survey:
        return AppPageTransition.fadeSlideTransition(const SurveyScreen());

      case changePassword:
        return AppPageTransition.fadeSlideTransition(
          const ChangePasswordScreen(),
        );

      case nameTag:
        return AppPageTransition.fadeSlideTransition(const NameTagScreen());

      case voting:
        return AppPageTransition.fadeSlideTransition(const VotingScreen());

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

