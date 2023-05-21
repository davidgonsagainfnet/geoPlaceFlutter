import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final TextInputType textInputType;

  const InputText({required this.labelText, required this.controller, required this.textInputType});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) {
          if(value!.isEmpty) return "Campo Obrigatorio";
            return null;
      },
      keyboardType: textInputType,
      decoration: InputDecoration(
          labelText: labelText,
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
          ),
      ),
    );
  }
}