import 'package:flutter/foundation.dart';
import 'package:sales_app/data/database.dart';
import 'package:sales_app/data/repositories/sales_repository.dart';
import 'package:sales_app/providers/provider_state.dart';

class SaleProvider extends ChangeNotifier {
  final SalesRepository repository;

  SaleProvider(this.repository);

  List<SaleData> _sales = [];
  ProviderState _state = ProviderState.loading;
  String? _errorMessage;

  List<SaleData> get sales => _sales;
  ProviderState get state => _state;
  String? get errorMessage => _errorMessage;


  Future<List<SaleData>> getSalesForContact(int contactId) async {
    return repository.getSalesForContact(contactId);
  }
}