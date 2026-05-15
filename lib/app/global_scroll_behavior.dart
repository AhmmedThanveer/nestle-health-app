import 'package:flutter/material.dart';

class GlobalScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
    BuildContext context,
    Widget child,
    AxisDirection axisDirection,
  ) {
    return child; // Removes glow effect
  }
}
