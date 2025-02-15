import 'package:flutter/foundation.dart';
import 'package:sales_app/data/database.dart';
import 'package:sales_app/data/repositories/sale_lines_repository.dart';
import 'package:sales_app/data/repositories/sales_repository.dart';
import 'package:sales_app/providers/provider_state.dart';

class SaleProvider extends ChangeNotifier {
  final SalesRepository repository;
  final SaleLinesRepository saleLinesRepository;

  SaleProvider(this.repository, this.saleLinesRepository);

  List<SaleData> _sales = [];
  ProviderState _state = ProviderState.loading;
  String? _errorMessage;

  List<SaleData> get sales => _sales;
  ProviderState get state => _state;
  String? get errorMessage => _errorMessage;

  Future<void> loadSales() async {
    _state = ProviderState.loading;
    notifyListeners();

    try {
      _sales = await repository.getSales();
      _state = ProviderState.loaded;
    } catch (e) {
      _state = ProviderState.error;
      _errorMessage = "Error al cargar ventas: $e";
    }

    notifyListeners();
  }

  Future<List<SaleData>> getSalesForContact(int contactId) async {
    return repository.getSalesForContact(contactId);
  }

  Future<int> addSale(contactId) async {
    return await repository.addSale(contactId);
  }

  Future<double> calculateTotalRevenue() async {
    try {
      final sales = await repository.getSales();

      double totalRevenue = 0.0;

      for (var sale in sales) {
        totalRevenue += await calculateTotalForSale(sale.id);
      }

      return totalRevenue;
    } catch (e) {
      debugPrint("Error calculating total revenue: $e");
      return 0.0;
    }
  }


  Future<double> calculateTotalForSale(int saleId) async {
    try {
      final lines = await saleLinesRepository.getLinesForSale(saleId);

      final total = lines.fold<double>(
        0.0,
            (sum, line) => sum + (line.total),
      );

      return total;
    } catch (e) {
      return 0.0;
    }
  }

  Future<int> getTotalSales() async {
    try {
      // Obtenemos todas las ventas
      final sales = await repository.getSales();

      // Retornamos la cantidad total de ventas
      return sales.length;
    } catch (e) {
      debugPrint("Error calculating total sales: $e");
      return 0; // Si ocurre un error, devolvemos 0
    }
  }

  Future<List<SaleData>> getRecentSales({int limit = 5}) async {
    try {
      // Obtenemos todas las ventas desde el repositorio
      final sales = await repository.getSales();

      // Ordenamos las ventas por fecha (suponiendo que `SaleData` tiene un campo `date`)
      sales.sort((a, b) => b.date.compareTo(a.date));

      // Retornamos las últimas `limit` ventas
      return sales.take(limit).toList();
    } catch (e) {
      debugPrint("Error fetching recent sales: $e");
      return []; // Si ocurre un error, devolvemos una lista vacía
    }
  }




}