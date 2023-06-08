import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geoplaceflutter/firebase_options.dart';
import 'package:geoplaceflutter/routes/route_paths.dart';
import 'package:geoplaceflutter/screens/cadastro_screen.dart';
import 'package:geoplaceflutter/screens/home_screen.dart';
import 'package:geoplaceflutter/screens/lista_screen.dart';
import 'package:geoplaceflutter/screens/login_cadastro_screen.dart';
import 'package:geoplaceflutter/screens/login_screen.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        RoutePaths.HOME: (context) => const HomeScreen(),
        RoutePaths.CADASTRO: (context) => const CadastroScreen(),
        RoutePaths.LISTALUGAR: (context) => const ListaScreen(),
        RoutePaths.LOGIN: (context) => const LoginScreen(),
        RoutePaths.CADASTROLOGIN: (context) => const LoginCadastroScreen()
      },
    );
  }

}