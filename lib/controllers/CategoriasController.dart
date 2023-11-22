import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:financass/models/CategoriasModel.dart';

List<Categorias> analisarCategroais(String responseBody) {
  final list = jsonDecode(responseBody) as List<dynamic>;
  var categorias = list.map((e) => Categorias.fromJson(e)).toList();
  return categorias;
}

Future<List<Categorias>> getCategorias({required String ip}) async {
  String stringRota = '${ip}lista-categoria';
  http.Response response = await http.get(Uri.parse(stringRota));

  if (response.statusCode == 200) {
    return compute(analisarCategroais, response.body);
  } else {
    throw Exception();
  }
}

Future<String> salvarCategorias(
    {required String ip, required String categoria}) async {
  String stringRota = '${ip}cadastrar-categoria';
  http.Response response = await http.post(Uri.parse(stringRota),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'categoria': categoria,
      }));

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception();
  }
}
