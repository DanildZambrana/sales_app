import 'package:flutter/material.dart';
import 'package:sales_app/components/card_with_buttons_component.dart';
import 'package:sales_app/components/outline_button_component.dart';

class StockPage extends StatelessWidget {
  const StockPage({super.key});

  //Todo define real object types
  PopupMenuButton<String> _buildPopOverItem(dynamic object) {
    return PopupMenuButton<String>(
      itemBuilder: (BuildContext context) => [
        const PopupMenuItem(value: "edit", child: Text("Edit")),
        const PopupMenuItem(value: "delete", child: Text("Delete")),
      ],
      onSelected: (option) {
        switch (option) {
          case "edit":
            print("Editing $object");
            break;
          case "delete":
            print("Deleting $object");
            break;
        }
      },
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Colors.deepPurple),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(
              color: Colors.deepPurple,
            ),
            borderRadius: BorderRadius.circular(8)),
        child: const Padding(
          padding: EdgeInsets.all(4.0),
          child: Icon(
            Icons.more_vert,
            color: Colors.deepPurple,
          ),
        ),
      ),
    );
  }

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
                  "Add new",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.normal),
                ),
              )),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CardWithButtons(
                cardTitle: "T-shirt",
                cardSubtitle: "SKU: TS001",
                startValue: "In Stock: 100",
                endValue: "Reorder At: 20",
                actionButtons: [
                  OutlineButtonComponent(
                      text: "Adjust Stock",
                      onPressed: () {},
                      color: Colors.deepPurple),
                  OutlineButtonComponent(
                      text: "Reorder",
                      onPressed: () {},
                      color: Colors.deepPurple),
                  _buildPopOverItem('first'),
                ]),
            CardWithButtons(
                cardTitle: "T-shirt",
                cardSubtitle: "SKU: TS001",
                startValue: "In Stock: 100",
                endValue: "Reorder At: 20",
                actionButtons: [
                  OutlineButtonComponent(
                      text: "Adjust Stock",
                      onPressed: () {},
                      color: Colors.deepPurple),
                  OutlineButtonComponent(
                      text: "Reorder",
                      onPressed: () {},
                      color: Colors.deepPurple),
                  _buildPopOverItem('second'),
                ]),
            CardWithButtons(
                cardTitle: "T-shirt",
                cardSubtitle: "SKU: TS001",
                startValue: "In Stock: 100",
                endValue: "Reorder At: 20",
                actionButtons: [
                  OutlineButtonComponent(
                      text: "Adjust Stock",
                      onPressed: () {},
                      color: Colors.deepPurple),
                  OutlineButtonComponent(
                      text: "Reorder",
                      onPressed: () {},
                      color: Colors.deepPurple),
                  _buildPopOverItem('third'),
                ]),
          ],
        ),
      ),
    );
  }
}
