import 'package:flutter/material.dart';

enum EntranceDirection { ltr, rtl, ttb }

/// BLoC-driven list-item entrance animation — no StatefulWidget, no setState.
///
/// Uses [TweenAnimationBuilder] which plays once when the widget enters the
/// tree. Because list items only enter the tree when a BLoC/Cubit emits its
/// loaded state, the animation is implicitly BLoC-triggered.
///
/// Timing:
///   • 150 ms initial silence — lets the screen settle before motion starts.
///   • 420 ms effective animation per item (easeOutCubic fade + slide).
///   • 80 ms stagger between consecutive items, capped at index 6.
///
/// Total duration for item at index i:
///   totalMs = 150 + (min(i, 6) × 80) + 420
///   Animation begins at: 150 + min(i,6) × 80  ms
class AnimatedEntranceItem extends StatelessWidget {
  final int index;
  final EntranceDirection direction;
  final Widget child;

  const AnimatedEntranceItem({
    super.key,
    required this.index,
    required this.child,
    this.direction = EntranceDirection.rtl,
  });

  static const int _initialDelayMs = 150;
  static const int _staggerMs = 80;
  static const int _baseMs = 420;
  static const int _maxStaggerIndex = 6;

  @override
  Widget build(BuildContext context) {
    final int i = index.clamp(0, _maxStaggerIndex);
    final int delayMs = _initialDelayMs + i * _staggerMs;
    final int totalMs = delayMs + _baseMs;
    final double staggerFraction = delayMs / totalMs.toDouble();

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: totalMs),
      builder: (_, rawValue, cachedChild) {
        final double t =
            ((rawValue - staggerFraction) / (1.0 - staggerFraction))
                .clamp(0.0, 1.0);
        final double eased = Curves.easeOutCubic.transform(t);

        final Offset offset = switch (direction) {
          EntranceDirection.rtl => Offset((1 - eased) * 0.12, 0),
          EntranceDirection.ltr => Offset(-(1 - eased) * 0.12, 0),
          EntranceDirection.ttb => Offset(0, -(1 - eased) * 0.08),
        };

        return Opacity(
          opacity: eased,
          child: FractionalTranslation(
            translation: offset,
            child: cachedChild,
          ),
        );
      },
      child: child,
    );
  }
}
