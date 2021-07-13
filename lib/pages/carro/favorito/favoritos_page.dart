import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/carro/carros_list_view.dart';
import 'package:carros/pages/carro/favorito/favoritos_model.dart';
import 'package:carros/util/text_error.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

    Provider.of<FavoritosModel>(context, listen: false).getCarros();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    FavoritosModel model = Provider.of<FavoritosModel>(context);

    List<Carro> carros = model.carros;

    if (carros.isEmpty) {
      return Center(
        child: Text(
          "Nenhum carro nos favoritos",
          style: TextStyle(fontSize: 20),
        ),
      );
    }
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: CarrosListView(carros),
    );
  }

  Future<void> _onRefresh() {
    return Provider.of<FavoritosModel>(context, listen: false).getCarros();
  }
}
