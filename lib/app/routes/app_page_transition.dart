import 'package:flutter/material.dart';

class AppPageTransition {
  static Route fadeSlideTransition(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 550),

      reverseTransitionDuration: const Duration(milliseconds: 450),

      pageBuilder: (context, animation, secondaryAnimation) => page,

      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final slideAnimation =
            Tween<Offset>(
              begin: const Offset(0.08, 0),

              end: Offset.zero,
            ).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
            );

        final fadeAnimation = Tween<double>(
          begin: 0,
          end: 1,
        ).animate(animation);

        return FadeTransition(
          opacity: fadeAnimation,

          child: SlideTransition(position: slideAnimation, child: child),
        );
      },
    );
  }
}
