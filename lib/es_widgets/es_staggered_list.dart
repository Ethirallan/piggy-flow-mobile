import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class ESStaggeredList extends StatelessWidget {
  final Widget child;
  final int index;
  ESStaggeredList({required this.child, required this.index});

  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredList(
      position: index,
      delay: const Duration(milliseconds: 100),
      duration: const Duration(milliseconds: 300),
      child: SlideAnimation(
        verticalOffset: 50,
        horizontalOffset: 300,
        child: FadeInAnimation(
          child: child,
        ),
      ),
    );
  }
}
