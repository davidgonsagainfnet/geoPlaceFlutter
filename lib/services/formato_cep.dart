import 'package:flutter/services.dart';

class FormatoCep extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
  ) {
    final newText = newValue.text;

    // Remove qualquer formatação existente
    String MascaraText = newText.replaceAll(RegExp(r'[^0-9]'), '');

    if (MascaraText.length > 5) {
      MascaraText = MascaraText.substring(0, 5) + '-' +
          MascaraText.substring(5, MascaraText.length);
    }

    return newValue.copyWith(
      text: MascaraText,
      selection: TextSelection.collapsed(offset: MascaraText.length),
    );
  }
}