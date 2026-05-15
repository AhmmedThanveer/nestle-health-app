import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Renders an SVG asset tinted to [color].
/// Shows [fallbackIcon] while the SVG is loading or if the path is invalid.
class AppSvgIcon extends StatelessWidget {
  final String assetPath;
  final IconData fallbackIcon;
  final double? size;
  final Color color;

  const AppSvgIcon({
    super.key,
    required this.assetPath,
    required this.fallbackIcon,
    this.size,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    final double iconSize = size ?? 24.r;

    return SvgPicture.asset(
      assetPath,
      width: iconSize,
      height: iconSize,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      placeholderBuilder: (_) =>
          Icon(fallbackIcon, size: iconSize, color: color),
    );
  }
}
