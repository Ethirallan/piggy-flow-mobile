import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:piggy_flow_mobile/models/subscription.dart';
import 'package:piggy_flow_mobile/providers/http_provider.dart';

final subscriptionProvider = StateNotifierProvider<SubscriptionNotifier,
    AsyncValue<List<Subscription>>?>((ref) {
  return SubscriptionNotifier(ref);
});

class SubscriptionNotifier
    extends StateNotifier<AsyncValue<List<Subscription>>?> {
  SubscriptionNotifier(
    this.ref, [
    AsyncValue<List<Subscription>>? subscriptions,
  ]) : super(subscriptions ?? const AsyncValue.loading()) {
    getSubscriptions();
  }

  final Ref ref;

  Future<void> getSubscriptions() async {
    try {
      state = AsyncValue.data(
        await ref.read(httpProvider).getSubscriptionsByUser(),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      debugPrint('get subscriptions $e');
    }
  }
}
