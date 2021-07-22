import 'package:carros/firebase/firebase_service.dart';
import 'package:carros/pages/login/login_page.dart';
import 'package:carros/pages/login/usuario.dart';
import 'package:carros/util/nav.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DrawerListMenuPrincipal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User user = FirebaseAuth.instance.currentUser;

    return SafeArea(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            Container(
              child: user != null ? _header(user) : Container(),
            ),
            ListTile(
              leading: Icon(Icons.star),
              title: Text("Favoritos"),
              subtitle: Text("mais informações..."),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                print("Item 1");
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text("Ajuda"),
              subtitle: Text("mais informações..."),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                print("Item 1");
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("Logout"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () => _onClickLogout(context),
            )
          ],
        ),
      ),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return SafeArea(
  //     child: Drawer(
  //       child: ListView(
  //         children: <Widget>[
  //           FutureBuilder(
  //             future: Usuario.get(),
  //             builder: (context, snapshot) {
  //               Usuario user = snapshot.data;
  //               return user != null ? _header(user) : Container();
  //             },
  //           ),
  //           ListTile(
  //             leading: Icon(Icons.home),
  //             title: Text(
  //               "Home",
  //               style: TextStyle(
  //                 fontSize: 16,
  //               ),
  //             ),
  //             subtitle: Text("mais informações...."),
  //             trailing: Icon(Icons.arrow_right),
  //             onTap: () {
  //               Navigator.pop(context);
  //             },
  //           ),
  //           ListTile(
  //             leading: Icon(Icons.help),
  //             title: Text(
  //               "Ajuda",
  //               style: TextStyle(
  //                 fontSize: 16,
  //               ),
  //             ),
  //             trailing: Icon(Icons.arrow_right),
  //             onTap: () {
  //               Navigator.pop(context);
  //             },
  //           ),
  //           ListTile(
  //             leading: Icon(Icons.exit_to_app),
  //             title: Text(
  //               "Logout",
  //               style: TextStyle(
  //                 fontSize: 16,
  //               ),
  //             ),
  //             trailing: Icon(Icons.arrow_right),
  //             onTap: () => _onClickLogout(context),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  UserAccountsDrawerHeader _header(User user) {
    return UserAccountsDrawerHeader(
      accountName: Text(user.displayName),
      accountEmail: Text(user.email),
      currentAccountPicture: user.photoURL != null
          ? CircleAvatar(
              backgroundImage: NetworkImage(user.photoURL),
            )
          : FlutterLogo(),
    );
  }

  _onClickLogout(BuildContext context) {
    Usuario.clear();
    FirebaseService().logout();
    Navigator.pop(context);
    push(context, LoginPage(), replace: true);
  }
}
