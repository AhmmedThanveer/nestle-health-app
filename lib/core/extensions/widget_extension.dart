import 'package:flutter/material.dart';

extension WidgetExtension on Widget {
  Widget copyWith({Widget? child}) {
    return Stack(children: [this, if (child != null) child]);
  }
}
