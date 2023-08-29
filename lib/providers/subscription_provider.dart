import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:piggy_flow_mobile/models/subscription.dart';
import 'package:piggy_flow_mobile/providers/http_provider.dart';

final subscriptionProvider =
    StateNotifierProvider<SubscriptionNotifier, AsyncValue<List<Subscription>>?>((ref) {
  return SubscriptionNotifier(ref.read);
});

class SubscriptionNotifier extends StateNotifier<AsyncValue<List<Subscription>>?> {
  SubscriptionNotifier(
    this.read, [
    AsyncValue<List<Subscription>>? subscriptions,
  ]) : super(subscriptions ?? const AsyncValue.loading()) {
    getSubscriptions();
  }

  final Reader read;

  Future<void> getSubscriptions() async {
    try {
      state = AsyncValue.data(
        await read(httpProvider).getSubscriptionsByUser(),
      );
    } catch (e) {
      state = AsyncValue.error(e);
      debugPrint('get subscriptions $e');
    }
  }
}
