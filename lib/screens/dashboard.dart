import 'package:flutter/material.dart';
import 'package:sales_app/screens/customers.dart';
import 'package:sales_app/structure/navbar.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent),
        child: Scaffold(
            appBar: AppBar(
              title: const Text("Dashboard"),
            ),
            body: const Center(
              child: Text('Esto es el dashboard xd'),
            )));
  }
}
