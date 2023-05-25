import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:piggy_flow_mobile/es_widgets/es_staggered_list.dart';
import 'package:piggy_flow_mobile/models/bill.dart';
import 'package:piggy_flow_mobile/pages/bill/bill_details_page.dart';
import 'package:piggy_flow_mobile/pages/bill/new_bill_page.dart';
import 'package:piggy_flow_mobile/providers/bill_provider.dart';
import 'package:intl/intl.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive(wantKeepAlive: true);
    final dateformat = DateFormat('d. M. yyyy');

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
                          leading: CircleAvatar(
                            child: Text(
                              (bills[index].category?.name.toString() ??
                                      'Unknown')
                                  .substring(0, 1),
                            ),
                          ),
                          title: Text(
                            bills[index].shop?.name.toString() ?? 'Unknown',
                          ),
                          subtitle: Text(
                            dateformat.format(bills[index].date),
                          ),
                          trailing: Text(
                            '${bills[index].price.toStringAsFixed(2)} €',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 26,
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => BillDetailsPage(
                                  billId: bills[index].id ?? 0,
                                ),
                              ),
                            );
                          },
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
        // backgroundColor: Colors.primaries.first,
        onPressed: () async {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const NewBillPage(),
            ),
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
