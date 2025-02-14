import 'package:drift/drift.dart';

class Product extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get category => text()();
  RealColumn get price => real()();
  IntColumn get stock => integer()();
}