
import 'package:carros/pages/carro/home_page.dart';
import 'package:carros/pages/login/login_page.dart';
import 'package:carros/pages/login/usuario.dart';
import 'package:carros/util/nav.dart';
import 'package:carros/util/sql/db_helper.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashPageState();

}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {

    Future futureDB = DatabaseHelper.getInstance().db;
    Future futureDelay = Future.delayed(Duration(seconds: 15));
    Future futureUsuario = Usuario.get();

    Future.wait([futureDB, futureDelay, futureUsuario]).then((value) {
      Usuario user = value[2];

      if (user != null) {
        navigate(context, HomePage(), replace: true);
      } else {
        navigate(context, LoginPage());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[200],
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

}