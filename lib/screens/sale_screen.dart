import 'package:flutter/material.dart';

import 'package:sales_app/components/card_with_buttons_component.dart';
import 'package:sales_app/components/outline_button_component.dart';
import 'package:sales_app/structure/labeled_navbar.dart';

class SaleScreen extends StatelessWidget {
  final Function onConfirm;
  final Function onCancel;

  const SaleScreen({
    super.key,
    required this.onConfirm,
    required this.onCancel
  });

  static const Color primaryButtonColor = Color(0xFF423DD9);
  static const Color confirmButtonColor = Colors.deepPurple;
  static const Color cancelButtonColor = Colors.red;

  static const TextStyle totalTextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.43,
    letterSpacing: 0.10,
  );

  Widget _buildAddProductButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: MaterialButton(
        onPressed: () {},
        color: primaryButtonColor,
        textColor: Colors.white,
        child: const Text(
          "Add Product",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return LabeledNavbar(
      label: const Text(
        "Total: \$200",
        style: totalTextStyle,
      ),
      buttons: [
        OutlineButtonComponent(
          color: confirmButtonColor,
          onPressed: () {
            onConfirm("Asd");
          },
          text: "Confirm",
        ),
        const SizedBox(width: 5),
        OutlineButtonComponent(
          color: cancelButtonColor,
          onPressed: () {
            onCancel();
          },
          text: "Cancel",
        ),
      ],
    );
  }

  Widget _buildCardWithButtons({
    required String title,
    required String subtitle,
    required String startValue,
    required String endValue,
  }) {
    return CardWithButtons(
      cardTitle: title,
      cardSubtitle: subtitle,
      startValue: startValue,
      endValue: endValue,
      actionButtons: [
        OutlineButtonComponent(
          text: "Edit",
          onPressed: () {},
          color: confirmButtonColor,
        ),
        OutlineButtonComponent(
          text: "Delete",
          onPressed: () {},
          color: cancelButtonColor,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Stock"),
        actions: [_buildAddProductButton()],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildCardWithButtons(
              title: "T-shirt",
              subtitle: "Tax: 15%",
              startValue: "Quantity: 1",
              endValue: "Total Value: \$13.80",
            ),
          ],
        ),
      ),
    );
  }
}
