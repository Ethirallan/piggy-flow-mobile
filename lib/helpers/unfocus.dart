import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class Unfocus extends HookWidget {
  const Unfocus({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: child,
    );
  }
}
