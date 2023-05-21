import 'package:flutter/material.dart';

void alertCustom(BuildContext context, String title, String content) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            child: Text('Fechar'),
            onPressed: () {
              Navigator.of(context).pop(); // Fechar o alerta
            },
          ),
        ],
      );
    },
  );
}