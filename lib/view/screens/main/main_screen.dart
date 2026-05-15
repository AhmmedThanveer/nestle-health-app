import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/routes/app_routes.dart';
import '../../../core/constants/app_colors.dart';
import '../../../view%20model/bloc/auth/auth_bloc.dart';
import '../../../view%20model/bloc/auth/auth_state.dart';
import '../../../view%20model/bloc/navigation/navigation_bloc.dart';
import '../../widgets/bottom_nav/nestle_bottom_navigation_bar.dart';
import '../../widgets/exit_confirmation_dialog.dart';
import '../chat/live_chat_screen.dart';
import '../home/home_screen.dart';
import '../notifications/notifications_screen.dart';
import '../profile/profile_screen.dart';

/// Root shell that hosts the 4 main tab screens via [IndexedStack].
/// Double back-press on Android shows an exit confirmation dialog.
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  static const List<Widget> _screens = [
    HomeScreen(),
    LiveChatScreen(),
    NotificationsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) return;
        final shouldExit = await ExitConfirmationDialog.show(context);
        if (shouldExit) SystemNavigator.pop();
      },
      child: BlocListener<AuthBloc, AuthState>(
        listenWhen: (_, cur) => cur is AuthUnauthenticatedState,
        listener: (context, _) =>
            AppRoutes.pushAndRemoveUntil(context, AppRoutes.login),
        child: BlocBuilder<NavigationBloc, NavigationState>(
          builder: (context, state) => Scaffold(
            backgroundColor: AppColors.primaryBlue,
            extendBody: true,
            body: IndexedStack(
              index: state.currentIndex,
              children: _screens,
            ),
            bottomNavigationBar: const NestleBottomNavigationBar(),
          ),
        ),
      ),
    );
  }
}
