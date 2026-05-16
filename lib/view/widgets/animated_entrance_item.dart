import 'package:flutter/material.dart';

enum EntranceDirection { ltr, rtl, ttb }

/// BLoC-driven list-item entrance animation — no StatefulWidget, no setState.
///
/// Uses [TweenAnimationBuilder] which plays once when the widget enters the
/// tree. Because list items only enter the tree when a BLoC/Cubit emits its
/// loaded state, the animation is implicitly BLoC-triggered.
///
/// Stagger maths: item at [index] waits `index × 90 ms` before its 450 ms
/// animation begins. The total TweenAnimationBuilder duration is extended so
/// the same effective play-time is maintained for every card.
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

  static const int _baseMs = 450;
  static const int _staggerMs = 90;
  static const int _maxStaggerIndex = 6;

  @override
  Widget build(BuildContext context) {
    final int i = index.clamp(0, _maxStaggerIndex);
    final int totalMs = _baseMs + i * _staggerMs;
    final double staggerFraction = (i * _staggerMs) / totalMs.toDouble();

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: totalMs),
      builder: (_, rawValue, cachedChild) {
        final double denominator = 1.0 - staggerFraction;
        final double t =
            (denominator == 0 ? 1.0 : (rawValue - staggerFraction) / denominator)
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
