import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final String? errorText;
  final Widget? prefixIcon;
  final bool obscureText;

  const AppTextField({
    Key? key,
    required this.onChanged,
    this.textInputAction = TextInputAction.next,
    this.textInputType,
    required this.errorText,
    this.prefixIcon,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      textInputAction: textInputAction,
      keyboardType: textInputType,
      obscureText: obscureText,
      decoration: InputDecoration(
        errorText: errorText,
        border: const OutlineInputBorder(),
        prefixIcon: prefixIcon,
      ),
    );
  }
}
