import 'package:flutter/material.dart';
import 'package:geoplaceflutter/components/lugar_list.dart';
import 'package:geoplaceflutter/providers/lugar_provider.dart';
import 'package:provider/provider.dart';

class ListaScreen extends StatefulWidget {
  const ListaScreen({super.key});

  @override
  State<ListaScreen> createState() => _ListaScreenState();
}

class _ListaScreenState extends State<ListaScreen>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Cadastro de Local"),),
      ),
      body: ChangeNotifierProvider(
        create: (context) => LugarProvider(),
        child: Column(children: const [LugarList(),],), 
      ),
    );
  }
}