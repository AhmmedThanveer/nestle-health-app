import 'package:flutter/material.dart';

class AnimatedScreenWrapper extends StatelessWidget {
  final Widget child;

  const AnimatedScreenWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 3000),

      curve: Curves.easeOutExpo,

      tween: Tween(begin: 0, end: 1),

      builder: (context, value, childWidget) {
        return Opacity(
          opacity: value,

          child: Transform.translate(
            /// TOP -> DOWN ANIMATION
            offset: Offset(0, -45 * (1 - value)),

            child: childWidget,
          ),
        );
      },

      child: child,
    );
  }
}
