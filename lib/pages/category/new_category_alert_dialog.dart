import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewCategoryAlertDialog extends StatelessWidget {
  const NewCategoryAlertDialog({
    super.key,
    required this.nameCtrl,
    required this.emojiCtrl,
    required this.onSave,
  });

  final TextEditingController nameCtrl;
  final TextEditingController emojiCtrl;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    nameCtrl.clear();
    return AlertDialog(
      title: const Text('Add new category'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration: const InputDecoration(
              labelText: 'Category emoji',
            ),
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
            ],
            controller: emojiCtrl,
          ),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Category name',
            ),
            controller: nameCtrl,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: onSave,
          child: const Text('Save'),
        ),
      ],
    );
  }
}
