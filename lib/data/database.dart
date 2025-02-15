import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart'; // SQLite nativa
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'package:sales_app/data/models/product.dart';
import 'package:sales_app/data/models/sale.dart';
import 'package:sales_app/data/models/sale_line.dart';

import 'models/contact.dart';

part 'database.g.dart';

@DriftDatabase(tables: [Contact, Product, Sale, SaleLine])
class AppDatabase extends _$AppDatabase {
  AppDatabase._internal() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static final AppDatabase _instance = AppDatabase._internal();

  static AppDatabase get instance => _instance;

}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final directory = await getApplicationDocumentsDirectory();
    final dbPath = p.join(directory.path, 'app_database.sqlite');
    return NativeDatabase(File(dbPath));
  });
}

