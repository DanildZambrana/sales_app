import 'package:flutter/material.dart';
import 'package:sales_app/components/custom_form_field.dart';
import 'package:sales_app/components/outline_button_component.dart';
import 'package:sales_app/data/database.dart';

class SaleLineForm extends StatefulWidget {
  final Function(ProductData?, double, int) onAccept;

  final List<ProductData> products;
  final ProductData? selectedProduct;
  final double price;
  final int amount;

  const SaleLineForm({
    super.key,
    required this.onAccept,
    this.selectedProduct,
    required this.products,
    this.price = 0,
    this.amount = 0,
  });

  @override
  State<SaleLineForm> createState() => _SaleLineFormState();
}

class _SaleLineFormState extends State<SaleLineForm> {
  ProductData? selectedProduct;
  double price = 0;
  int amount = 0;

  // Inicializas los valores en el initState
  @override
  void initState() {
    super.initState();
    selectedProduct = widget.selectedProduct;
    price = widget.price;
    amount = widget.amount;
  }

  Widget buildSelectProductField(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded( // Hace que el Dropdown se adapte al espacio disponible
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownMenu<ProductData>(
              inputDecorationTheme: const InputDecorationTheme(
                border: OutlineInputBorder(),
              ),
              hintText: "Producto...",
              initialSelection: selectedProduct,
              onSelected: (ProductData? selected) {
                setState(() {
                  selectedProduct = selected;
                });
              },
              dropdownMenuEntries: widget.products.map((product) {
                return DropdownMenuEntry<ProductData>(
                  value: product,
                  label: product.name,
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildSelectProductField(context),
          const Text('Precio Unitario'),
          CustomFormField<double>(
            initialValue: price.toString(),
            hintText: "Precio unitario",
            onChanged: (value) {
              setState(() {
                price = value;
              });
            },
          ),
          const Text("Cantidad"),
          CustomFormField<int>(
            initialValue: amount.toString(),
            hintText: "Cantidad",
            onChanged: (value) {
              setState(() {
                amount = value;
              });
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text("Total: ${price * amount}", style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14
                ),),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlineButtonComponent(
                color: Colors.red,
                onPressed: () {
                  Navigator.pop(context);
                },
                text: "Cancelar",
              ),
              const SizedBox(width: 10,),
              MaterialButton(
                onPressed: () {
                  widget.onAccept(
                    selectedProduct,
                    price,
                    amount,
                  );
                  Navigator.pop(context); // Cierra el modal
                },
                color: Colors.deepPurple,
                child: const Text("Agregar", style: TextStyle(
                  color: Colors.white,
                ),),
              ),
            ],
          )
        ],
      ),
    );
  }
}
