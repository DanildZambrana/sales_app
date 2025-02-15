import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_app/providers/sale_provider.dart';

class SalesScreen extends StatefulWidget {
  const SalesScreen({Key? key}) : super(key: key);

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  late Future<void> _salesFuture;

  @override
  void initState() {
    super.initState();
    // Carga inicial de ventas en el estado para asegurarte de que no ocurren conflictos
    _salesFuture = Provider.of<SaleProvider>(context, listen: false).loadSales();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sales'),
      ),
      body: FutureBuilder(
        future: _salesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          // Accedemos a las ventas cargadas usando Consumer para escuchar cambios
          return Consumer<SaleProvider>(
            builder: (context, saleProvider, child) {
              final sales = saleProvider.sales;

              if (sales.isEmpty) {
                return const Center(
                  child: Text('No sales found'),
                );
              }

              return ListView.builder(
                itemCount: sales.length,
                itemBuilder: (context, index) {
                  final sale = sales[index];
                  return FutureBuilder<double>(
                    future: saleProvider.calculateTotalForSale(sale.id),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const ListTile(
                          title: Text('Calculando total...'),
                        );
                      }

                      final total = snapshot.data ?? 0.0;
                      return ListTile(
                        leading: const Icon(Icons.attach_money_rounded),
                        title: Text('Sale ID: ${sale.id}'),
                        subtitle: Text('Total: \$${total.toStringAsFixed(2)}'),
                        trailing: Text(
                            sale.date.toIso8601String()), // Usa el atributo `date` si aplica
                      );
                    },
                  );
                },
              );
            },
          );
        },
      )
    );
  }
}