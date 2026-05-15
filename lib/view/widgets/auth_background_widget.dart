import 'package:flutter/material.dart';

class AuthBackgroundWidget extends StatelessWidget {
  final Widget child;

  final Widget overlayChild;

  const AuthBackgroundWidget({
    super.key,
    required this.child,
    required this.overlayChild,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    final screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        /// IMAGE
        Positioned.fill(
          child: IgnorePointer(
            child: OverflowBox(
              maxWidth: double.infinity,
              maxHeight: double.infinity,

              alignment: Alignment.bottomCenter,

              child: SizedBox(
                width: screenWidth,

                height: screenHeight,

                child: child,
              ),
            ),
          ),
        ),

        /// OVERLAY
        Positioned.fill(child: overlayChild),
      ],
    );
  }
}
