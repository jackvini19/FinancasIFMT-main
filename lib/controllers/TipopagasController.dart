import 'dart:convert';

import 'package:financass/models/TipopagasModel.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

List<Tipopagas> analisarTipopagas(String responseBody) {
  final list = jsonDecode(responseBody) as List<dynamic>;
  var tipopagas = list.map((e) => Tipopagas.fromJson(e)).toList();
  return tipopagas;
}

Future<List<Tipopagas>> getTipopagas({required String ip}) async {
  String stringRota = '${ip}lista-tipopaga';
  http.Response response = await http.get(Uri.parse(stringRota));

  if (response.statusCode == 200) {
    return compute(analisarTipopagas, response.body);
  } else {
    throw Exception();
  }
}

Future<String> salvarTipopagas(
    {required String ip, required String tipo}) async {
  String stringRota = '${ip}cadastrar-tipopaga';
  http.Response response = await http.post(Uri.parse(stringRota),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'tipo': tipo,
      }));

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception();
  }
}
