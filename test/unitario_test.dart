import 'package:flutter_test/flutter_test.dart';
import 'package:geoplaceflutter/models/cep.dart';
import 'package:geoplaceflutter/models/formatcep.dart';
import 'package:geoplaceflutter/services/cep_service.dart';

void main(){
  test('Teste de api de cep', () async {
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

  test('Formata cep', () {
      final cepFormat = FormatCep();
      expect(cepFormat.formata('05882-050'), '05882050');
  });

}