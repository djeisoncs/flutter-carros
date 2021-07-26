import 'package:carros/componentes/menu/drawer_list_menu_principal.dart';
import 'package:carros/notification/push_notification.dart';
import 'package:carros/pages/carro/carro_form_page.dart';
import 'package:carros/pages/carro/carro_tipo.dart';
import 'package:carros/pages/carro/carros_page.dart';
import 'package:carros/pages/carro/favorito/favoritos_page.dart';
import 'package:carros/util/nav.dart';
import 'package:carros/util/prefs.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin<HomePage> {
  TabController _tabController;
  int _totalNotifications;
  PushNotification _notificationInfo;


  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();

    _initTabs();
  }

  _initTabs() async {
    int tabIdx = await Prefs.getInt("tabIdx");

    _tabController = TabController(length: 4, vsync: this);

    setState(() {
      _tabController.index = tabIdx;
    });

    _tabController.addListener(() {
      Prefs.setInt("tabIdx", _tabController.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Carros"),
        bottom: _tabController == null
            ? null
            : TabBar(
                controller: _tabController,
                tabs: [
                  Tab(
                    text: "Clássicos",
                    icon: Icon(Icons.directions_car),
                  ),
                  Tab(
                    text: "Esportivos",
                    icon: Icon(Icons.directions_car_outlined),
                  ),
                  Tab(
                    text: "Luxo",
                    icon: Icon(Icons.directions_car_sharp),
                  ),
                  Tab(
                    text: "Favorito",
                    icon: Icon(Icons.favorite),
                  ),
                ],
              ),
      ),
      body: _tabController == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : TabBarView(
              controller: _tabController,
              children: [
                CarrosPage(CarroTipo.CLASSICOS),
                CarrosPage(CarroTipo.ESPORTIVOS),
                CarrosPage(CarroTipo.LUXO),
                FavoritosPage(),
              ],
            ),
      drawer: DrawerListMenuPrincipal(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: onClickAddCarro,
      ),
    );
  }

  void onClickAddCarro() {
    push(context, CarroFormPage());
  }

  void registerNotification() async {

    // 3. On iOS, this helps to take the user permissions
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');

      // For handling the received notifications
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        // Parse the message received
        PushNotification notification = PushNotification(
          title: message.notification?.title,
          body: message.notification?.body,
        );

        print("push notificatios ${notification.body}");

        setState(() {
          _notificationInfo = notification;
          _totalNotifications++;
        });
      });
    } else {
      print('User declined or has not accepted permission');
    }
  }
}
