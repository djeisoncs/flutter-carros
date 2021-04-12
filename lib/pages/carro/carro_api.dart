
import 'dart:convert' as convert;

import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/login/usuario.dart';
import 'package:http/http.dart' as http;

class CarroApi {

  static Future<List<Carro>> getCarros() async {
    Usuario usuario = await Usuario.get();

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": usuario.token
    };

    var url = 'https://carros-springboot.herokuapp.com/api/v2/carros';

    var response = await http.get(url, headers: headers);

    String json = response.body;

    return convert.json.decode(json).map<Carro>((map) => Carro.fromMap(map)).toList();
  }

  static Future<List<Carro>> getCarrosPorTipo(String tipo) async {
    Usuario usuario = await Usuario.get();

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${usuario.token}"
    };

    // var url = 'https://carros-springboot.herokuapp.com/api/v1/carros/tipo/$tipo';
    var url = 'https://carros-springboot.herokuapp.com/api/v2/carros/tipo/$tipo';

    // var response = await http.get(url);
    var response = await http.get(url, headers: headers);

    String json = response.body;

    return convert.json.decode(json).map<Carro>((map) => Carro.fromMap(map)).toList();
  }
}