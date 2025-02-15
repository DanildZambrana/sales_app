import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_app/data/database.dart';
import 'package:sales_app/providers/contact_provider.dart';
import 'package:sales_app/components/custom_form_field.dart';

class CustomersForm extends StatelessWidget {
  final ContactData? contactData;

  const CustomersForm({super.key, this.contactData});

  static const EdgeInsets fieldPadding = EdgeInsets.all(8.0);

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

    return Card(
      child: Column(
        children: [
          CustomFormField<String>(
            initialValue: name,
            hintText: 'Nombre',
            onChanged: (value) => name = value,
          ),
          CustomFormField<String>(
            isEmail: true,
            initialValue: email,
            hintText: 'Correo',
            onChanged: (value) => email = value,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: handleSave,
                child: Text(contactData != null ? "Actualizar" : "Crear"),
              ),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancelar"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
