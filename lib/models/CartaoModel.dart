class Cartao {
  int? id;
  int? fechamento;
  int? vencimento;
  double? limite;
  double? juroativo;
  double? multaatraso;
  double? multadiaria;
  int? banco_id;

  Cartao(
      {this.id,
      this.fechamento,
      this.vencimento,
      this.limite,
      this.juroativo,
      this.multaatraso,
      this.multadiaria,
      this.banco_id});

  Cartao.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fechamento = json['fechamento'];
    vencimento = json['vencimento'];
    limite = json['limite'];
    juroativo = json['juroativo'];
    multaatraso = json['multaatraso'];
    multadiaria = json['multadiaria'];
    banco_id = json['banco_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['fechamento'] = fechamento;
    data['vencimento'] = vencimento;
    data['limite'] = limite;
    data['juroativo'] = juroativo;
    data['multaatraso'] = multaatraso;
    data['multadiaria'] = multadiaria;
    data['banco_id'] = banco_id;
    return data;
  }
}
