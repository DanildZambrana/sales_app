import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_app/data/database.dart';
import 'package:sales_app/providers/contact_provider.dart';

class CustomersForm extends StatelessWidget {
  final ContactData? contactData;

  const CustomersForm({super.key, this.contactData});

  static const EdgeInsets fieldPadding = EdgeInsets.all(
      8.0);

  @override
  Widget build(BuildContext context) {
    final contactProvider = Provider.of<ContactProvider>(context);

    String name = contactData?.name ?? "";
    String email = contactData?.email ?? "";

    void handleSave() {
      if (contactData != null) {
        contactProvider.updateContact(contactData!, name, email);
      } else {
        contactProvider.addContact(name, email);
      }
      Navigator.pop(context);
    }

    Widget buildInputField({
      required String initialValue,
      required String hintText,
      required void Function(String) onChanged,
    }) {
      return Padding(
        padding: fieldPadding,
        child: TextFormField(
          initialValue: initialValue,
          decoration: InputDecoration(
            hintText: hintText,
            border: const OutlineInputBorder(),
          ),
          onChanged: onChanged,
        ),
      );
    }

    return Card(
      child: Column(
        children: [
          buildInputField(
            initialValue: name,
            hintText: 'Nombre',
            onChanged: (value) => name = value,
          ),
          buildInputField(
            initialValue: email,
            hintText: 'Correo',
            onChanged: (value) => email = value,
          ),
          ElevatedButton(
            onPressed: handleSave,
            child: Text(contactData != null ? "Actualizar" : "Crear"),
          ),
        ],
      ),
    );
  }
}