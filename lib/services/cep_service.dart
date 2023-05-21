import 'dart:convert';

import 'package:geoplaceflutter/models/cep.dart';
import 'package:geoplaceflutter/repositories/cep/cep_repository.dart';
import 'package:http/http.dart';

class CepService {
  final CepRepository _cepRepository = CepRepository();

  Future<Cep> listCep(String cep) async{
    try {
      Response response = await _cepRepository.listCep(cep);
      Map<String, dynamic> json = jsonDecode(response.body);
      return Cep.fromJson(json);
    } catch (err) {
      throw Exception("Problema na busca de cep.");
    }
  }
}