import 'package:flutter/widgets.dart';
import 'package:geoplaceflutter/models/lugar.dart';
import 'package:geoplaceflutter/services/lugar_service.dart';
import 'package:http/http.dart';

class LugarProvider with ChangeNotifier {
  List<Lugar> itens = [];
  var servico = LugarService();

  Future<List<Lugar>> list() async {
    if(itens.isEmpty){
      itens = await servico.list();
    }
    return itens;
  }

  void removeItem(String idItem) async {
    final isApagado = await servico.delete(idItem);
    if(isApagado){
      itens.removeWhere((item) => item.id == idItem);
      notifyListeners();
    }
    
  }

}