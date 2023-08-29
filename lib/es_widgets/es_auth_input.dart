import 'package:flutter/material.dart';

class ESAuthInput extends StatelessWidget {
  final TextEditingController ctrl;
  final String label;
  final bool obscureText;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final ValueChanged<String>? onFieldSubmitted;
  final FormFieldValidator<String?> validator;
  final VoidCallback? onEditingComplete;
  final FocusNode? focusNode;

  const ESAuthInput({super.key, 
    required this.ctrl,
    required this.label,
    this.obscureText = false,
    this.textInputAction = TextInputAction.done,
    this.textInputType = TextInputType.text,
    this.onFieldSubmitted,
    required this.validator,
    this.onEditingComplete,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      controller: ctrl,
      obscureText: obscureText,
      textInputAction: textInputAction,
      keyboardType: textInputType,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFE1E1E1),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide.none,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide.none,
        ),
        hintText: label,
        hintStyle: const TextStyle(
          color: Color(0xFF585858),
          fontSize: 16,
          letterSpacing: 0.8,
          fontWeight: FontWeight.w500,
        ),
        contentPadding: const EdgeInsets.fromLTRB(32, 32, 12, 24),
      ),
      onEditingComplete: onEditingComplete,
      onFieldSubmitted: onFieldSubmitted,
      validator: validator,
    );
  }
}
