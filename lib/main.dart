import 'package:flutter/material.dart';
import 'package:geoplaceflutter/routes/route_paths.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        RoutePaths.HOME: (context) => const Text("HOME"),
        RoutePaths.CADASTRO: (context) => const Text("CADASTRO"),
        RoutePaths.LISTALUGAR: (context) => const Text("LISTA LUGAR")
      },
    );
  }

}