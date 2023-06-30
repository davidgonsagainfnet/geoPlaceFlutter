import 'package:api_via_cep_pk/api_via_cep_pk.dart';
import 'package:api_via_cep_pk/models/cep.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){

  test('Teste de api de cep via pacote', () async {
      final apiCep = CepService();

      Future<Cep> cep = apiCep.listCep("05882050");

      String rua = '';
      String localidade = "";
      String uf = "";

      await cep.then((cep) {
        rua = cep.logradouro;
        localidade = cep.localidade;
        uf = cep.uf;
      });

      expect(rua, 'Rua Lusitano Soares');
      expect(localidade, 'São Paulo');
      expect(uf, 'SP');
  });

}