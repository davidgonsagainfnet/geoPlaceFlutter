import 'dart:io';

import 'package:geoplaceflutter/models/lugar.dart';
import 'package:geoplaceflutter/repositories/lugar/lugar_repository.dart';
import 'package:path/path.dart';

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

  Future<String> insert(Lugar lugar, File? file)async{
    try{
      final response = await _lugarRepository.insert(lugar.toJson());
      if(file != null){
        await _lugarRepository.uploadImagem("${response.id}${extension(file.path)}", file);
      }
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

  Future<String> editar(String id, Lugar lugar, File? file) async{
    try{
      await _lugarRepository.update(id, lugar.toJson());
      if(file != null){
        await _lugarRepository.uploadImagem("$id${extension(file.path)}", file);
      }
      return "";
    } catch (err){
      print(err);
      throw Exception("Problema ao editar registro.");
    }
  }
}