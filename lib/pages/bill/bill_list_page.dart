import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:piggy_flow_mobile/es_widgets/es_staggered_list.dart';
import 'package:piggy_flow_mobile/models/bill.dart';
import 'package:piggy_flow_mobile/pages/bill/bill_details_page.dart';
import 'package:piggy_flow_mobile/pages/bill/new_bill_page.dart';
import 'package:piggy_flow_mobile/providers/bill_provider.dart';

class BillListPage extends HookConsumerWidget {
  const BillListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive(wantKeepAlive: true);
    final dateformat = DateFormat('d. M. yyyy');

    final priceFormatter = NumberFormat.currency(
      locale: 'sl_SI',
      symbol: '€',
    );

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        title: const Text(
          'My bills',
          style: TextStyle(),
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed('settings'),
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Builder(
        builder: (context) {
          final billListState = ref.watch(billProvider);
          return billListState!.when(
            data: (List<Bill> bills) {
              return AnimationLimiter(
                child: RefreshIndicator(
                  backgroundColor: const Color(0xFFFE3F58),
                  color: const Color.fromRGBO(255, 255, 255, 1),
                  onRefresh: () async {
                    return ref.read(billProvider.notifier).getBills();
                  },
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return ESStaggeredList(
                        index: index,
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: const Color(0xFFBD8180),
                            child: Text(
                              (bills[index].category?.name.toString() ??
                                      'Unknown')
                                  .substring(0, 1),
                              style: const TextStyle(
                                color: Color(0xFFFFF3F2),
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          title: Text(
                            bills[index].shop?.name.toString() ?? 'Unknown',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            dateformat.format(bills[index].date),
                          ),
                          trailing: Text(
                            priceFormatter.format(bills[index].price),
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
