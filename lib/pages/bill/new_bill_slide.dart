import 'package:flutter/material.dart';

class NewBillSlide extends StatelessWidget {
  const NewBillSlide({
    Key? key,
    required this.title,
    required this.child,
    required this.next,
    required this.buttonLabel,
  }) : super(key: key);

  final String title;
  final Widget child;
  final String buttonLabel;
  final VoidCallback next;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          Text(title),
          child,
          const Spacer(),
          ElevatedButton(
            onPressed: next,
            child: Text(buttonLabel),
          ),
        ],
      ),
    );
  }
}
