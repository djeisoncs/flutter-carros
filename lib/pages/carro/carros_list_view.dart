import 'package:cached_network_image/cached_network_image.dart';
import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/carro/carro_page.dart';
import 'package:carros/util/nav.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CarrosListView extends StatelessWidget {
  List<Carro> carros;

  CarrosListView(this.carros);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: carros.length,
        itemBuilder: (context, index) {
          Carro c = carros[index];

          return Container(
            height: 280,
            child: InkWell(
              onTap: () {
                _onClickDetalheCarro(context, c);
              },
              onLongPress: () {
                _onLongClickDetalheCarro(context, c);
              },
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Center(
                          child: CachedNetworkImage(
                        imageUrl: c.urlFoto ??
                            "https://s3-sa-east-1.amazonaws.com/videos.livetouchdev.com.br/luxo/Shelby_Supercars_Ultimate.png",
                        width: 250,
                      )),
                      Text(
                        c.nome ?? "",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 25),
                      ),
                      Text(
                        "descrição...",
                        style: TextStyle(fontSize: 16),
                      ),
                      ButtonBarTheme(
                        data: ButtonBarThemeData(),
                        child: ButtonBar(
                          children: <Widget>[
                            TextButton(
                              child: const Text('DETALHES'),
                              onPressed: () => _onClickDetalheCarro(context, c),
                            ),
                            TextButton(
                              child: const Text('SHARE'),
                              onPressed: () {
                                _onClickSharedCarro(context, c);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  _onClickDetalheCarro(context, Carro c) {
    push(context, CarroPage(c));
  }

  void _onLongClickDetalheCarro(BuildContext context, Carro c) {
    showDialog(context: context, builder: (context) {
      return SimpleDialog(
        title: Text(c.nome),
        children: <Widget>[
          ListTile(
            title: Text("Detalhes"),
            leading: Icon(Icons.directions_car),
            onTap: () {
              pop(context);
              _onClickDetalheCarro(context, c);
            },
          ),
          ListTile(
            title: Text("Share"),
            leading: Icon(Icons.share),
            onTap: () {
              pop(context);
              _onClickSharedCarro(context, c);
            },
          ),
        ],
      );
    });
  }

  void _onClickSharedCarro(BuildContext context, Carro c) {
    print("Share ${c.nome}");
  }
}
