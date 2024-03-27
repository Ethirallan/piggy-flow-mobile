import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:piggy_flow_mobile/es_widgets/es_new_item_alert_dialog.dart';
import 'package:piggy_flow_mobile/models/shop.dart';
import 'package:piggy_flow_mobile/providers/es_message_provider.dart';
import 'package:piggy_flow_mobile/providers/http_provider.dart';
import 'package:piggy_flow_mobile/providers/shop_provider.dart';

class ShopListPage extends HookConsumerWidget {
  const ShopListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive(wantKeepAlive: true);
    final shops = ref.watch(shopProvider);
    final newShopNameController = useTextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My shops',
          style: TextStyle(),
        ),
      ),
      body: ListView.builder(
        itemCount: shops.length,
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
                    (shops[index].name.toString()).substring(0, 1),
                    style: const TextStyle(
                      color: Color(0xFFBD8180),
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                title: Text(shops[index].name),
              ),
            ),
          );
          if (index == 0) {
            return Padding(
                padding: const EdgeInsets.only(top: 12), child: card);
          }
          if (index == shops.length - 1) {
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
                controller: newShopNameController,
                title: 'Add new show',
                label: 'Shop name',
                onSave: () async {
                  Shop shop = Shop(name: newShopNameController.text);
                  bool success = await ref.read(httpProvider).addShop(shop);
                  if (success) {
                    ref.read(esMessageProvider.state).state = ESMessage(
                      'Successfuly added ${shop.name} to shops',
                      Colors.green,
                    );
                    ref.read(shopProvider.notifier).getShops();
                  } else {
                    ref.read(esMessageProvider.state).state = const ESMessage(
                      'Error creating new shop',
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
