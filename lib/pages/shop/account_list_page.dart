import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:piggy_flow_mobile/es_widgets/es_staggered_list.dart';
import 'package:piggy_flow_mobile/models/account.dart';
import 'package:piggy_flow_mobile/providers/es_message_provider.dart';
import 'package:piggy_flow_mobile/providers/http_provider.dart';
import 'package:piggy_flow_mobile/providers/account_provider.dart';

class AccountListPage extends HookConsumerWidget {
  const AccountListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive(wantKeepAlive: true);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My accounts',
          style: TextStyle(),
        ),
      ),
      body: Builder(
        builder: (context) {
          final accountListState = ref.watch(accountProvider);
          return accountListState!.when(
            data: (List<Account> accounts) {
              return AnimationLimiter(
                child: RefreshIndicator(
                  backgroundColor: Colors.blue,
                  color: Colors.white,
                  onRefresh: () async {
                    return ref.read(accountProvider.notifier).getAccounts();
                  },
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return ESStaggeredList(
                        index: index,
                        child: ListTile(
                          title: Text(accounts[index].name),
                          onTap: () {},
                        ),
                      );
                    },
                    separatorBuilder: (_, __) => const Divider(),
                    itemCount: accounts.length,
                  ),
                ),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, st) {
              return Center(
                child: Text(
                  e.toString(),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () async {
          Account account = Account(name: 'Account 8');
          bool success = await ref.read(httpProvider).addAccount(account);
          if (success) {
            ref.read(esMessageProvider.state).state = const ESMessage(
              'Successfuly added new account',
              Colors.green,
            );
            ref.read(accountProvider.notifier).getAccounts();
          } else {
            ref.read(esMessageProvider.state).state = const ESMessage(
              'Error creating new account',
              Colors.red,
            );
          }
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
