import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/carro/carro_dao.dart';
import 'package:carros/pages/carro/favorito/favorito.dart';
import 'package:carros/pages/carro/favorito/favorito_dao.dart';
import 'package:provider/provider.dart';

import 'favorito_bloc.dart';

class FavoritoService {

  static Future<bool> favoritar(Carro carro, context) async {
    bool favoritou;
    final dao = FavoritoDAO();

    Favorito entity = Favorito.fromCarro(carro);

    final exists = await dao.exists(carro.id);

    if(exists) {
      dao.delete(carro.id);
      Provider.of<FavoritoBloc>(context, listen: false).fetch();
      favoritou = false;
    } else {
      dao.save(entity);
      Provider.of<FavoritoBloc>(context, listen: false).fetch();
      favoritou = true;
    }

    return favoritou;
  }

  static Future<List<Carro>> getCarros() async {
    return await CarroDAO().query('select * from carro c, favorito f where c.id = f.id ');
  }

  static Future<bool> isFavorito(Carro carro) async {
    final dao = FavoritoDAO();

    return await dao.exists(carro.id);
  }
}