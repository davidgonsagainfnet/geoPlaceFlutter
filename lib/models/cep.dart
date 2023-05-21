class Cep {
  String cep;
  String logradouro;
  String localidade;
  String uf;

  Cep(this.cep,
      this.localidade,
      this.logradouro,
      this.uf);

  Cep.fromJson(Map<String, dynamic> json)
  :cep = json['cep'], 
  logradouro = json['logradouro'],
  localidade = json['localidade'],
  uf = json['uf'];
  
}