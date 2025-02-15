import 'package:flutter/material.dart';
import 'package:sales_app/data/repositories/contacts_repository.dart';
import 'package:sales_app/providers/provider_state.dart';

import 'package:sales_app/data/database.dart';

class ContactProvider extends ChangeNotifier {
  final ContactsRepository repository;

  ContactProvider(this.repository);

  List<ContactData> _contacts = [];
  ProviderState _state = ProviderState.loading;
  String? _errorMessage;

  List<ContactData> get contacts => _contacts;
  ProviderState get state => _state;
  String? get errorMessage => _errorMessage;

  Future<void> loadContacts() async {
    _state = ProviderState.loading;
    notifyListeners();

    try {
      _contacts = await repository.getContacts();
      _state = ProviderState.loaded;
    } catch (e) {
      _state = ProviderState.error;
      _errorMessage = "Error al cargar contactos: $e";
    }
    notifyListeners();
  }

  Future<void> addContact(String name, String email) async {
    _state = ProviderState.loading;
    notifyListeners();

    try {
      await repository.addContact(name, email);
      await loadContacts();
    } catch (e) {
      _state = ProviderState.error;
      _errorMessage = "Error al agregar contacto: $e";
      notifyListeners();
    }
  }

  Future<void> deleteContact(ContactData contact) async {
    _state = ProviderState.loading;
    notifyListeners();
    try {
      await repository.deleteContact(contact);
      await loadContacts();
    } catch (e) {
      _state = ProviderState.error;
      _errorMessage = "Error al eliminar contacto: $e";
      notifyListeners();
    }
  }

  Future<void> updateContact(ContactData contact, String name, String email) async {
    _state = ProviderState.loading;
    notifyListeners();

    try {
      await repository.updateContact(contact, name, email);
      await loadContacts();
    } catch (e) {
      _state = ProviderState.error;
      _errorMessage = "Error al eliminar contacto: $e";
      notifyListeners();
    }
  }
}
