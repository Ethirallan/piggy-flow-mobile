import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class ESStaggeredGrid extends StatelessWidget {
  final Widget child;
  final int index;

  const ESStaggeredGrid({Key? key, required this.child, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredGrid(
      columnCount: 2,
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
