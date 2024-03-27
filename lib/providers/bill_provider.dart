import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:piggy_flow_mobile/models/bill.dart';
import 'package:piggy_flow_mobile/providers/http_provider.dart';

final billProvider =
    StateNotifierProvider<BillNotifier, AsyncValue<List<Bill>>?>((ref) {
  return BillNotifier(ref);
});

class BillNotifier extends StateNotifier<AsyncValue<List<Bill>>?> {
  BillNotifier(
    this.ref, [
    AsyncValue<List<Bill>>? bills,
  ]) : super(bills ?? const AsyncValue.loading()) {
    getBills();
  }

  final Ref ref;

  Future<void> getBills() async {
    try {
      state = AsyncValue.data(
        await ref.read(httpProvider).getBillsByUser(),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      debugPrint('get bills $e');
    }
  }
}
