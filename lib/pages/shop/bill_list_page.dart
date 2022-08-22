import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:piggy_flow_mobile/es_widgets/es_staggered_list.dart';
import 'package:piggy_flow_mobile/models/bill.dart';
import 'package:piggy_flow_mobile/providers/es_message_provider.dart';
import 'package:piggy_flow_mobile/providers/http_provider.dart';
import 'package:piggy_flow_mobile/providers/bill_provider.dart';

class BillListPage extends HookConsumerWidget {
  const BillListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive(wantKeepAlive: true);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My bills',
          style: TextStyle(),
        ),
      ),
      body: Builder(
        builder: (context) {
          final billListState = ref.watch(billProvider);
          return billListState!.when(
            data: (List<Bill> bills) {
              return AnimationLimiter(
                child: RefreshIndicator(
                  backgroundColor: Colors.blue,
                  color: Colors.white,
                  onRefresh: () async {
                    return ref.read(billProvider.notifier).getBills();
                  },
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return ESStaggeredList(
                        index: index,
                        child: ListTile(
                          title: Text(bills[index].date.toString()),
                          onTap: () {},
                        ),
                      );
                    },
                    separatorBuilder: (_, __) => const Divider(),
                    itemCount: bills.length,
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
          Bill bill = Bill(date: DateTime.now(), price: 9.99, comment: 'Comment');
          bool success = await ref.read(httpProvider).addBill(bill);
          if (success) {
            ref.read(esMessageProvider.state).state = const ESMessage(
              'Successfuly added new bill',
              Colors.green,
            );
            ref.read(billProvider.notifier).getBills();
          } else {
            ref.read(esMessageProvider.state).state = const ESMessage(
              'Error creating new bill',
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
