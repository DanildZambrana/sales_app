import 'package:flutter/material.dart';
import 'package:sales_app/screens/customers.dart';
import 'package:sales_app/screens/sale_form.dart';
import 'package:sales_app/screens/stock.dart';
import 'package:sales_app/structure/labeled_navbar.dart';
import 'structure/navbar.dart';
import 'package:sales_app/screens/dashboard.dart';

void main() {
  runApp(const StoreApp());
}

class StoreApp extends StatefulWidget {
  const StoreApp({super.key});

  @override
  State<StoreApp> createState() => _StoreAppState();
}

class _StoreAppState extends State<StoreApp> {
  int selectedIndex = 0;

  // Declaramos la lista pero no la inicializamos aquí.
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    // Ahora inicializamos _pages dentro de initState().
    _pages = [
      const DashboardPage(),
      const CustomersPage(),
      SaleFormScreen(
        confirm: (value) {
          print(value);
        },
        cancel: () {
          setState(() {
            selectedIndex = 0;
          });
        },
      ),
      const StockPage(),
    ];
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  Widget _getBar() {
    if (selectedIndex == 2) {
      return const SizedBox.shrink();
    }

    return NavBar(
      selectedIndex: selectedIndex,
      onItemTapped: onItemTapped,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Sales App",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: _pages[selectedIndex],
        bottomNavigationBar: _getBar(),
      ),
    );
  }
}
