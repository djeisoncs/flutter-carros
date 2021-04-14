import 'package:carros/bloc/simple_bloc.dart';
import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/carro/carro_dao.dart';
import 'package:carros/pages/carro/favorito/favorito_service.dart';


class FavoritoBloc extends SimpleBloc<List<Carro>> {

  final dao = CarroDAO();

  // ignore: missing_return
  Future<List<Carro>> fetch() async {
    try {

      List<Carro> carros = await FavoritoService.getCarros();

      add(carros);

      return carros;
    } catch (e) {
      addError(e);
    }
  }

}