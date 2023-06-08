import 'dart:convert';

import 'package:geoplaceflutter/models/lugar.dart';
import 'package:geoplaceflutter/repositories/lugar/lugar_repository.dart';
import 'package:http/http.dart';

class LugarService {
  final LugarRepository _lugarRepository = LugarRepository();

  Future<List<Lugar>> list() async{
    try{
      final List<Lugar> list = [];
      final response = await _lugarRepository.list();
      final docs = response.docs;
      
      for(var doc in docs){
        list.add(Lugar.fromJson(doc.id, doc.data()));
      }
      
      return list;
    } catch (err) {
      print(err);
      throw Exception("Problema ao consultar lista.");
    }
  }

  Future<String> insert(Lugar lugar)async{
    try{
      final response = await _lugarRepository.insert(lugar.toJson());
      return response.id;
    } catch (err){
      print(err);
      throw Exception("Problema ao inserir registro.");
    }
  }

  Future<bool> delete(String idLugar) async{
    try{
      await _lugarRepository.delete(idLugar.toString());
      return true;
    } catch (err){
      print(err);
      throw Exception("Problema ao excluir registro.");
    }
  }

  Future<String> editar(String id, Lugar lugar) async{
    try{
      await _lugarRepository.update(id, lugar.toJson());
      return "";
    } catch (err){
      print(err);
      throw Exception("Problema ao editar registro.");
    }
  }
}