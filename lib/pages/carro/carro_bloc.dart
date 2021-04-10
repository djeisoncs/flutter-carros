import 'package:carros/bloc/simple_bloc.dart';
import 'package:carros/pages/carro/carro_tipo.dart';

import 'carro.dart';
import 'carro_api.dart';

class CarroBloc extends SimpleBloc<List<Carro>> {

  Future<List<Carro>> fetch(CarroTipo tipo) async {
    try {
      List<Carro> carros = await CarroApi.getCarrosPorTipo(tipo.getName());

      add(carros);

      return carros;
    } catch (e) {
      addError(e);
    }
  }

}