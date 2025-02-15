import 'package:sales_app/data/database.dart';

class SaleLinesRepository {
  final AppDatabase database;

  SaleLinesRepository(this.database);

  Future<List<SaleLineData>> getLinesForSale(saleId) async {
    return await (database.select(database.saleLine)
      ..where((line) => line.saleId.equals(saleId))).get();
  }

  Future<void> addLineWithSaleId(saleId, productId, amount, unitPrice) async {
    double total = amount * unitPrice;

    await database.into(database.saleLine).insert(SaleLineCompanion.insert(
        saleId: saleId,
        productId: productId,
        amount: amount,
        unitPrice: unitPrice,
        taxAmount: 0.0,
        total: total));
  }
}