import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:piggy_flow_mobile/models/category.dart';
import 'package:piggy_flow_mobile/pages/category/new_category_alert_dialog.dart';
import 'package:piggy_flow_mobile/providers/es_message_provider.dart';
import 'package:piggy_flow_mobile/providers/http_provider.dart';
import 'package:piggy_flow_mobile/providers/category_provider.dart';

class CategoryListPage extends HookConsumerWidget {
  const CategoryListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive(wantKeepAlive: true);
    final categories = ref.watch(categoryProvider);
    final newCategoryNameController = TextEditingController();
    final newCategoryEmojiController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My categories',
          style: TextStyle(),
        ),
      ),
      body: ListView.builder(
        itemCount: categories.length,
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
                    categories[index].emoji,
                    style: const TextStyle(
                      color: Color(0xFFBD8180),
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                title: Text(categories[index].name),
                // trailing: IconButton(
                //   onPressed: () {
                //     // are you sure dialog
                //     showDialog(
                //       context: context,
                //       barrierDismissible: false,
                //       builder: (context) {
                //         return AlertDialog(
                //           title: const Text('Are you sure?'),
                //           content: Text(
                //             'Are you sure you want to delete ${categories[index].name}',
                //           ),
                //           actions: [
                //             TextButton(
                //               onPressed: () {
                //                 Navigator.pop(context);
                //               },
                //               child: const Text('Cancel'),
                //             ),
                //             TextButton(
                //               onPressed: () async {
                //                 bool success = await ref
                //                     .read(httpProvider)
                //                     .deleteCategory(categories[index]);
                //                 if (success) {
                //                   ref.read(esMessageProvider.state).state =
                //                       const ESMessage(
                //                     'Successfuly deleted category',
                //                     Colors.green,
                //                   );
                //                   ref
                //                       .read(categoryProvider.notifier)
                //                       .getCategories();
                //                 } else {
                //                   ref.read(esMessageProvider.state).state =
                //                       const ESMessage(
                //                     'Failed to delete category',
                //                     Colors.red,
                //                   );
                //                 }
                //                 if (context.mounted) {
                //                   Navigator.pop(context);
                //                 }
                //               },
                //               child: const Text('Delete'),
                //             ),
                //           ],
                //         );
                //       },
                //     );
                //   },
                //   icon: const Icon(Icons.delete),
                // ),
              ),
            ),
          );
          if (index == 0) {
            return Padding(
                padding: const EdgeInsets.only(top: 12), child: card);
          }
          if (index == categories.length - 1) {
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
              return NewCategoryAlertDialog(
                nameCtrl: newCategoryNameController,
                emojiCtrl: newCategoryEmojiController,
                onSave: () async {
                  Category category = Category(
                    name: newCategoryNameController.text,
                    emoji: newCategoryEmojiController.text,
                  );
                  bool success =
                      await ref.read(httpProvider).addCategory(category);
                  if (success) {
                    ref.read(esMessageProvider.state).state = ESMessage(
                      'Successfuly added ${category.name} to categories',
                      Colors.green,
                    );
                    ref.read(categoryProvider.notifier).getCategories();
                  } else {
                    ref.read(esMessageProvider.state).state = const ESMessage(
                      'Error creating new category',
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
