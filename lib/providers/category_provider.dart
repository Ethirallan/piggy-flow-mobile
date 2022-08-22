import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:piggy_flow_mobile/models/category.dart';
import 'package:piggy_flow_mobile/providers/http_provider.dart';

final categoryProvider =
    StateNotifierProvider<CategoryNotifier, AsyncValue<List<Category>>?>((ref) {
  return CategoryNotifier(ref.read);
});

class CategoryNotifier extends StateNotifier<AsyncValue<List<Category>>?> {
  CategoryNotifier(
    this.read, [
    AsyncValue<List<Category>>? categorys,
  ]) : super(categorys ?? const AsyncValue.loading()) {
    getCategories();
  }

  final Reader read;

  Future<void> getCategories() async {
    try {
      state = AsyncValue.data(
        await read(httpProvider).getCategoriesByUser(),
      );
    } catch (e) {
      state = AsyncValue.error(e);
      debugPrint('get categories $e');
    }
  }
}
