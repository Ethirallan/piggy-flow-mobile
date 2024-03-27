import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';

class ESBlurhashGalleryCard extends StatelessWidget {
  const ESBlurhashGalleryCard({
    super.key,
    required this.blurhash,
  });

  final String blurhash;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 100,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(16),
        ),
        child: BlurHash(
          hash: blurhash,
        ),
      ),
    );
  }
}
