import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_app/components/card_with_buttons_component.dart';
import 'package:sales_app/components/outline_button_component.dart';
import 'package:sales_app/providers/product_provider.dart';
import 'package:sales_app/providers/provider_state.dart';
import 'package:sales_app/screens/products_form.dart';

class StockPage extends StatelessWidget {
  const StockPage({super.key});

  static const unknownErrorText = "Ocurrió un error desconocido";

  Widget buildLoadingView() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget buildErrorView(ProductProvider productProvider) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            productProvider.errorMessage ?? unknownErrorText,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.red, fontSize: 16),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => productProvider.loadProducts(),
            child: const Text("Reintentar"),
          ),
        ],
      ),
    );
  }

  Widget buildEmptyProductsView() {
    return const Center(child: Text("No hay productos disponibles"));
  }

  Widget createProductsList(
      ProductProvider productProvider, BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: productProvider.products.map((product) {
          return CardWithButtons(
              cardTitle: product.name,
              cardSubtitle: product.category,
              startValue: product.stock.toString(),
              endValue: product.price.toString(),
              actionButtons: [
                OutlineButtonComponent(
                  text: "Editar",
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) => ProductsForm(
                              productData: product,
                            ));
                  },
                  color: Colors.deepPurple,
                ),
                OutlineButtonComponent(
                  text: "Eliminar",
                  onPressed: () {
                    productProvider.deleteProduct(product);
                  },
                  color: Colors.deepPurple,
                ),
              ]);
        }).toList(),
      ),
    );
  }

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

  Widget buildProductProviderBody(
      ProductProvider productProvider, BuildContext context) {
    switch (productProvider.state) {
      case ProviderState.loading:
        return buildLoadingView();

      case ProviderState.error:
        return buildErrorView(productProvider);
      case ProviderState.loaded:
        return productProvider.products.isEmpty
            ? buildEmptyProductsView()
            : createProductsList(productProvider, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Stock"),
        actions: [
          IconButton(
            icon: const Icon(Icons.sync),
            onPressed: () {
              productProvider.loadProducts();
            },
          ),
          IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) => const ProductsForm());
              })
        ],
      ),
      body: buildProductProviderBody(productProvider, context),
    );
  }
}
