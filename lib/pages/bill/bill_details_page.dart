import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:piggy_flow_mobile/es_widgets/es_photo_listview.dart';
import 'package:piggy_flow_mobile/models/bill.dart';
import 'package:intl/intl.dart';
import 'package:piggy_flow_mobile/providers/bill_details_provider.dart';

class BillDetailsPage extends HookConsumerWidget {
  const BillDetailsPage({
    super.key,
    required this.billId,
  });

  final int billId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dateformat = DateFormat('d. M. yyyy HH:mm');

    final priceFormatter = NumberFormat.currency(
      locale: 'sl_SI',
      symbol: '€',
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Bill details',
          style: TextStyle(),
        ),
      ),
      body: SafeArea(
        child: Builder(
          builder: (context) {
            final billDetailsState = ref.watch(billDetailsProvider(billId));
            return billDetailsState!.when(
              data: (Bill bill) {
                return RefreshIndicator(
                  onRefresh: () async {
                    return ref
                        .read(billDetailsProvider(billId).notifier)
                        .getBillDetails();
                  },
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'Store: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                  bill.shop?.name.toString() ?? 'Unknown shop'),
                            ],
                          ),
                          Row(
                            children: [
                              const Text(
                                'Category: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(bill.category?.name.toString() ??
                                  'Unknown category'),
                            ],
                          ),
                          Row(
                            children: [
                              const Text(
                                'Date and time: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(dateformat.format(bill.date)),
                            ],
                          ),
                          Row(
                            children: [
                              const Text(
                                'Price: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(priceFormatter.format(bill.price)),
                            ],
                          ),
                          const Text(
                            'Comment: ',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(bill.comment ?? ''),
                          const Text(
                            'Photos: ',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          ESPhotoListview(
                            photos: bill.photos,
                          ),
                        ],
                      ),
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
      ),
    );
  }
}
