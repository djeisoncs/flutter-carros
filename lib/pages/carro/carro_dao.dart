
import 'package:carros/pages/carro/carro.dart';
import 'package:carros/util/sql/dao.dart';

class CarroDAO extends DAO<Carro> {
  @override
  Carro fromMap(Map<String, dynamic> map) {
    // TODO: implement fromMap
    throw UnimplementedError();
  }

  @override
  // TODO: implement tableName
  String get tableName => throw UnimplementedError();

}