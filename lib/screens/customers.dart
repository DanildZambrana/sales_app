import 'package:flutter/material.dart';
import 'package:sales_app/components/card_with_buttons_component.dart';
import 'package:sales_app/structure/navbar.dart';
import 'package:sales_app/components/outline_button_component.dart';

class CustomersPage extends StatelessWidget {
  const CustomersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Customers"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              CardWithButtons(
                  cardTitle: "John Doe",
                  cardSubtitle: "jhon@email.com",
                  startValue: "Orders: 5",
                  endValue: "Spent: \$299.95",
                  actionButtons: [
                    OutlineButtonComponent(
                        text: "Edit",
                        onPressed: () {},
                        color: Colors.deepPurple),
                    OutlineButtonComponent(
                        text: "Delete", onPressed: () {}, color: Colors.red),
                  ]),
              CardWithButtons(
                  cardTitle: "John Doe",
                  cardSubtitle: "jhon@email.com",
                  startValue: "Orders: 5",
                  endValue: "Spent: \$299.95",
                  actionButtons: [
                    OutlineButtonComponent(
                        text: "Edit",
                        onPressed: () {},
                        color: Colors.deepPurple),
                    OutlineButtonComponent(
                        text: "Delete", onPressed: () {}, color: Colors.red),
                  ]),
              CardWithButtons(
                  cardTitle: "John Doe",
                  cardSubtitle: "jhon@email.com",
                  startValue: "Orders: 5",
                  endValue: "Spent: \$299.95",
                  actionButtons: [
                    OutlineButtonComponent(
                        text: "Edit",
                        onPressed: () {},
                        color: Colors.deepPurple),
                    OutlineButtonComponent(
                        text: "Delete", onPressed: () {}, color: Colors.red),
                  ]),
              CardWithButtons(
                  cardTitle: "John Doe",
                  cardSubtitle: "jhon@email.com",
                  startValue: "Orders: 5",
                  endValue: "Spent: \$299.95",
                  actionButtons: [
                    OutlineButtonComponent(
                        text: "Edit",
                        onPressed: () {},
                        color: Colors.deepPurple),
                    OutlineButtonComponent(
                        text: "Delete", onPressed: () {}, color: Colors.red),
                  ]),
            ],
          ),
        ));
  }
}
