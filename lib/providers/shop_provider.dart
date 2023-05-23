import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:piggy_flow_mobile/models/shop.dart';
import 'package:piggy_flow_mobile/providers/http_provider.dart';

final shopProvider = StateNotifierProvider<ShopNotifier, List<Shop>>((ref) {
  return ShopNotifier(ref.read);
});

class ShopNotifier extends StateNotifier<List<Shop>> {
  ShopNotifier(
    this.read, [
    List<Shop>? shops,
  ]) : super(shops ?? []) {
    getShops();
  }

  final Reader read;

  Future<void> getShops() async {
    print('--------- shopping ---------');
    try {
      state = await read(httpProvider).getShopsByUser();
    } catch (e) {
      state = [];
      debugPrint('get shops $e');
    }
  }
}
