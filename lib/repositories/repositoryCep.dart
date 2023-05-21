import 'package:http/http.dart' as http;

abstract class RepositoryCep {
  final _baseUrlCep = "https://viacep.com.br/ws/";

  Future<http.Response> listCep(String cep){
    final uri = Uri.parse("$_baseUrlCep/$cep/json");
    return http.get(uri);
  }

}