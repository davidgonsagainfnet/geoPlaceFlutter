import 'package:flutter/material.dart';

Future<bool?> showLogoutConfirmationDialog(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmação de Logout'),
          content: const Text('Deseja efetuar o logout na conta?'),
          actions: [
            TextButton(
              child: const Text('Não'),
              onPressed: () {
                Navigator.of(context).pop(false); // Retorna false ao pressionar "Não"
              },
            ),
            TextButton(
              child: const Text('Sim'),
              onPressed: () {
                Navigator.of(context).pop(true); // Retorna true ao pressionar "Sim"
              },
            ),
          ],
        );
      },
    );
  }