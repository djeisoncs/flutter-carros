import 'package:carros/bloc/simple_bloc.dart';
import 'package:carros/pages/carro/loripsum_api.dart';

class LoripsumBloc extends SimpleBloc<String> {

  String lorim;

  fetch() async {
    try {
      String s = lorim ?? await LoripsumApi.getLoripsum();

      lorim = s;

      add(s);
    } catch (e) {
      addError(e);
    }
  }

}