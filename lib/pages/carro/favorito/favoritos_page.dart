import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/carro/carros_list_view.dart';
import 'package:carros/pages/carro/favorito/favorito_service.dart';
import 'package:carros/util/text_error.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


// ignore: must_be_immutable
class FavoritosPage extends StatefulWidget {
  @override
  _FavoritosPageState createState() => _FavoritosPageState();
}

class _FavoritosPageState extends State<FavoritosPage>
    with AutomaticKeepAliveClientMixin<FavoritosPage> {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return StreamBuilder<QuerySnapshot>(
      stream: FavoritoService().stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: TextError("Não foi possível buscar os carros"),
          );
        }

        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        List<Carro> carros = snapshot.data.docs.map((DocumentSnapshot document) {
          return Carro.fromMap(document.data());
        }).toList();

        return CarrosListView(carros);
      },
    );
  }
}
