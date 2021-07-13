import 'package:carros/pages/carro/favorito/favorito_bloc.dart';
import 'package:carros/splash_page.dart';
import 'package:flutter/material.dart';

final favoritosBloc = FavoritoBloc();

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashPage(),
    );
  }
}
