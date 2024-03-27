import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:piggy_flow_mobile/models/account.dart';
import 'package:piggy_flow_mobile/providers/http_provider.dart';

final accountProvider =
    StateNotifierProvider<AccountNotifier, List<Account>>((ref) {
  return AccountNotifier(ref);
});

class AccountNotifier extends StateNotifier<List<Account>> {
  AccountNotifier(
    this.ref, [
    List<Account>? accounts,
  ]) : super(accounts ?? []) {
    getAccounts();
  }

  final Ref ref;

  Future<void> getAccounts() async {
    try {
      state = await ref.read(httpProvider).getAccountsByUser();
    } catch (e) {
      state = [];
      debugPrint('get accounts $e');
    }
  }
}
