import 'package:flutter/material.dart';

class ESGalleryCard extends StatelessWidget {
  const ESGalleryCard({
    Key? key,
    required this.child,
  }) : super(
          key: key,
        );

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        color: const Color(0xFFB4B4B4),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: child,
      ),
    );
  }
}
