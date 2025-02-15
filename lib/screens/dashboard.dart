import 'package:flutter/material.dart';
import 'package:sales_app/components/statistic_component.dart';
import 'package:sales_app/components/table_stats_component.dart';

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
            body: SingleChildScrollView(
                child: Center(
              child: Column(
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    color: Colors.white,
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MaterialButton(
                              onPressed: () {},
                              color: const Color(0xFF423DD9),
                              textColor: Colors.white,
                              child: const Text(
                                "Show Sales",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                            const Text("11/02/2025"),
                          ]),
                    ),
                  ),
                  const StatsCard(
                      title: "Total revenue",
                      statValue: "\$45,253.89",
                      subtitle: "+20.1% from last month",
                      icon: Icons.monetization_on_outlined),
                  const StatsCard(
                      title: "Sales",
                      statValue: "+2350",
                      subtitle: "+180.1% from last month",
                      icon: Icons.shopping_cart_checkout_outlined),
                  const StatsCard(
                      title: "Products",
                      statValue: "456",
                      subtitle: "",
                      icon: Icons.inventory_2_outlined),
                  const StatsCard(
                      title: "Active Customers",
                      statValue: "573",
                      subtitle: "",
                      icon: Icons.group),
                  const TableStatsCard(title: "Recent Sales", headers: [
                    "Customer",
                    "Product",
                    "Amount",
                    "Date"
                  ], rows: [
                    ["John Doe", "T-shirt", "\$29.99", "2023-07-15"],
                    ["John Doe", "T-shirt", "\$29.99", "2023-07-15"],
                    ["John Doe", "T-shirt", "\$29.99", "2023-07-15"],
                  ]),
                  const TableStatsCard(title: "Recent Sales", headers: [
                    "Product",
                    "Sales",
                    "Revenue",
                  ], rows: [
                    ["T-shirt", "150", "\$4498.99"],
                    ["T-shirt", "150", "\$4498.99"],
                    ["T-shirt", "150", "\$4498.99"],
                  ])
                ],
              ),
            ))));
  }
}
