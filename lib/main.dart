import 'package:flutter/material.dart';
import 'package:geoplaceflutter/routes/route_paths.dart';
import 'package:geoplaceflutter/screens/cadastro_screen.dart';
import 'package:geoplaceflutter/screens/home_screen.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        RoutePaths.HOME: (context) => const HomeScreen(),
        RoutePaths.CADASTRO: (context) => CadastroScreen(),
        RoutePaths.LISTALUGAR: (context) => const Text("LISTA LUGAR")
      },
    );
  }

}