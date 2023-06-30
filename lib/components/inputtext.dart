import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final TextInputType textInputType;
  final bool isPassword;
  
  const InputText({super.key, required this.labelText, required this.controller, required this.textInputType, this.isPassword = false });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: key,
      controller: controller,
      validator: (value) {
          if(value!.isEmpty) return "Campo Obrigatorio";
            return null;
      },
      keyboardType: textInputType,
      obscureText: isPassword,
      decoration: InputDecoration(
          labelText: labelText,
          filled: true,
          fillColor: Colors.white,
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
          ),
      ),
    );
  }
}