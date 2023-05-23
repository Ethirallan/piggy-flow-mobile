import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:piggy_flow_mobile/es_widgets/es_staggered_list.dart';
import 'package:piggy_flow_mobile/models/shop.dart';
import 'package:piggy_flow_mobile/providers/es_message_provider.dart';
import 'package:piggy_flow_mobile/providers/http_provider.dart';
import 'package:piggy_flow_mobile/providers/shop_provider.dart';

class ShopListPage extends HookConsumerWidget {
  const ShopListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive(wantKeepAlive: true);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My shops',
          style: TextStyle(),
        ),
      ),
      // body: Builder(
      //   builder: (context) {
      //     final shopListState = ref.watch(shopProvider);
      //     return shopListState!.when(
      //       data: (List<Shop> shops) {
      //         return AnimationLimiter(
      //           child: RefreshIndicator(
      //             backgroundColor: Colors.blue,
      //             color: Colors.white,
      //             onRefresh: () async {
      //               return ref.read(shopProvider.notifier).getShops();
      //             },
      //             child: ListView.separated(
      //               itemBuilder: (context, index) {
      //                 return ESStaggeredList(
      //                   index: index,
      //                   child: ListTile(
      //                     title: Text(shops[index].name),
      //                     onTap: () {},
      //                   ),
      //                 );
      //               },
      //               separatorBuilder: (_, __) => const Divider(),
      //               itemCount: shops.length,
      //             ),
      //           ),
      //         );
      //       },
      //       loading: () => const Center(child: CircularProgressIndicator()),
      //       error: (e, st) {
      //         return Center(
      //           child: Text(
      //             e.toString(),
      //           ),
      //         );
      //       },
      //     );
      //   },
      // ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () async {
          Shop shop = Shop(name: 'Shop 8');
          bool success = await ref.read(httpProvider).addShop(shop);
          if (success) {
            ref.read(esMessageProvider.state).state = const ESMessage(
              'Successfuly added new shop',
              Colors.green,
            );
            ref.read(shopProvider.notifier).getShops();
          } else {
            ref.read(esMessageProvider.state).state = const ESMessage(
              'Error creating new shop',
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
