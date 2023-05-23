import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:piggy_flow_mobile/models/bill.dart';
import 'package:piggy_flow_mobile/providers/http_provider.dart';

final billDetailsProvider = StateNotifierProvider.autoDispose.family<
    BillDetailsNotifier, AsyncValue<Bill>?, int>((ref, id) {
  return BillDetailsNotifier(ref.read, id);
});

class BillDetailsNotifier extends StateNotifier<AsyncValue<Bill>?> {
  BillDetailsNotifier(
    this.read,
    this.id, [
    AsyncValue<Bill>? bill,
  ]) : super(bill ?? const AsyncValue.loading()) {
    getBillDetails();
  }

  final Reader read;
  final int id;

  Future<void> getBillDetails() async {
    try {
      Bill? bill = await read(httpProvider).getBillById(id);
      if (bill != null) {
        state = AsyncValue.data(bill);
      }
    } catch (e) {
      state = AsyncValue.error(e);
      debugPrint('get bills$e');
    }
  }
}
