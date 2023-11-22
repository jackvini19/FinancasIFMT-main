class Tipopagas {
  int? id;
  String? tipo;

  Tipopagas({this.id, this.tipo});

  Tipopagas.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tipo = json['tipo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['tipo'] = tipo;
    return data;
  }
}
