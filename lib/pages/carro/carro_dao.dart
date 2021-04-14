import 'package:carros/util/sql/base_dao.dart';

import 'carro.dart';
import 'carro_tipo.dart';

class CarroDAO extends BaseDAO<Carro> {
  @override
  String get tableName => "carro";

  @override
  Carro fromMap(Map<String, dynamic> map) {
    return Carro.fromMap(map);
  }

  Future<List<Carro>> findAllByTipo(CarroTipo tipo) async {
    return await query(
        'select * from $tableName where tipo =? ', [tipo.getName()]);
  }
}
