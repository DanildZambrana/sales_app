import 'package:flutter/material.dart';

class OutlineButtonComponent extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;

  const OutlineButtonComponent(
      {super.key,
      required this.text,
      required this.onPressed,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          side: BorderSide(color: color),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: color,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
  }
}
