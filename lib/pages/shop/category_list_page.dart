import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:piggy_flow_mobile/es_widgets/es_staggered_list.dart';
import 'package:piggy_flow_mobile/models/category.dart';
import 'package:piggy_flow_mobile/providers/es_message_provider.dart';
import 'package:piggy_flow_mobile/providers/http_provider.dart';
import 'package:piggy_flow_mobile/providers/category_provider.dart';

class CategoryListPage extends HookConsumerWidget {
  const CategoryListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive(wantKeepAlive: true);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My categories',
          style: TextStyle(),
        ),
      ),
      // body: Builder(
      //   builder: (context) {
      //     final categoryListState = ref.watch(categoryProvider);
      //     return categoryListState!.when(
      //       data: (List<Category> categories) {
      //         return AnimationLimiter(
      //           child: RefreshIndicator(
      //             backgroundColor: Colors.blue,
      //             color: Colors.white,
      //             onRefresh: () async {
      //               return ref.read(categoryProvider.notifier).getCategories();
      //             },
      //             child: ListView.separated(
      //               itemBuilder: (context, index) {
      //                 return ESStaggeredList(
      //                   index: index,
      //                   child: ListTile(
      //                     title: Text(categories[index].name),
      //                     onTap: () {},
      //                   ),
      //                 );
      //               },
      //               separatorBuilder: (_, __) => const Divider(),
      //               itemCount: categories.length,
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
          Category category = Category(name: 'Category 8');
          bool success = await ref.read(httpProvider).addCategory(category);
          if (success) {
            ref.read(esMessageProvider.state).state = const ESMessage(
              'Successfuly added new category',
              Colors.green,
            );
            ref.read(categoryProvider.notifier).getCategories();
          } else {
            ref.read(esMessageProvider.state).state = const ESMessage(
              'Error creating new category',
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
