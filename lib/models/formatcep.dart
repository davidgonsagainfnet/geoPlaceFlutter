class FormatCep {

  String formata(String cep){
    return cep.replaceAll(RegExp(r'[^0-9]'), '');
  }

}