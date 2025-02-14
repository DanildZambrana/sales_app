import 'package:drift/drift.dart';
import 'package:sales_app/data/models/product.dart';
import 'package:sales_app/data/models/sale.dart';

class SaleLine extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get saleId => integer().references(Sale, #id)();
  IntColumn get productId => integer().references(Product, #id)();
  IntColumn get amount => integer()();
  RealColumn get unitPrice => real()();
  RealColumn get taxAmount => real()();
  RealColumn get total => real()();
}