import 'package:carros/pages/login/usuario.dart';
import 'package:carros/util/api_response.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<ApiResponse> loginGoogle() async {
    try {
      // Login com o Google
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential.
      final GoogleAuthCredential googleCredential =
          GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Login no Firebase
      UserCredential userCredential =
          await _auth.signInWithCredential(googleCredential);
      User user = userCredential.user;

      // Cria um usuario do app
      final usuario = Usuario(
        nome: user.displayName,
        login: user.email,
        email: user.email,
        urlFoto: user.photoURL,
      );
      usuario.save();

      // Resposta genérica
      return ApiResponse.ok();
    } catch (error) {
      print("Firebase error $error");
      return ApiResponse.error(msg: "Não foi possível fazer o login");
    }
  }

  Future<ApiResponse> login(String email, String senha) async {
    try {
      // Login no Firebase
      UserCredential userCredential = await _auth
          .signInWithEmailAndPassword(email: email, password: senha);
      User user = userCredential.user;

      // Cria um usuario do app
      final usuario = Usuario(
        nome: user.displayName ?? "Usuario teste",
        login: user.email ?? "email@teste.com",
        email: user.email ?? "email@teste.com",
        urlFoto: user.photoURL ?? null,
      );
      usuario.save();

      // Resposta genérica
      return ApiResponse.ok();
    } catch (error) {
      print("Firebase error $error");
      return ApiResponse.error(msg: "Não foi possível fazer o login");
    }
  }

  Future<ApiResponse> cadastrar(String nome, String email, String senha) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: senha);

      final User user = _auth.currentUser;


      user.updatePhotoURL(
          "https://s3-sa-east-1.amazonaws.com/livetouch-temp/livrows/foto.png");
      user.updateDisplayName(nome);

      user.reload();


      // final User currentUser = _auth.currentUser;
      //
      // currentUser.updateProfile(photoURL: "https://s3-sa-east-1.amazonaws.com/livetouch-temp/livrows/foto.png");
      // currentUser.reload();

    //   currentUser.updateProfile({
    //     displayName: "Jane Q. User",
    //     photoURL: "https://example.com/jane-q-user/profile.jpg"
    //   }).then(() => {
    //     // Update successful
    //     // ...
    //   }).catch((error) => {
    // // An error occurred
    // // ...
    // });

    // _auth.currentUser.reload();
      return ApiResponse.ok(msg:"Usuário criado com sucesso");
    } catch(error) {
      print(error);

      if(error is PlatformException) {
        print("Error Code ${error.code}");

        return ApiResponse.error(msg: "Erro ao criar um usuário.\n\n${error.message}");
      }

      return ApiResponse.error(msg: "Não foi possível criar um usuário.");
    }
    
  }

  Future<void> logout() async {
    FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }
}
