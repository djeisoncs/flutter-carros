

import 'package:carros/pages/carro/favorito/favorito.dart';
import 'package:carros/util/sql/base_dao.dart';

class FavoritoDAO extends BaseDAO<Favorito> {

  @override
  Favorito fromMap(Map<String, dynamic> map) {
    return Favorito.fromMap(map);
  }

  @override
  String get tableName => "favorito";
}