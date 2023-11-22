import 'dart:convert';

import 'package:financass/models/BancoModel.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

List<Banco> analisarBanco(String reponseBody) {
  final list = jsonDecode(reponseBody) as List<dynamic>;
  var bancos = list.map((e) => Banco.fromJson(e)).toList();
  return bancos;
}

Future<List<Banco>> getBanco({required String ip}) async {
  String stringRota = '${ip}lista-banco';
  http.Response response = await http.get(Uri.parse(stringRota));

  if (response.statusCode == 200) {
    return compute(analisarBanco, response.body);
  } else {
    throw Exception();
  }
}

Future<String> salvarBanco(
    {required String ip,
    required String banco,
    required String conta,
    required String agencia,
    required double saldo}) async {
  String stringRota = '${ip}cadastrar-banco';
  http.Response response = await http.post(
    Uri.parse(stringRota),
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      'banco': banco,
      'agencia': agencia,
      'conta': conta,
      'saldo': saldo,
    }),
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception();
  }
}
