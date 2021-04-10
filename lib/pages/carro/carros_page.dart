import 'package:carros/pages/carro/carro_bloc.dart';
import 'package:carros/pages/carro/carro_tipo.dart';
import 'package:carros/pages/carro/carros_list_view.dart';
import 'package:carros/util/text_error.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CarrosPage extends StatefulWidget {
  CarroTipo tipo;

  CarrosPage(this.tipo);

  @override
  _CarrosPageState createState() => _CarrosPageState();
}

class _CarrosPageState extends State<CarrosPage>
    with AutomaticKeepAliveClientMixin<CarrosPage> {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  final _bloc = CarroBloc();

  CarroTipo get tipo => widget.tipo;

  @override
  void initState() {
    super.initState();

    _bloc.fetch(tipo);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return StreamBuilder(
      stream: _bloc.stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: TextError("Não foi possível buscar os carros"),
            // child: Text(
            //   "Não foi possível buscar os carros",
            //   style: TextStyle(
            //     color: Colors.red,
            //     fontSize: 22,
            //   ),
            // ),
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
    return _bloc.fetch(tipo);
  }

  @override
  void dispose() {
    super.dispose();

    _bloc.dispose();
  }
}
