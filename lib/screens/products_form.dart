import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_app/components/custom_form_field.dart';
import 'package:sales_app/data/database.dart';
import 'package:sales_app/providers/product_provider.dart';

class ProductsForm extends StatelessWidget {
  final ProductData? productData;

  const ProductsForm({super.key, this.productData});

  static const EdgeInsets fieldPadding = EdgeInsets.all(8.0);

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    String name = productData?.name ?? "";
    String category = productData?.category ?? "";
    int stock = productData?.stock ?? 0;
    double price = productData?.price ?? 0;

    void handleSave() {
      if (productData != null) {
        productProvider.updateProduct(productData!, name, category, price, stock);
      } else {
        productProvider.addProduct(name, category, price,  stock);
      }
      Navigator.pop(context);
    }

    return Card(
      child: Column(
        children: [
          CustomFormField<String>(initialValue: name, hintText: "Nombre", onChanged: (value) => name = value),
          CustomFormField<String>(initialValue: category, hintText: "Categoria", onChanged: (value) => category = value),
          CustomFormField<int>(initialValue: stock.toString(), hintText: "En inventario", onChanged: (value) => stock = value),
          CustomFormField<double>(initialValue: price.toString(), hintText: "Precio", onChanged: (value) => price = value),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: handleSave,
                child: Text(productData != null ? "Actualizar" : "Crear"),
              ),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancelar"),
              ),
            ],
          )
        ],
      ),
    );
  }
}