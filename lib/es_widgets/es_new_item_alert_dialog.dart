import 'package:flutter/material.dart';

class ESNewItemAlertDialog extends StatelessWidget {
  const ESNewItemAlertDialog({
    super.key,
    required this.controller,
    required this.title,
    required this.label,
    required this.onSave,
  });

  final TextEditingController controller;
  final String title;
  final String label;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    controller.clear();
    return AlertDialog(
      title: Text(title),
      content: TextField(
        decoration: InputDecoration(
          labelText: label,
        ),
        controller: controller,
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
