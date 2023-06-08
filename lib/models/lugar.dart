class Lugar {
  String? id;
  double longitude;
  double latitude;
  String cep;
  String rua;
  String cidade;
  String estado;
  String descricao;
  int status;
  String idUser;

  Lugar(this.longitude, this.latitude, this.cep, this.rua, this.cidade, this.estado, this.descricao, this.status, this.idUser);

  Lugar.fromJson(String this.id, Map<String, dynamic> json): 
      longitude = json['longitude'],
      latitude  = json['latitude'],
      cep       = json['cep'],
      rua       = json['rua'],
      cidade    = json['cidade'],
      estado    = json['estado'],
      descricao = json['descricao'],
      status    = json['status'],
      idUser    = json['idUser'];

  Map<String, dynamic> toJson() => {
    'longitude': longitude,
    'latitude' : latitude,
    'cep'      : cep,
    'rua'      : rua,
    'cidade'   : cidade,
    'estado'   : estado,
    'descricao': descricao,
    'status'   : status,
    'idUser'   : idUser,
  };
}