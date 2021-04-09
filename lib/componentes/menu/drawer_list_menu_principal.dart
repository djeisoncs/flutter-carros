import 'package:carros/pages/login/login_page.dart';
import 'package:carros/pages/login/usuario.dart';
import 'package:carros/util/nav.dart';
import 'package:flutter/material.dart';

class DrawerListMenuPrincipal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            FutureBuilder(
              future: Usuario.get(),
              builder: (context, snapshot) {
                Usuario user = snapshot.data;
                return user != null ? _header(user) : Container();
              },
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text(
                "Home",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              subtitle: Text("mais informações...."),
              trailing: Icon(Icons.arrow_right),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text(
                "Ajuda",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              trailing: Icon(Icons.arrow_right),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text(
                "Logout",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              trailing: Icon(Icons.arrow_right),
              onTap: () => _onClickLogout(context),
            ),
          ],
        ),
      ),
    );
  }

  UserAccountsDrawerHeader _header(Usuario user) {
    return UserAccountsDrawerHeader(
      accountName: Text(user.nome),
      accountEmail: Text(user.email),
      currentAccountPicture: CircleAvatar(
        backgroundImage: NetworkImage(user.urlFoto),
      ),
    );
  }

  _onClickLogout(BuildContext context) {
    Usuario.clear();
    Navigator.pop(context);
    navigate(context, LoginPage(), replace: true);
  }
}
