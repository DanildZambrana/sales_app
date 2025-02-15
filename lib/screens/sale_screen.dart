import 'package:flutter/material.dart';

import 'package:sales_app/components/card_with_buttons_component.dart';
import 'package:sales_app/components/outline_button_component.dart';
import 'package:sales_app/structure/labeled_navbar.dart';

class SaleScreen extends StatelessWidget {
  final Function confirm;
  final Function cancel;

  const SaleScreen(
      {super.key, required this.confirm, required this.cancel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Stock"),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: MaterialButton(
                onPressed: () {},
                color: const Color(0xFF423DD9),
                textColor: Colors.white,
                child: const Text(
                  "Add Product",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.normal),
                ),
              )),
        ],
      ),
      bottomNavigationBar: LabeledNavbar(
        label: const Text(
          "Total: \$200",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            height: 1.43,
            letterSpacing: 0.10,
          ),
        ),
        buttons: [
          OutlineButtonComponent(
            color: Colors.deepPurple,
            onPressed: () {
              confirm("Asd");
            },
            text: "Confirm",
          ),
          const SizedBox(
            width: 5,
          ),
          OutlineButtonComponent(
            color: Colors.red,
            onPressed: () {
              cancel();
            },
            text: "Cancel",
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CardWithButtons(
                cardTitle: "T-shirt",
                cardSubtitle: "Tax: 15%",
                startValue: "Quantity: 1",
                endValue: "Total Value: \$13.80",
                actionButtons: [
                  OutlineButtonComponent(
                      text: "Edit", onPressed: () {}, color: Colors.deepPurple),
                  OutlineButtonComponent(
                      text: "Delete", onPressed: () {}, color: Colors.red),
                ]),
          ],
        ),
      ),
    );
  }
}
