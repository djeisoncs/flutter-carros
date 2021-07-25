import 'package:carros/firebase/firebase_service.dart';
import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/carro/carro_dao.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FavoritoService {

  get _users => FirebaseFirestore.instance.collection("users");
  get _carros => _users.doc(firebaseUserUid).collection("carros");

  // CollectionReference get _carros => FirebaseFirestore.instance.collection("carros");

  Stream<QuerySnapshot> get stream => _carros.snapshots();

  Future<bool> favoritar(Carro carro) async {
    bool favoritou;

    DocumentReference docRef = _carros.doc("${carro.id}");

    DocumentSnapshot doc = await docRef.get();

    if(doc.exists) {
      docRef.delete();
      favoritou = false;
    } else {
      docRef.set(carro.toMap());
      favoritou = true;
    }

    return favoritou;
  }

  // Future<bool> favoritar(Carro carro, context) async {
  //   bool favoritou;
  //   final dao = FavoritoDAO();
  //
  //   Favorito entity = Favorito.fromCarro(carro);
  //
  //   final exists = await dao.exists(carro.id);
  //
  //   if(exists) {
  //     dao.delete(carro.id);
  //     Provider.of<FavoritoBloc>(context, listen: false).fetch();
  //     favoritou = false;
  //   } else {
  //     dao.save(entity);
  //     Provider.of<FavoritoBloc>(context, listen: false).fetch();
  //     favoritou = true;
  //   }
  //
  //   return favoritou;
  // }

  Future<List<Carro>> getCarros() async {
    return await CarroDAO().query('select * from carro c, favorito f where c.id = f.id ');
  }

  Future<bool> isFavorito(Carro carro) async {
    DocumentSnapshot doc = await _carros.doc("${carro.id}").get();

    return doc.exists;
  }

  // static Future<bool> isFavorito(Carro carro) async {
  //   final dao = FavoritoDAO();
  //
  //   return await dao.exists(carro.id);
  // }
}