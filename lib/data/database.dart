import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'dart:io';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sales_app/data/models/product.dart';
import 'package:sales_app/data/models/sale.dart';
import 'package:sales_app/data/models/sale_line.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

import 'models/contact.dart';

part 'database.g.dart';

@DriftDatabase(tables: [Contact, Product, Sale, SaleLine])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'sales_app/db.sqlite'));

      if (Platform.isAndroid) {
        await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
      }

      final cacheBase = (await getTemporaryDirectory()).path;
      sqlite3.tempDirectory = cacheBase;

      return NativeDatabase.createInBackground(file);
    });
  }
}
