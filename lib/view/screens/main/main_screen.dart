import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/app_colors.dart';
import '../../../view%20model/bloc/navigation/navigation_bloc.dart';
import '../../widgets/bottom_nav/nestle_bottom_navigation_bar.dart';
import '../chat/live_chat_screen.dart';
import '../home/home_screen.dart';
import '../notifications/notifications_screen.dart';
import '../profile/profile_screen.dart';

/// Root shell screen that hosts the 4 main tab screens via [IndexedStack].
///
/// [IndexedStack] keeps all screens alive in memory, preserving their
/// scroll position and state when the user switches tabs.
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  static const List<Widget> _screens = [
    HomeScreen(),
    LiveChatScreen(),
    NotificationsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.primaryBlue,

          /// Body extends behind the floating bottom nav bar
          extendBody: true,

          body: IndexedStack(
            index: state.currentIndex,
            children: _screens,
          ),

          /// Floating glassmorphism pill navigation bar
          bottomNavigationBar: const NestleBottomNavigationBar(),
        );
      },
    );
  }
}
