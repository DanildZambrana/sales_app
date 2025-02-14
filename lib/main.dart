import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_app/data/database.dart';
import 'package:sales_app/data/repositories/contacts_repository.dart';
import 'package:sales_app/providers/contact_provider.dart';
import 'package:sales_app/screens/customers.dart';
import 'package:sales_app/screens/sale_form.dart';
import 'package:sales_app/screens/stock.dart';
import 'structure/navbar.dart';
import 'package:sales_app/screens/dashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(providers: [
      Provider<ContactsRepository>(
          create: (_) => ContactsRepository(AppDatabase.instance)),
      ChangeNotifierProvider(
          create: (context) =>
              ContactProvider(context.read<ContactsRepository>())
                ..loadContacts()),
    ], child: const StoreApp()),
  );
}

class StoreApp extends StatefulWidget {
  const StoreApp({super.key});

  @override
  State<StoreApp> createState() => _StoreAppState();
}

class _StoreAppState extends State<StoreApp> {
  int selectedIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
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
