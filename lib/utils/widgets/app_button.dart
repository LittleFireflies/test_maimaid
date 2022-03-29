import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool enabled;
  final bool inProgress;
  final Widget child;

  const AppButton({
    Key? key,
    required this.onPressed,
    this.enabled = true,
    this.inProgress = true,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: OutlinedButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
        ),
        minimumSize: const Size.fromHeight(44.0),
      ),
      onPressed: enabled && !inProgress ? onPressed : null,
      child: inProgress ? const CircularProgressIndicator() : child,
    );
  }
}
