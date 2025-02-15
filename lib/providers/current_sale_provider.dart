import 'package:flutter/material.dart';
import 'package:sales_app/data/database.dart';

class SaleLineDataWrapper {
  int? id;
  ProductData productId;
  int quantity;
  double price;

  SaleLineDataWrapper({this.id, required this.productId, required this.quantity, required this.price});
}

class SaleWrapper {
  int contactId;

  SaleWrapper(this.contactId);
}

class CurrentSaleProvider extends ChangeNotifier {
  SaleWrapper? _currentSale;
  final Map<int, SaleLineDataWrapper> _currentLines = {};

  SaleWrapper? get currentSale => _currentSale;

  Map<int, SaleLineDataWrapper> get currentLines => _currentLines;

  Future<void> setSale(saleData) async {
    _currentSale = saleData;
    notifyListeners();
  }

  Future<void> addLine(SaleLineDataWrapper line) async {
    int randomId = DateTime.now().microsecondsSinceEpoch;
    _currentLines[line.id ?? randomId] = line;
    notifyListeners();
  }

  Future<void> updateLine(number, saleLineData) async {
    //si el mapa contiene esa key actualiza la line
    if (_currentLines.containsKey(number)) {
      _currentLines[number] = saleLineData;
      notifyListeners();
    }
  }

  Future<void> deleteLine(number) async {
    _currentLines.remove(number);
    notifyListeners();
  }
}
