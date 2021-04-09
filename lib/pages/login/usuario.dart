import 'dart:convert' as convert;

import 'package:carros/util/prefs.dart';

class Usuario {
  String login;
  String nome;
  String email;
  String token;
  String urlFoto;

  List<String> roles;

  Usuario.fromJson(Map<String, dynamic> map)
      : this.login = map["login"],
        this.nome = map["nome"],
        this.email = map["email"],
        this.token = map["token"],
        this.urlFoto = map["urlFoto"],
        this.roles = map["roles"] != null
            ? map["roles"].cast<String>()
            : null;


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["login"] = this.login;
    data["nome"] = this.nome;
    data["email"] = this.email;
    data["token"] = this.token;
    data["roles"] = this.roles;
    data["urlFoto"] = this.urlFoto;
    return data;
  }

  @override
  String toString() {
    return 'Usuario{login: $login, nome: $nome, email: $email, token: $token, roles: $roles}';
  }

  save() {
    Prefs.setString("user.prefs", convert.json.encode(toJson()));
  }

  static clear() {
    Prefs.setString("user.prefs", "");
  }

  static Future<Usuario> get() async {
    String json = await Prefs.getString("user.prefs");

    if (json.isEmpty) {
      return null;
    }

    return Usuario.fromJson(convert.json.decode(json));
  }
}
