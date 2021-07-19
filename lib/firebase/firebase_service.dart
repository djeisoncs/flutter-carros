import 'package:carros/pages/login/usuario.dart';
import 'package:carros/util/api_response.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseService {

  Future<ApiResponse> loginGoogle() async {
    try {
      // Login com o Google
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create a new credential.
      final GoogleAuthCredential googleCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Login no Firebase
      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(googleCredential);
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

  Future<void> logout() async {
    FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }
}
