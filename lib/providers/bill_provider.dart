import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:piggy_flow_mobile/models/bill.dart';
import 'package:piggy_flow_mobile/providers/http_provider.dart';

final billProvider =
    StateNotifierProvider<BillNotifier, AsyncValue<List<Bill>>?>((ref) {
  return BillNotifier(ref.read);
});

class BillNotifier extends StateNotifier<AsyncValue<List<Bill>>?> {
  BillNotifier(
    this.read, [
    AsyncValue<List<Bill>>? bills,
  ]) : super(bills ?? const AsyncValue.loading()) {
    getBills();
  }

  final Reader read;

  Future<void> getBills() async {
    try {
      state = AsyncValue.data(
        await read(httpProvider).getBillsByUser(),
      );
    } catch (e) {
      state = AsyncValue.error(e);
      debugPrint('get bills $e');
    }
  }
}
