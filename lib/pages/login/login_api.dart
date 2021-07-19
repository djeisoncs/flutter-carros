import 'dart:convert';

import 'package:carros/pages/login/usuario.dart';
import 'package:carros/util/api_response.dart';
import 'package:http/http.dart' as http;

class LoginApi {

  // ignore: missing_return
  static Future<ApiResponse<Usuario>> login(String login, String senha) async {
    try {
      var url = 'http://carros-springboot.herokuapp.com/api/v2/login';

      Map<String, String> headers = {
        "Content-Type": "application/json"
      };

      String params = json.encode({
        'username': login,
        'password': senha,
      });

      var response = await http.post(Uri.parse(url), body: params, headers: headers);

      Map mapResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        final user = new Usuario.fromJson(mapResponse);

        user.save();

        return ApiResponse.ok(result: user);
      }

      return ApiResponse.error(msg: mapResponse["error"]);
    } catch(error, exception) {
      print("Erro no login $error > $exception");
      ApiResponse.error(msg: "Erro não previsto");
    }
  }
}