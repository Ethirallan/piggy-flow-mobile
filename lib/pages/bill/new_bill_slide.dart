import 'package:flutter/material.dart';

class NewBillSlide extends StatelessWidget {
  const NewBillSlide({
    Key? key,
    required this.title,
    required this.child,
    required this.next,
    this.buttonEnabled = true,
    required this.buttonLabel,
  }) : super(key: key);

  final String title;
  final Widget child;
  final String buttonLabel;
  final bool buttonEnabled;
  final VoidCallback next;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
          const Spacer(),
          child,
          const Spacer(
            flex: 2,
          ),
          ElevatedButton(
            onPressed: buttonEnabled ? next : null,
            child: Text(buttonLabel),
          ),
        ],
      ),
    );
  }
}
