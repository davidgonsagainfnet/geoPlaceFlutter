import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../components/modal.dart';
import '../routes/route_paths.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final FirebaseAuth auth = FirebaseAuth.instance;
  
  get emailExibe => auth.currentUser?.email.toString();

  void _bloqueio() {
    if(auth.currentUser == null){
      Navigator.pushNamed(context, RoutePaths.LOGIN);
    }
  }

  

  @override
  Widget build(BuildContext context) {
    
    _bloqueio();

    int _currentIndex = 0;

  Future<void> _navegacao(int index) async {
    
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushNamed(context, RoutePaths.CADASTRO);
        break;
      case 1:
        Navigator.pushNamed(context, RoutePaths.LISTALUGAR);
        break;
      case 2:
        bool? logoutConfirmado = await showLogoutConfirmationDialog(context);
        if(logoutConfirmado != null && logoutConfirmado){
          try{
            await auth.signOut();
            // ignore: use_build_context_synchronously
            Navigator.pushNamed(context, RoutePaths.LOGIN);
          } catch(e){
            // ignore: use_build_context_synchronously
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$e"), duration: const Duration(seconds: 2),));
          }
        }
        break;
    }
  }

  
    var network = Lottie.network("https://assets3.lottiefiles.com/packages/lf20_u1pr4zua.json");
    return Scaffold(
      appBar: AppBar(title: Center( child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("GEO", style: TextStyle(fontSize: 50),),
          Transform.scale(scale: 1.5, child: Image.asset( 'assets/pointTopoint.png', width: 50,),),
          const Text("PLACE", style: TextStyle(fontSize: 50),),
        ],
      ),
      ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.green,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 120, bottom: 24),
              child: Lottie.network(
                "https://assets5.lottiefiles.com/packages/lf20_6YCRFI.json",
              ),
            ),
            const Text(
              "Seu lugar favorito",
              style: TextStyle(
                fontSize: 32,
                letterSpacing: -1.2,
                fontWeight: FontWeight.w600,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(
                "App Perfeito para marca Seu locais favoritos $emailExibe",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue, 
        currentIndex: _currentIndex,
        onTap: _navegacao,
        items: [
        BottomNavigationBarItem(icon: Image.asset('assets/gmappoint.png'), label: '', backgroundColor: Colors.blue,),
        BottomNavigationBarItem(icon: Image.asset('assets/placephoto.png'), label: '', backgroundColor: Colors.blue,),
        BottomNavigationBarItem(icon: Image.asset('assets/bt_logout.png', width: 60,), label: '', backgroundColor: Colors.yellow,),
      ]),
    );
  }
}