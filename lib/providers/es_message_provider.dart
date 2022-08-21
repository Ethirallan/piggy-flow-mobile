import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final esMessageProvider = StateProvider<ESMessage?>((ref) {
  return null;
});

class ESMessage implements Exception {
  final String message;
  final Color color;
  const ESMessage(this.message, this.color);
}
