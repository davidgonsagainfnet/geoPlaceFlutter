import 'package:flutter/material.dart';
import 'package:geoplaceflutter/components/lugar_list_item.dart';
import 'package:geoplaceflutter/models/lugar.dart';
import 'package:geoplaceflutter/services/lugar_service.dart';
import 'package:provider/provider.dart';

import '../providers/lugar_provider.dart';

class LugarList extends StatelessWidget {
  const LugarList({super.key});

  @override
  Widget build(BuildContext context){

    List<Widget> _generateListLugar(List<Lugar> lugares) {
      return lugares.map((lugar) => LugarListItem(lugar)).toList();
    }

    final _lugar = Provider.of<LugarProvider>(context);

    return FutureBuilder<List<Lugar>>(
      future: _lugar.list(), //LugarService().list(),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator(),);
        } else if (snapshot.hasError) {
          return Center(child: Center(child: Text("Erro ao consultar dados: ${snapshot.error}"),),);
        } else if (snapshot.hasData){
          final list = snapshot.data;
          if(list != null && list.isNotEmpty){
            return Expanded(child: ListView(
              children: _generateListLugar(list),
            ),);
          } else {
            return const Center(child: Text("Nenhum Lugar Cadastrado."),);  
          }
        } else {
          return const Center(child: Text("Nenhum Lugar Cadastrado."),);
        }
      },
    );

  }
}