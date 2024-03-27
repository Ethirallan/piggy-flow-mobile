import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:piggy_flow_mobile/models/bill.dart';
import 'package:piggy_flow_mobile/providers/http_provider.dart';

final billDetailsProvider = StateNotifierProvider.autoDispose
    .family<BillDetailsNotifier, AsyncValue<Bill>?, int>((ref, id) {
  return BillDetailsNotifier(ref, id);
});

class BillDetailsNotifier extends StateNotifier<AsyncValue<Bill>?> {
  BillDetailsNotifier(
    this.ref,
    this.id, [
    AsyncValue<Bill>? bill,
  ]) : super(bill ?? const AsyncValue.loading()) {
    getBillDetails();
  }

  final Ref ref;
  final int id;

  Future<void> getBillDetails() async {
    try {
      Bill? bill = await ref.read(httpProvider).getBillById(id);
      if (bill != null) {
        state = AsyncValue.data(bill);
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      debugPrint('get bills$e');
    }
  }
}
