import 'package:drift/drift.dart';
import 'package:sales_app/data/models/contact.dart';

class Sale extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get contactId => integer().references(Contact, #id)();
  DateTimeColumn get date => dateTime()();
}
