
import 'dart:convert' as convert;
import 'dart:io';

import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/carro/upload_api.dart';
import 'package:carros/util/api_response.dart';
import 'package:carros/util/http_helper.dart' as http;

class CarroApi {

  static Future<List<Carro>> getCarros() async {
    var url = 'https://carros-springboot.herokuapp.com/api/v1/carros';
    // var url = 'https://carros-springboot.herokuapp.com/api/v2/carros';

    var response = await http.get(url);

    String json = response.body;

    return convert.json.decode(json).map<Carro>((map) => Carro.fromMap(map)).toList();
  }

  static Future<List<Carro>> getCarrosPorTipo(String tipo) async {
    var url = 'https://carros-springboot.herokuapp.com/api/v1/carros/tipo/$tipo';
    // var url = 'https://carros-springboot.herokuapp.com/api/v2/carros/tipo/$tipo';

    var response = await http.get(url);

    String json = response.body;

    List<Carro> carros = convert.json.decode(json).map<Carro>((map) => Carro.fromMap(map)).toList();

    return carros;
  }

  static Future<ApiResponse<Carro>> save(Carro c, File image) async {
    try {
      if (image != null) {
        ApiResponse<String> response = await UploadApi.upload(image);

        if (response.ok) {
          c.urlFoto = response.result;
        }
      }

      var url = 'https://carros-springboot.herokuapp.com/api/v1/carros';
      // var url = 'https://carros-springboot.herokuapp.com/api/v2/carros';

      String json = c.toJson();

      if (c.id != null) {
        url += "/${c.id}";
      }

      var response = await(
        c.id == null ? http.post(url, body: json) :
                       http.put(url, body: json)
      );

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        Map mapResponse = convert.json.decode(response.body);

        Carro carro = Carro.fromMap(mapResponse);

        print("Novo carro: ${carro.id}");

        return ApiResponse.ok(result: carro);
      }

      if (response.body == null || response.body.isEmpty) {
        return ApiResponse.error(msg: "Erro não previsto");
      }

      Map mapResponse = convert.json.decode(response.body);
      return ApiResponse.error(msg: mapResponse["error"]);

    } catch(e) {
      print(e);
      return ApiResponse.error(msg: "Erro não previsto");
    }
  }

  static Future<ApiResponse<bool>> delete(Carro carro) async {
    try {
      var url = 'https://carros-springboot.herokuapp.com/api/v1/carros/${carro.id}';
      // var url = 'https://carros-springboot.herokuapp.com/api/v2/carros/${carro.id}';

      var response = await http.delete(url);

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        return ApiResponse.ok(result: true);
      }

      return ApiResponse.error(msg: "Erro não previsto");
    } catch(e) {
      print(e);
      return ApiResponse.error(msg: "Erro não previsto");
    }
  }
}