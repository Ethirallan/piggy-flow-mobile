import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:piggy_flow_mobile/models/account.dart';
import 'package:piggy_flow_mobile/providers/http_provider.dart';

final accountProvider =
    StateNotifierProvider<AccountNotifier, AsyncValue<List<Account>>?>((ref) {
  return AccountNotifier(ref.read);
});

class AccountNotifier extends StateNotifier<AsyncValue<List<Account>>?> {
  AccountNotifier(
    this.read, [
    AsyncValue<List<Account>>? accounts,
  ]) : super(accounts ?? const AsyncValue.loading()) {
    getAccounts();
  }

  final Reader read;

  Future<void> getAccounts() async {
    try {
      state = AsyncValue.data(
        await read(httpProvider).getAccountsByUser(),
      );
    } catch (e) {
      state = AsyncValue.error(e);
      debugPrint('get accounts $e');
    }
  }
}
