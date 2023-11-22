import 'dart:convert';
import 'package:financass/models/CartaoModel.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

List<Cartao> analisarCartao(String responseBody) {
  final list = jsonDecode(responseBody) as List<dynamic>;
  var cartoes = list.map((e) => Cartao.fromJson(e)).toList();
  return cartoes;
}

Future<List<Cartao>> getCartao({required String ip}) async {
  String stringRota = '${ip}lista-cartao';
  http.Response response = await http.get(Uri.parse(stringRota));

  if (response.statusCode == 200) {
    return compute(analisarCartao, response.body);
  } else {
    throw Exception();
  }
}

Future<String> salvarCartao({
  required String ip,
  required String fechamento,
  required String vencimento,
  required String limite,
  required String juroativo,
  required String multaatraso,
  required String multadiaria,
  required String banco_id,
}) async {
  String stringRota = '${ip}cadastra-cartao';
  http.Response response = await http.post(Uri.parse(stringRota),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'fechamento': fechamento,
        'vencimento': vencimento,
        'limite': limite,
        'juroativo': juroativo,
        'multaatraso': multaatraso,
        'multadiaria': multadiaria,
        'banco_id': banco_id,
      }));

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception();
  }
}
