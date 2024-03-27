import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:piggy_flow_mobile/models/shop.dart';
import 'package:piggy_flow_mobile/providers/http_provider.dart';

final shopProvider = StateNotifierProvider<ShopNotifier, List<Shop>>((ref) {
  return ShopNotifier(ref);
});

class ShopNotifier extends StateNotifier<List<Shop>> {
  ShopNotifier(
    this.ref, [
    List<Shop>? shops,
  ]) : super(shops ?? []) {
    getShops();
  }

  final Ref ref;

  Future<void> getShops() async {
    try {
      state = await ref.read(httpProvider).getShopsByUser();
    } catch (e) {
      state = [];
      debugPrint('get shops $e');
    }
  }
}
