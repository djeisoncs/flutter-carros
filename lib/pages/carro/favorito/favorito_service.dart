
import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/carro/carro_dao.dart';
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

  static Future<List<Carro>> getCarros() async {
    return await CarroDAO().query('select * from carro c, favorito f where c.id = f.id ');
  }
}