import 'package:carros/main.dart';
import 'package:carros/pages/carro/carros_list_view.dart';
import 'package:carros/util/text_error.dart';
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

    favoritosBloc.fetch();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return StreamBuilder(
      stream: favoritosBloc.stream,
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

        return RefreshIndicator(
          onRefresh: _onRefresh,
          child: CarrosListView(snapshot.data),);
      },
    );
  }

  Future<void> _onRefresh() {
    return favoritosBloc.fetch();
  }
}
