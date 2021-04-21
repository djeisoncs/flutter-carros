import 'package:cached_network_image/cached_network_image.dart';
import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/carro/carro_form_page.dart';
import 'package:carros/pages/carro/favorito/favorito_service.dart';
import 'package:carros/pages/carro/loripsum_bloc.dart';
import 'package:carros/util/nav.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CarroPage extends StatefulWidget {
  Carro carro;

  CarroPage(this.carro);

  @override
  _CarroPageState createState() => _CarroPageState();
}

class _CarroPageState extends State<CarroPage> {
  final _bloc = LoripsumBloc();

  Carro get carro => widget.carro;

  Color color = Colors.grey;

  @override
  void initState() {
    super.initState();

    FavoritoService.isFavorito(carro).then((favorito) {
      setState(() {
        color = favorito ? Colors.red : Colors.grey;
      });
    });

    _bloc.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(carro.nome),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.place),
            onPressed: _onClickMapa,
          ),
          IconButton(
            icon: Icon(Icons.videocam),
            onPressed: _onClickVideo,
          ),
          PopupMenuButton<String>(
            onSelected: _onClickPopupMenu,
            itemBuilder: (context) {
              return [
                PopupMenuItem(value: "Editar", child: Text("Editar")),
                PopupMenuItem(value: "Deletar", child: Text("Deletar")),
                PopupMenuItem(value: "Share", child: Text("Share")),
              ];
            },
          ),
        ],
      ),
      body: _body(),
    );
  }

  _body() {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView(
        children: <Widget>[
          CachedNetworkImage(imageUrl: widget.carro.urlFoto ??
              "https://s3-sa-east-1.amazonaws.com/videos.livetouchdev.com.br/luxo/Shelby_Supercars_Ultimate.png",),
          _bloco1(),
          Divider(),
          _bloco2(),
        ],
      ),
    );
  }

  Row _bloco1() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              carro.nome,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              carro.tipo,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
        Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.favorite,
                color: color,
                size: 40,
              ),
              onPressed: _onClickFavorito,
            ),
            IconButton(
              icon: Icon(
                Icons.share,
                size: 40,
              ),
              onPressed: _onClickShare,
            ),
          ],
        ),
      ],
    );
  }

  void _onClickMapa() {}

  void _onClickVideo() {}

  _onClickPopupMenu(String value) {
    switch (value) {
      case "Editar":
        push(context, CarroFormPage(carro: carro));
        break;
      case "Deletar":
        print("Deletar!!!");
        break;
      case "Share":
        print("Share!!!");
        break;
    }
  }

  void _onClickFavorito() async {
    bool favoritou = await FavoritoService.favoritar(carro);

    setState(() {
      color = favoritou ? Colors.red : Colors.grey;
    });
  }

  void _onClickShare() {}

  _bloco2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          carro.descricao,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 20,
        ),
        StreamBuilder<String>(
            stream: _bloc.stream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Text(
                snapshot.data,
                style: TextStyle(
                  fontSize: 16,
                ),
              );
            }),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();

    _bloc.dispose();
  }
}
