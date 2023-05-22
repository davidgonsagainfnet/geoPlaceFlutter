import 'package:flutter/material.dart';
import 'package:geoplaceflutter/providers/lugar_provider.dart';
import 'package:provider/provider.dart';
import '../models/lugar.dart';

class LugarListItem extends StatelessWidget {
  const LugarListItem(
    this.lugar, {
      super.key,
    });

  final Lugar lugar;

  @override
  Widget build(BuildContext context){
    final _lugar = Provider.of<LugarProvider>(context);
    return ListTile(title: Text(lugar.cidade),);
  }
    
}