import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomFormField<T> extends StatelessWidget {
  final String initialValue;
  final String hintText;
  final void Function(T) onChanged;
  final bool isEmail;

  const CustomFormField({
    super.key,
    required this.initialValue,
    required this.hintText,
    required this.onChanged,
    this.isEmail = false, // Opción para habilitar el teclado tipo email
  });

  @override
  Widget build(BuildContext context) {
    TextInputType inputType;
    List<TextInputFormatter> inputFormatter = [];

    if (isEmail) {
      inputType = TextInputType.emailAddress;
      inputFormatter = [
        FilteringTextInputFormatter.allow(
          RegExp(
              r'[a-zA-Z0-9@._-]'), // Permite solo caracteres válidos para correos electrónicos
        ),
      ];
    } else if (T == int) {
      inputType = TextInputType.number;
      inputFormatter = [FilteringTextInputFormatter.digitsOnly];
    } else if (T == double) {
      inputType = const TextInputType.numberWithOptions(decimal: true);
      inputFormatter = [
        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))
      ];
    } else {
      inputType = TextInputType.text;
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        initialValue: initialValue,
        keyboardType: inputType,
        inputFormatters: inputFormatter,
        decoration: InputDecoration(
          hintText: hintText,
          border: const OutlineInputBorder(),
        ),
        onChanged: (value) {
          if (T == int) {
            final parsedValue = int.tryParse(value);
            if (parsedValue != null) onChanged(parsedValue as T);
          } else if (T == double) {
            final parsedValue = double.tryParse(value);
            if (parsedValue != null) onChanged(parsedValue as T);
          } else {
            onChanged(value as T);
          }
        },
      ),
    );
  }
}
