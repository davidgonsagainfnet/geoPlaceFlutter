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

  Lugar(this.longitude, this.latitude, this.cep, this.rua, this.cidade, this.estado, this.descricao, this.status);

  Lugar.fromJson(Map<String, dynamic> json): 
      id      = json['id'],
      longitude = json['longitude'],
      latitude  = json['latitude'],
      cep       = json['cep'],
      rua       = json['rua'],
      cidade    = json['cidade'],
      estado    = json['estado'],
      descricao = json['descricao'],
      status    = json['status'];

  Map<String, dynamic> toJson() => {
    'longitude': longitude,
    'latitude' : latitude,
    'cep'      : cep,
    'rua'      : rua,
    'cidade'   : cidade,
    'estado'   : estado,
    'descricao': descricao,
    'status'   : status
  };

  static List<Lugar> listFromJson(Map<String, dynamic> json){
    List<Lugar> lugar = [];
    json.forEach((key, value) {
      Map<String, dynamic> item = {"id": key, ...value};
      lugar.add(Lugar.fromJson(item));
    });
    return lugar;
  }
}