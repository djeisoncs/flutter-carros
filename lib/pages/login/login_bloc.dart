
import 'dart:async';

import 'package:carros/bloc/boolean_bloc.dart';
import 'package:carros/firebase/firebase_service.dart';
import 'package:carros/pages/login/usuario.dart';
import 'package:carros/util/api_response.dart';

import 'login_api.dart';

class LoginBloc extends BooleanBloc {

  // Future<ApiResponse<Usuario>> login(String login, String senha) async {
  Future<ApiResponse> login(String login, String senha) async {
    add(true);

    // ApiResponse response = await LoginApi.login(login, senha);

    ApiResponse response = await FirebaseService().login(login, senha);

    add(false);

    return response;
  }
}