import 'package:carros/firebase/firebase_service.dart';
import 'package:carros/pages/carro/home_page.dart';
import 'package:carros/pages/login/login_page.dart';
import 'package:carros/util/alert.dart';
import 'package:carros/util/nav.dart';
import 'package:flutter/material.dart';

class CadastroPage extends StatefulWidget {
  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final _tNome = TextEditingController();
  final _tEmail = TextEditingController();
  final _tSenha = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var _progress = false;

  @override
  void initState() => super.initState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Cadastro"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: _body(context),
      ),
    );
  }

  _body(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          TextFormField(
            controller: _tNome,
            validator: _validatorNome,
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Colors.blue,
              fontSize: 22,
            ),
            decoration: InputDecoration(
              labelText: "Nome",
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: 22,
              ),
              hintText: "Digite seu nome",
              hintStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
          TextFormField(
            controller: _tEmail,
            validator: _validatorEmail,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.blue,
              fontSize: 22,
            ),
            decoration: InputDecoration(
              labelText: "E-mail",
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: 22,
              ),
              hintText: "Digite seu email",
              hintStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
          TextFormField(
            controller: _tSenha,
            validator: _validatorSenha,
            obscureText: true,
            keyboardType: TextInputType.number,
            style: TextStyle(
              color: Colors.blue,
              fontSize: 22,
            ),
            decoration: InputDecoration(
              labelText: "Senha",
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: 22,
              ),
              hintText: "Digite a sua senha",
              hintStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
          Container(
            height: 46,
            margin: EdgeInsets.only(top: 20),
            child: ElevatedButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              child: _progress
                  ? Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Text(
                      "Cadastrar",
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
              onPressed: () {
                _onClickCadastrar(context);
              },
            ),
          ),
          Container(
            height: 46,
            margin: EdgeInsets.only(top: 20),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              child: Text(
                "Cancelar",
                style: TextStyle(color: Colors.blue, fontSize: 22),
              ),
              onPressed: () {
                _onClickCancelar(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  String _validatorNome(String value) {
    if (value.isEmpty) {
      return "O digite o nome";
    }
    return null;
  }

  String _validatorEmail(String value) {
    if (value.isEmpty) {
      return "O digite o e-mail";
    }
    return null;
  }

  String _validatorSenha(String value) {
    if (value.isEmpty) {
      return "O digite a senha";
    }
    return null;
  }

  _onClickCadastrar(BuildContext context) async {
    String nome = _tNome.text;
    String email = _tEmail.text;
    String senha = _tSenha.text;

    if (!_formKey.currentState.validate()) {
      return;
    }

    setState(() {
      _progress = true;
    });

    final service = FirebaseService();
    final response = await service.cadastrar(nome, email, senha);

    if (response.ok) {
      push(context, HomePage(), replace: true);
    } else {
      dialogAlerta(context, response.msg);
    }

    setState(() {
      _progress = false;
    });
  }

  void _onClickCancelar(BuildContext context) {
    push(context, LoginPage(), replace: true);
  }
}
