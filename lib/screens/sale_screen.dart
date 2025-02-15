import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sales_app/components/card_with_buttons_component.dart';
import 'package:sales_app/components/outline_button_component.dart';
import 'package:sales_app/data/database.dart';
import 'package:sales_app/data/repositories/sale_lines_repository.dart';
import 'package:sales_app/providers/contact_provider.dart';
import 'package:sales_app/providers/current_sale_provider.dart';
import 'package:sales_app/providers/product_provider.dart';
import 'package:sales_app/providers/sale_provider.dart';
import 'package:sales_app/screens/sale_line_form.dart';
import 'package:sales_app/structure/labeled_navbar.dart';

class SaleScreen extends StatelessWidget {
  final Function onConfirm;
  final Function onCancel;

  const SaleScreen(
      {super.key, required this.onConfirm, required this.onCancel});

  static const Color primaryButtonColor = Color(0xFF423DD9);
  static const Color confirmButtonColor = Colors.deepPurple;
  static const Color cancelButtonColor = Colors.red;

  static const TextStyle totalTextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.43,
    letterSpacing: 0.10,
  );

  Widget _buildAddProductButton(
      BuildContext context,
      CurrentSaleProvider currentSaleProvider,
      ProductProvider productProvider) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: MaterialButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return Padding(
                padding: EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: SingleChildScrollView(
                  child: SaleLineForm(
                    products: productProvider.products,
                    onAccept: (selectedProduct, price, amount) {
                      if (selectedProduct == null) {
                        return;
                      }
                      currentSaleProvider.addLine(SaleLineDataWrapper(
                          productId: selectedProduct,
                          quantity: amount,
                          price: price));
                    },
                  ),
                ),
              );
            },
          );
        },
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

  Widget _buildBottomNavigationBar(SaleProvider saleProvider, SaleLinesRepository saleLinesRepo, CurrentSaleProvider currentSaleProvider) {
    double total = 0;
    for (var line in currentSaleProvider.currentLines.values) {
      total += line.quantity * line.price;
    }


    return LabeledNavbar(
      label: Text(
        "Total: \$$total",
        style: totalTextStyle,
      ),
      buttons: [
        OutlineButtonComponent(
          color: confirmButtonColor,
          onPressed: () {
            if (currentSaleProvider.currentSale?.contactId == null) {
              return;
            }
            saleProvider.addSale(currentSaleProvider.currentSale?.contactId).then((insertedSaleId) {
              print(currentSaleProvider.currentLines.toString());
              currentSaleProvider.currentLines.forEach((key, value) {
                saleLinesRepo.addLineWithSaleId(insertedSaleId, value.productId.id, value.quantity, value.price);
              });
            });

            onConfirm();
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

  List<Widget> _buildLineCards(
      BuildContext context,
      CurrentSaleProvider currentSaleProvider,
      ProductProvider productProvider) {
    return currentSaleProvider.currentLines.entries.map((entry) {
      int id = entry.key;
      SaleLineDataWrapper line = entry.value;
      return _buildCardWithButtons(
        title: line.productId.name,
        subtitle: "",
        startValue: "Cantidad: ${line.quantity}",
        endValue: "Total: ${line.quantity * line.price}",
        onEdit: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return Padding(
                padding: EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: SingleChildScrollView(
                  child: SaleLineForm(
                    products: productProvider.products,
                    onAccept: (selectedProduct, price, amount) {
                      if (selectedProduct == null) {
                        return;
                      }
                      currentSaleProvider.addLine(SaleLineDataWrapper(
                        id: id,
                          productId: selectedProduct,
                          quantity: amount,
                          price: price));
                    },
                    selectedProduct: line.productId,
                    price: line.price,
                    amount: line.quantity,
                  ),
                ),
              );
            },
          );
        },
        onDelete: () {
          currentSaleProvider.deleteLine(id);
        }
      );
    }).toList();
  }

  Widget _buildCardWithButtons({
    required String title,
    required String subtitle,
    required String startValue,
    required String endValue,
    required dynamic onEdit,
    required dynamic onDelete,
  }) {
    return CardWithButtons(
      cardTitle: title,
      cardSubtitle: subtitle,
      startValue: startValue,
      endValue: endValue,
      actionButtons: [
        OutlineButtonComponent(
          text: "Edit",
          onPressed: () {
            onEdit();
          },
          color: confirmButtonColor,
        ),
        OutlineButtonComponent(
          text: "Delete",
          onPressed: () {
            onDelete();
          },
          color: cancelButtonColor,
        ),
      ],
    );
  }

  Widget buildSelectPartner(
      BuildContext context,
      ContactProvider contactProvider,
      CurrentSaleProvider currentSaleProvider) {
    return DropdownMenu<ContactData>(
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(),
      ),
      hintText: "Contacto...",
      onSelected: (ContactData? selected) {
        if (selected == null) {
          return;
        }

        currentSaleProvider.setSale(SaleWrapper(selected.id));
      },
      dropdownMenuEntries: contactProvider.contacts.map((contact) {
        return DropdownMenuEntry(value: contact, label: contact.name);
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    CurrentSaleProvider currentSaleProvider =
        Provider.of<CurrentSaleProvider>(context);
    ContactProvider contactProvider = Provider.of<ContactProvider>(context);
    SaleProvider saleProvider = Provider.of<SaleProvider>(context);
    SaleLinesRepository saleLinesRepo = Provider.of<SaleLinesRepository>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Sales"),
        actions: [
          _buildAddProductButton(context, currentSaleProvider, productProvider)
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(saleProvider, saleLinesRepo, currentSaleProvider),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildSelectPartner(context, contactProvider, currentSaleProvider),
            ..._buildLineCards(context, currentSaleProvider, productProvider),
          ],
        ),
      ),
    );
  }
}
