import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:piggy_flow_mobile/es_widgets/es_new_item_alert_dialog.dart';
import 'package:piggy_flow_mobile/models/account.dart';
import 'package:piggy_flow_mobile/providers/es_message_provider.dart';
import 'package:piggy_flow_mobile/providers/http_provider.dart';
import 'package:piggy_flow_mobile/providers/account_provider.dart';

class AccountListPage extends HookConsumerWidget {
  const AccountListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive(wantKeepAlive: true);
    final accounts = ref.watch(accountProvider);
    final newAccountName = useTextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My accounts',
          style: TextStyle(),
        ),
      ),
      body: ListView.builder(
        itemCount: accounts.length,
        itemBuilder: (context, index) {
          Widget card = Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 2,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: const Color(0xFFFFF3F2),
                  child: Text(
                    (accounts[index].name.toString()).substring(0, 1),
                    style: const TextStyle(
                      color: Color(0xFFBD8180),
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                title: Text(accounts[index].name),
              ),
            ),
          );
          if (index == 0) {
            return Padding(
                padding: const EdgeInsets.only(top: 12), child: card);
          }
          if (index == accounts.length - 1) {
            return Padding(
                padding: const EdgeInsets.only(bottom: 12), child: card);
          }
          return card;
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return ESNewItemAlertDialog(
                controller: newAccountName,
                title: 'Add new account',
                label: 'Account name',
                onSave: () async {
                  Account account = Account(
                    name: newAccountName.text,
                  );
                  bool success =
                      await ref.read(httpProvider).addAccount(account);
                  if (success) {
                    ref.read(esMessageProvider.state).state = ESMessage(
                      'Successfuly added ${account.name} to your accounts',
                      Colors.green,
                    );
                    ref.read(accountProvider.notifier).getAccounts();
                  } else {
                    ref.read(esMessageProvider.state).state = const ESMessage(
                      'Error creating new account',
                      Colors.red,
                    );
                  }
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                },
              );
            },
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
