import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_app/components/statistic_component.dart';
import 'package:sales_app/data/database.dart';
import 'package:sales_app/providers/contact_provider.dart';
import 'package:sales_app/providers/sale_provider.dart';
import 'package:sales_app/providers/product_provider.dart';

class DashboardPage extends StatefulWidget {
  final Function goToSales;

  const DashboardPage({super.key, required this.goToSales});

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
        hoverColor: Colors.transparent,
      ),
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
                          onPressed: () {
                            widget.goToSales();
                          },
                          color: const Color(0xFF423DD9),
                          textColor: Colors.white,
                          child: const Text(
                            "Show Sales",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                        const Text("11/02/2025"), // Fecha fija
                      ],
                    ),
                  ),
                ),
                // Total Revenue Card
                FutureBuilder<double>(
                  future: Provider.of<SaleProvider>(context, listen: false)
                      .calculateTotalRevenue(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const StatsCard(
                        title: "Total revenue",
                        statValue: "Loading...",
                        subtitle: "",
                        icon: Icons.monetization_on_outlined,
                      );
                    } else if (snapshot.hasError) {
                      return const StatsCard(
                        title: "Total revenue",
                        statValue: "Error",
                        subtitle: "",
                        icon: Icons.monetization_on_outlined,
                      );
                    }

                    final revenue = snapshot.data ?? 0.0;
                    return StatsCard(
                      title: "Total revenue",
                      statValue: "\$${revenue.toStringAsFixed(2)}",
                      subtitle: "+20.1% from last month", // Dinamizar si aplica
                      icon: Icons.monetization_on_outlined,
                    );
                  },
                ),
                // Total Sales Card
                FutureBuilder<int>(
                  future: Provider.of<SaleProvider>(context, listen: false)
                      .getTotalSales(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const StatsCard(
                        title: "Sales",
                        statValue: "Loading...",
                        subtitle: "",
                        icon: Icons.shopping_cart_checkout_outlined,
                      );
                    } else if (snapshot.hasError) {
                      return const StatsCard(
                        title: "Sales",
                        statValue: "Error",
                        subtitle: "",
                        icon: Icons.shopping_cart_checkout_outlined,
                      );
                    }

                    final totalSales = snapshot.data ?? 0;
                    return StatsCard(
                      title: "Sales",
                      statValue: "+$totalSales",
                      subtitle: "+180.1% from last month", // Dinamizar si aplica
                      icon: Icons.shopping_cart_checkout_outlined,
                    );
                  },
                ),
                // Total Products Card
                FutureBuilder<int>(
                  future: Provider.of<ProductProvider>(context, listen: false)
                      .getTotalProducts(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const StatsCard(
                        title: "Products",
                        statValue: "Loading...",
                        subtitle: "",
                        icon: Icons.inventory_2_outlined,
                      );
                    } else if (snapshot.hasError) {
                      return const StatsCard(
                        title: "Products",
                        statValue: "Error",
                        subtitle: "",
                        icon: Icons.inventory_2_outlined,
                      );
                    }

                    final totalProducts = snapshot.data ?? 0;
                    return StatsCard(
                      title: "Products",
                      statValue: "$totalProducts",
                      subtitle: "",
                      icon: Icons.inventory_2_outlined,
                    );
                  },
                ),
                // Active Customers Card
                FutureBuilder<int>(
                  future: Provider.of<ContactProvider>(context, listen: false)
                      .getActiveCustomers(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const StatsCard(
                        title: "Active Customers",
                        statValue: "Loading...",
                        subtitle: "",
                        icon: Icons.group,
                      );
                    } else if (snapshot.hasError) {
                      return const StatsCard(
                        title: "Active Customers",
                        statValue: "Error",
                        subtitle: "",
                        icon: Icons.group,
                      );
                    }

                    final activeCustomers = snapshot.data ?? 0;
                    return StatsCard(
                      title: "Active Customers",
                      statValue: "$activeCustomers",
                      subtitle: "",
                      icon: Icons.group,
                    );
                  },
                ),
                // Recent Sales Table
                FutureBuilder<List<SaleData>>(
                  future: Provider.of<SaleProvider>(context, listen: false).getRecentSales(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const StatsCard(
                        title: "Recent Sales",
                        statValue: "Loading...",
                        subtitle: "",
                        icon: Icons.shopping_cart_outlined,
                      );
                    } else if (snapshot.hasError) {
                      return const StatsCard(
                        title: "Recent Sales",
                        statValue: "Error",
                        subtitle: "",
                        icon: Icons.shopping_cart_outlined,
                      );
                    }

                    final recentSales = snapshot.data ?? [];
                    return StatsCard(
                      title: "Recent Sales",
                      statValue: recentSales.length > 0 ?
                      "${recentSales.length} sales" : "No recent sales",
                      subtitle: "Showing last ${recentSales.length} sales",
                      icon: Icons.shopping_cart_outlined,
                    );
                  },
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}