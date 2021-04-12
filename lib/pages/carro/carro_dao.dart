
import 'package:carros/pages/carro/carro.dart';
import 'package:carros/util/sql/dao.dart';

class CarroDAO extends DAO<Carro> {
  @override
  Carro fromMap(Map<String, dynamic> map) {
    return Carro.fromMap(map);
  }

  @override
  // TODO: implement tableName
  String get tableName => "tb_carro";

  Future<List<Carro>> findAllByTipo(String tipo) async {
    List<Carro> carros = await query('select * from $tableName where tipo =? ',[tipo]);
    return carros;
  }
}