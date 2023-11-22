class Categorias {
  int? id;
  String? categoria;

  Categorias({this.id, this.categoria});

  Categorias.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoria = json['categoria'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['categoria'] = categoria;
    return data;
  }
}
