import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:piggy_flow_mobile/models/shop.dart';
import 'package:piggy_flow_mobile/providers/http_provider.dart';

final shopProvider =
    StateNotifierProvider<ShopNotifier, AsyncValue<List<Shop>>?>((ref) {
  return ShopNotifier(ref.read);
});

class ShopNotifier extends StateNotifier<AsyncValue<List<Shop>>?> {
  ShopNotifier(
    this.read, [
    AsyncValue<List<Shop>>? shops,
  ]) : super(shops ?? const AsyncValue.loading()) {
    getShops();
  }

  final Reader read;

  Future<void> getShops() async {
    try {
      state = AsyncValue.data(
        await read(httpProvider).getShopsByUser(),
      );
    } catch (e) {
      state = AsyncValue.error(e);
      debugPrint('get shops $e');
    }
  }
}
