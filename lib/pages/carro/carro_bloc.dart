import 'package:carros/bloc/simple_bloc.dart';
import 'package:carros/pages/carro/carro_dao.dart';
import 'package:carros/pages/carro/carro_tipo.dart';
import 'package:carros/util/network.dart';

import 'carro.dart';
import 'carro_api.dart';

class CarroBloc extends SimpleBloc<List<Carro>> {

  Future<List<Carro>> fetch(CarroTipo tipo) async {
    try {
      bool networkOn = await isNetworkOn();
      List<Carro> carros;

      if (networkOn) {
        carros = await CarroApi.getCarrosPorTipo(tipo.getName());
      } else {
       carros = await CarroDAO().findAllByTipo(tipo);
      }

      add(carros);

      return carros;
    } catch (e) {
      addError(e);
    }
  }

}