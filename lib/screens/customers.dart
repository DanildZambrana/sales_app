import 'package:flutter/material.dart';
import 'package:sales_app/structure/navbar.dart';

class CustomersPage extends StatelessWidget {
  const CustomersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Customers"),
      ),
      body: const Center(
        child: Text("Customers page"),
      ),
    );
  }
}
