import 'package:sales_app/data/database.dart';

class SalesRepository {
  final AppDatabase database;

  SalesRepository(this.database);

  Future<List<SaleData>> getSalesForContact(contactId) async {
    return await (database.select(database.sale)..where((sale) => sale.id.equals(contactId))).get();
  }
}