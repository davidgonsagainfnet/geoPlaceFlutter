import 'package:flutter/material.dart';
import 'package:geoplaceflutter/providers/lugar_provider.dart';
import 'package:geoplaceflutter/routes/route_paths.dart';
import 'package:provider/provider.dart';
import '../models/lugar.dart';

class LugarListItem extends StatelessWidget {
  const LugarListItem(
    this.lugar, {
      super.key,
    });

  final Lugar lugar;

  Color _statusCard(int id){
      switch(id){
        case 1: return Colors.green;
        case 2: return Colors.blue;
        default: return Colors.red;
      }
  }

  void _showConfirmationDialog(BuildContext context, String id) {
    
  }

  @override
  Widget build(BuildContext context){
    final _lugar = Provider.of<LugarProvider>(context);
    return Container(color: _statusCard(lugar.status), 
                          child: ListTile(title: Text("${lugar.cidade} - ${lugar.estado}   LT/LG (${lugar.latitude} - ${lugar.longitude})"), 
                              subtitle: Text(lugar.descricao), 
                              trailing: Row(mainAxisSize: MainAxisSize.min, 
                                              children: [IconButton(icon: Image.asset("assets/edit.png"), onPressed: () {
                                                Navigator.pushNamed(context, RoutePaths.CADASTRO, arguments: lugar);
                                              },),
                                                         const SizedBox(width: 1),
                                                         IconButton(icon: Image.asset("assets/lixeira.png"), onPressed: () {  
                                                              showDialog(
                                                                      builder: (BuildContext context) {
                                                                        return AlertDialog(
                                                                          title: const Text('Confirmação'),
                                                                          content: const Text('Você deseja realmente excluir este item?'),
                                                                          actions: [
                                                                            TextButton(
                                                                              child: const Text('Não'),
                                                                              onPressed: () {
                                                                                Navigator.of(context).pop(); // Fecha o diálogo
                                                                              },
                                                                            ),
                                                                            TextButton(
                                                                              child: const Text('Sim'),
                                                                              onPressed: () {
                                                                                _lugar.removeItem(lugar.id!);
                                                                                Navigator.of(context).pop(); // Fecha o diálogo
                                                                              },
                                                                            ),
                                                                          ],
                                                                        );
                                                                      }, context: context,
                                                              );
                                                         },)],
                              ),
                          ),
                     );
  }
    
}