
import 'dart:convert' as convert;

import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/login/usuario.dart';
import 'package:carros/util/api_response.dart';
import 'package:http/http.dart' as http;

class CarroApi {

  static Future<List<Carro>> getCarros() async {
    Usuario usuario = await Usuario.get();

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": usuario.token
    };

    var url = 'https://carros-springboot.herokuapp.com/api/v2/carros';

    var response = await http.get(Uri.parse(url), headers: headers);

    String json = response.body;

    return convert.json.decode(json).map<Carro>((map) => Carro.fromMap(map)).toList();
  }

  static Future<List<Carro>> getCarrosPorTipo(String tipo) async {
    Usuario usuario = await Usuario.get();

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${usuario.token}"
    };

    var url = 'https://carros-springboot.herokuapp.com/api/v2/carros/tipo/$tipo';

    var response = await http.get(Uri.parse(url), headers: headers);

    String json = response.body;

    List<Carro> carros = convert.json.decode(json).map<Carro>((map) => Carro.fromMap(map)).toList();

    return carros;
  }

  static Future<ApiResponse<Carro>> save(Carro c) async {
    try {
      var url = 'https://carros-springboot.herokuapp.com/api/v2/carros';

      Usuario usuario = await Usuario.get();

      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${usuario.token}"
      };

      String json = c.toJson();

      if (c.id != null) {
        url += "/${c.id}";
      }

      var response = await(
        c.id == null ? http.post(Uri.parse(url), body: json, headers: headers) :
                       http.put(Uri.parse(url), body: json, headers: headers)
      );

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        Map mapResponse = convert.json.decode(response.body);

        Carro carro = Carro.fromMap(mapResponse);

        print("Novo carro: ${carro.id}");

        return ApiResponse.ok(carro);
      }

      if (response.body == null || response.body.isEmpty) {
        return ApiResponse.error("Erro não previsto");
      }

      Map mapResponse = convert.json.decode(response.body);
      return ApiResponse.error(mapResponse["error"]);

    } catch(e) {
      print(e);
      return ApiResponse.error("Erro não previsto");
    }
  }
}