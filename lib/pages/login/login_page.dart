import 'package:carros/componentes/buttons/app_button.dart';
import 'package:carros/componentes/text/app_text.dart';
import 'package:carros/firebase/firebase_service.dart';
import 'package:carros/pages/carro/home_page.dart';
import 'package:carros/pages/login/cadastro_page.dart';
import 'package:carros/pages/login/login_bloc.dart';
import 'package:carros/util/alert.dart';
import 'package:carros/util/api_response.dart';
import 'package:carros/util/nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _tLogin = TextEditingController();

  final _tSenha = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final _focusSenha = FocusNode();

  final _bloc = LoginBloc();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Carros"),
      ),
      body: _body(),
    );
  }

  _body() {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: <Widget>[
            AppText(
              "Login",
              "Digite o login",
              controller: _tLogin,
              validator: _validateLogin,
              textInputAction: TextInputAction.next,
              nextFocus: _focusSenha,
            ),
            SizedBox(
              height: 10,
            ),
            AppText(
              "Senha",
              "Digite a senha",
              passoword: true,
              controller: _tSenha,
              validator: _validateSenha,
              keyboardType: TextInputType.number,
              focusNode: _focusSenha,
            ),
            SizedBox(
              height: 20,
            ),
            StreamBuilder<bool>(
                stream: _bloc.stream,
                initialData: false,
                builder: (context, snapshot) {
                  return AppButton(
                    "Login",
                    onPressed: _onClickLogin,
                    showProgress: snapshot.data,
                  );
                }),
            Container(
              height: 46,
              margin: EdgeInsets.only(top: 20),
              child: GoogleSignInButton(
                onPressed: _onClickGoogle,
              ),
            ),
            Container(
              height: 46,
              margin: EdgeInsets.only(top: 20),
              child: InkWell(
                onTap: _onClickCadastrar,
                child: Text(
                  "Cadastre-se",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.blue,
                      decoration: TextDecoration.underline),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onClickLogin() async {
    if (!_formKey.currentState.validate()) {
      return;
    }

    String login = _tLogin.text;
    String senha = _tSenha.text;

    _onLogar(await _bloc.login(login, senha));
  }

  String _validateLogin(String value) {
    if (value.isEmpty) {
      return "O digite o login";
    }
    return null;
  }

  String _validateSenha(String value) {
    if (value.isEmpty) {
      return "O digite a senha";
    }
    return null;
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  Future<void> _onClickGoogle() async {
    final service = FirebaseService();

    _onLogar(await service.loginGoogle());
  }

  _onLogar(ApiResponse response) {
    if (response.ok) {
      push(context, HomePage(), replace: true);
    } else {
      dialogAlerta(context, response.msg);
    }
  }

  void _onClickCadastrar() {
    push(context, CadastroPage());
  }
}
