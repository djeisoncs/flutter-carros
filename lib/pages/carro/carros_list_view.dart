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

          return Card(
            color: Colors.grey[100],
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: CachedNetworkImage(
                      imageUrl: c.urlFoto ??
                          "https://s3-sa-east-1.amazonaws.com/videos.livetouchdev.com.br/luxo/Shelby_Supercars_Ultimate.png",
                      width: 250,
                    )
                  ),
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
                            /* ... */
                          },
                        ),
                      ],
                    ),
                  ),
                ],
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
}
