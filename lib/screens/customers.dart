import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_app/components/card_with_buttons_component.dart';
import 'package:sales_app/components/outline_button_component.dart';
import 'package:sales_app/providers/contact_provider.dart';
import 'package:sales_app/providers/provider_state.dart';
import 'package:sales_app/screens/customers_form.dart';

class CustomersPage extends StatelessWidget {
  const CustomersPage({super.key});

  bool get hasCustomBar => false;
  static const unknownErrorText = "Ocurrió un error desconocido";

  Widget buildLoadingView() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget buildErrorView(ContactProvider contactProvider) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            contactProvider.errorMessage ?? unknownErrorText,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.red, fontSize: 16),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => contactProvider.loadContacts(),
            child: const Text("Reintentar"),
          ),
        ],
      ),
    );
  }

  Widget buildEmptyContactsView() {
    return const Center(child: Text("No hay contactos disponibles"));
  }

  Widget createContactsList(
      ContactProvider contactProvider, BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: contactProvider.contacts.map((contact) {
          return CardWithButtons(
            cardTitle: contact.name,
            cardSubtitle: contact.email,
            startValue: "Orders: 1",
            endValue: "Spent: \$100.00",
            actionButtons: [
              OutlineButtonComponent(
                text: "Editar",
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) => CustomersForm(
                            contactData: contact,
                          ));
                },
                color: Colors.deepPurple,
              ),
              OutlineButtonComponent(
                text: "Eliminar",
                onPressed: () {
                  contactProvider.deleteContact(contact);
                },
                color: Colors.deepPurple,
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget buildContactProviderBody(
      ContactProvider contactProvider, BuildContext context) {
    switch (contactProvider.state) {
      case ProviderState.loading:
        return buildLoadingView();
      case ProviderState.error:
        return buildErrorView(contactProvider);
      case ProviderState.loaded:
        return contactProvider.contacts.isEmpty
            ? buildEmptyContactsView()
            : createContactsList(contactProvider, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final contactProvider = Provider.of<ContactProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Customers"),
        actions: [
          IconButton(
            icon: const Icon(Icons.sync),
            onPressed: () {
              contactProvider.loadContacts();
            },
          ),
          IconButton(icon: const Icon(Icons.add), onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (context) => const CustomersForm());
          })
        ],
      ),
      body: buildContactProviderBody(contactProvider, context),
    );
  }
}
