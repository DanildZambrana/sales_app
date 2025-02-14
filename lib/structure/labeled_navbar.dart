import 'package:flutter/material.dart';
import 'package:sales_app/structure/navbar.dart';

class LabeledNavbar extends StatelessWidget {
  final List<Widget> buttons;
  final Widget label;
  const LabeledNavbar({super.key, required this.buttons, required this.label});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        children: [
          Expanded(child: label),
          ...buttons
        ]
      )
    );
  }
}