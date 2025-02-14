import 'package:sales_app/data/database.dart';

class ContactsRepository {
  final AppDatabase database;
  
  ContactsRepository(this.database);
  
  Future<List<ContactData>> getContacts() async {
    return await database.select(database.contact).get();
  }
  
  Future<void> addContact(String name, String email) async {
    await database.into(database.contact).insert(ContactCompanion.insert(name: name, email: email));
  }

  Future<void> deleteContact(ContactData contact) async {
    await database.delete(database.contact).delete(contact);
  }

  Future<void> updateContact(ContactData contact, String name, String email) async {
    await database.update(database.contact).replace(contact.copyWith(name: name, email: email));
  }
}