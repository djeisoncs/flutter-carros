
import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/carro/favorito/favorito.dart';
import 'package:carros/pages/carro/favorito/favorito_dao.dart';

class FavoritoService {

  static favoritar(Carro carro) async {
    final dao = FavoritoDAO();

    Favorito entity = Favorito.fromCarro(carro);

    final exists = await dao.exists(carro.id);

    if(exists) {
      dao.delete(carro.id);
    } else {
      dao.save(entity);
    }
  }
}