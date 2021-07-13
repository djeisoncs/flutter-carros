import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/carro/carro_dao.dart';
import 'package:carros/pages/carro/favorito/favorito.dart';
import 'package:carros/pages/carro/favorito/favorito_dao.dart';
import 'package:carros/pages/carro/favorito/favoritos_model.dart';
import 'package:provider/provider.dart';

class FavoritoService {

  static Future<bool> favoritar(Carro carro, context) async {
    bool favoritou;
    final dao = FavoritoDAO();

    Favorito entity = Favorito.fromCarro(carro);

    final exists = await dao.exists(carro.id);

    if(exists) {
      dao.delete(carro.id);
      Provider.of<FavoritosModel>(context, listen: false).getCarros();
      favoritou = false;
    } else {
      dao.save(entity);
      Provider.of<FavoritosModel>(context, listen: false).getCarros();
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