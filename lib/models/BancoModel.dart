class Banco {
  int? id;
  String? banco;
  String? agencia;
  String? conta;
  String? infosave;

  Banco({this.id, this.banco});

  Banco.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    banco = json['banco'];
    agencia = json['agencia'];
    conta = json['conta'];
    infosave = json['infosave'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['banco'] = banco;
    data['agencia'] = agencia;
    data['conta'] = conta;
    data['infosave'] = infosave;
    return data;
  }
}
