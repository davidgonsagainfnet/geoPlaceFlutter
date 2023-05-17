import 'package:flutter/material.dart';

import '../routes/route_paths.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _currentIndex = 0;

  void _navegacao(int index) {
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center( child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("GEO", style: TextStyle(fontSize: 50),),
          Transform.scale(scale: 1.5, child: Image.asset( 'assets/pointTopoint.png', width: 100,),),
          const Text("PLACE", style: TextStyle(fontSize: 50),),
        ],
      ),
      ),
      ),
      body: const Center(child: Text("Aqui fica o mapa")),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue, 
        currentIndex: _currentIndex,
        onTap: _navegacao,
        items: [
        BottomNavigationBarItem(icon: Image.asset('assets/gmappoint.png'), label: '', backgroundColor: Colors.blue,),
        BottomNavigationBarItem(icon: Image.asset('assets/placephoto.png'), label: '', backgroundColor: Colors.blue,),
      ]),
    );
  }
}