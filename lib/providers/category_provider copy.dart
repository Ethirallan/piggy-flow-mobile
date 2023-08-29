import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:piggy_flow_mobile/models/category.dart';
import 'package:piggy_flow_mobile/providers/http_provider.dart';

final categoryProvider =
    StateNotifierProvider<CategoryNotifier, List<Category>>((ref) {
  return CategoryNotifier(ref.read);
});

class CategoryNotifier extends StateNotifier<List<Category>> {
  CategoryNotifier(
    this.read, [
    List<Category>? categorys,
  ]) : super(categorys ?? []) {
    getCategories();
  }

  final Reader read;

  Future<void> getCategories() async {
    try {
      state = await read(httpProvider).getCategoriesByUser();
    } catch (e) {
      state = [];
      debugPrint('get categories $e');
    }
  }
}
