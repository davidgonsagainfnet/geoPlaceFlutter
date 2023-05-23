import 'dart:convert';

import 'package:geoplaceflutter/models/lugar.dart';
import 'package:geoplaceflutter/repositories/lugar/lugar_repository.dart';
import 'package:http/http.dart';

class LugarService {
  final LugarRepository _lugarRepository = LugarRepository();

  Future<List<Lugar>> list() async{
    try{
      Response response = await _lugarRepository.list();
      Map<String, dynamic> json = jsonDecode(response.body);
      return Lugar.listFromJson(json);
    } catch (err) {
      print(err);
      throw Exception("Problema ao consultar lista.");
    }
  }

  Future<String> insert(Lugar lugar)async{
    try{
      String json = jsonEncode(lugar.toJson());
      Response response = await _lugarRepository.insert(json);
      return jsonDecode(response.body) as String;
    } catch (err){
      print(err);
      throw Exception("Problema ao inserir registro.");
    }
  }

  Future<Response> delete(String idLugar) async{
    try{
      return await _lugarRepository.delete(idLugar.toString());
    } catch (err){
      print(err);
      throw Exception("Problema ao excluir registro.");
    }
  }
}