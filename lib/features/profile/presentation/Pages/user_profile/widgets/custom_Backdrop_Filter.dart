import 'dart:ui';

import 'package:flutter/material.dart';

class customBackdropFilter extends StatelessWidget {
  const customBackdropFilter(
      {super.key, required this.is_visible, this.onPointerUp});
  final bool is_visible;
  final void Function(PointerUpEvent)? onPointerUp;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: is_visible,
      child: Listener(
        onPointerUp: onPointerUp,
        child: BackdropFilter(
          filter:
              ImageFilter.blur(sigmaX: 40.0, sigmaY: 40.0), // تأثير الضبابية
          child: Container(
            color: Colors.black.withOpacity(0), // الشفافية
          ),
        ),
      ),
    );
  }
}
