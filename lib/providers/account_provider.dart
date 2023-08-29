import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:piggy_flow_mobile/models/account.dart';
import 'package:piggy_flow_mobile/providers/http_provider.dart';

final accountProvider =
    StateNotifierProvider<AccountNotifier, List<Account>>((ref) {
  return AccountNotifier(ref.read);
});

class AccountNotifier extends StateNotifier<List<Account>> {
  AccountNotifier(
    this.read, [
    List<Account>? accounts,
  ]) : super(accounts ?? []) {
    getAccounts();
  }

  final Reader read;

  Future<void> getAccounts() async {
    try {
      state = await read(httpProvider).getAccountsByUser();
    } catch (e) {
      state = [];
      debugPrint('get accounts $e');
    }
  }
}
