import 'package:flutter/material.dart';
import 'package:sales_app/data/database.dart';
import 'package:sales_app/data/repositories/products_repository.dart';
import 'package:sales_app/providers/provider_state.dart';

class ProductProvider extends ChangeNotifier {
  final ProductsRepository repository;

  ProductProvider(this.repository);

  List<ProductData> _products = [];
  ProviderState _state = ProviderState.loading;
  String? _errorMessage;

  List<ProductData> get products => _products;
  ProviderState get state => _state;
  String? get errorMessage => _errorMessage;


  Future<void> loadProducts() async {
    _state = ProviderState.loading;
    notifyListeners();

    try {
      _products = await repository.getProducts();
      _state = ProviderState.loaded;
    } catch (e) {
      _state = ProviderState.error;
      _errorMessage = "Error al cargar productos: $e";
    }
    notifyListeners();
  }

  Future<void> addProduct(String name, String category, double price, int stock) async {
    _state = ProviderState.loading;
    notifyListeners();

    try {
      await repository.addProduct(name, category, price, stock);
      await loadProducts();
    } catch (e) {
      _state = ProviderState.error;
      _errorMessage = "Error al agregar producto: $e";
      notifyListeners();
    }
  }

  Future<void> deleteProduct(ProductData product) async {
    _state = ProviderState.loading;
    notifyListeners();
    try {
      await repository.deleteProduct(product);
      await loadProducts();
    } catch (e) {
      _state = ProviderState.error;
      _errorMessage = "Error al eliminar producto: $e";
      notifyListeners();
    }
  }

  Future<void> updateProduct(ProductData product, String name, String category,
      double price, int stock) async {
    _state = ProviderState.loading;
    notifyListeners();

    try {
      await repository.updateProduct(product, name, category, price, stock);
      await loadProducts();
    } catch (e) {
      _state = ProviderState.error;
      _errorMessage = "Error al eliminar producto: $e";
      notifyListeners();
    }
  }
}