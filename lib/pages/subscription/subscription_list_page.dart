import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:piggy_flow_mobile/es_widgets/es_staggered_list.dart';
import 'package:piggy_flow_mobile/models/subscription.dart';
import 'package:piggy_flow_mobile/pages/shop/new_subscription_page.dart';
import 'package:piggy_flow_mobile/providers/subscription_provider.dart';

class SubscriptionListPage extends HookConsumerWidget {
  const SubscriptionListPage({Key? key}) : super(key: key);

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
          'My subscriptions',
          style: TextStyle(),
        ),
      ),
      body: Builder(
        builder: (context) {
          final subscriptionListState = ref.watch(subscriptionProvider);
          return subscriptionListState!.when(
            data: (List<Subscription> subscriptions) {
              return AnimationLimiter(
                child: RefreshIndicator(
                  backgroundColor: const Color(0xFFFE3F58),
                  color: const Color.fromRGBO(255, 255, 255, 1),
                  onRefresh: () async {
                    return ref
                        .read(subscriptionProvider.notifier)
                        .getSubscriptions();
                  },
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      // get date from chargeDay (day in month) for this month or the next if the date is already in the past
                      DateTime? nextCharge =
                          DateTime.now().day <= subscriptions[index].chargeDay
                              ? DateTime(
                                  DateTime.now().year,
                                  DateTime.now().month,
                                  subscriptions[index].chargeDay)
                              : DateTime(
                                  DateTime.now().year,
                                  DateTime.now().month + 1,
                                  subscriptions[index].chargeDay);
                      return ESStaggeredList(
                        index: index,
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: const Color(0xFFBD8180),
                            child: Text(
                              (subscriptions[index].category?.name.toString() ??
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
                            subscriptions[index].name.toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                              'Next charge date: ${dateformat.format(nextCharge)}'),
                          trailing: Text(
                            priceFormatter.format(subscriptions[index].price),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 26,
                            ),
                          ),
                          onTap: () {
                            // Navigator.of(context).push(
                            //   MaterialPageRoute(
                            //     builder: (context) => SubscriptionDetailsPage(
                            //       subscriptionId: subscriptions[index].id ?? 0,
                            //     ),
                            //   ),
                            // );
                          },
                        ),
                      );
                    },
                    separatorBuilder: (_, __) => const Divider(),
                    itemCount: subscriptions.length,
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
              builder: (context) => const NewSubscriptionPage(),
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
