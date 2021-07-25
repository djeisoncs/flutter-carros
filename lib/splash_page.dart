
import 'package:carros/firebase/firebase_service.dart';
import 'package:carros/pages/carro/home_page.dart';
import 'package:carros/pages/login/login_page.dart';
import 'package:carros/pages/login/usuario.dart';
import 'package:carros/util/nav.dart';
import 'package:carros/util/sql/db_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashPageState();

}

class _SplashPageState extends State<SplashPage> {

  @override
  // ignore: must_call_super
  void initState() {

    Future futureDB = DatabaseHelper.getInstance().db;
    Future futureDelay = Future.delayed(Duration(seconds: 3));
    // Future futureUsuario = Usuario.get();

    Future.wait([futureDB, futureDelay]).then((value) {
      User user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        firebaseUserUid = user.uid;
        push(context, HomePage(), replace: true);
      } else {
        push(context, LoginPage());
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