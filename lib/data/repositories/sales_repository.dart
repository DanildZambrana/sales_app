import 'package:sales_app/data/database.dart';

class SalesRepository {
  final AppDatabase database;

  SalesRepository(this.database);

  Future<List<SaleData>> getSalesForContact(contactId) async {
    return await (database.select(database.sale)..where((sale) => sale.id.equals(contactId))).get();
  }
  Future<List<SaleData>> getSales() async {
    return await database.select(database.sale).get();
  }

  Future<int> addSale(contactId) async{
    return await database.into(database.sale).insert(SaleCompanion.insert(contactId: contactId, date: DateTime.now()));
  }
}