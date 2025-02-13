import 'package:flutter/material.dart';
import 'package:sales_app/screens/customers.dart';
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

  final Map<int, Widget> _pages = {
    0: const DashboardPage(),
    1: const CustomersPage(),
  };

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Sales App",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: _pages[selectedIndex],
        bottomNavigationBar: NavBar(
          selectedIndex: selectedIndex,
          onItemTapped: onItemTapped,
        ),
      ),
    );
  }
}
