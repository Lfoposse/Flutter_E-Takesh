import 'dart:async';

import 'package:etakesh_client/DAO/Presenters/LoginPresenter.dart';
import 'package:etakesh_client/Database/DatabaseHelper.dart';
import 'package:etakesh_client/Models/clients.dart';
import 'package:etakesh_client/Utils/Loading.dart';
import 'package:etakesh_client/pages/courses_page.dart';
import 'package:etakesh_client/pages/paiements_page.dart';
import 'package:etakesh_client/pages/parameters_page.dart';
import 'package:etakesh_client/pages/tarifs_page.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  State createState() => HomePageState();
}

class HomePageState extends State<HomePage> implements LoginContract {
  LoginPresenter _presenter;
  int stateIndex;
  Login2 login;
  Client1 client;
  HomePageState() {
    _presenter = new LoginPresenter(this);
  }

  @override
  void initState() {
    DatabaseHelper().getUser().then((Login2 l) {
      if (l != null) {
        print("USER " + l.userId.toString());
        login = l;
        _presenter.detailClient(l.userId, l.token);
      }
    });
    stateIndex = 0;
    super.initState();
  }

  Completer<GoogleMapController> _controller = Completer();

  static const LatLng _center = const LatLng(4.521563, 9.677433);

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    switch (stateIndex) {
      case 0:
        return ShowLoadingView();
      case 1:
        return ShowConnectionErrorView(_onRetryClick);
      case 2:
        return ShowLoadingErrorView(_onRetryClick);

      default:
        return new Container(
            child: new Stack(fit: StackFit.expand, children: <Widget>[
          new Scaffold(
            appBar: new AppBar(
              elevation: 1.0,
//          backgroundColor: const Color(0xFFB4C56C).withOpacity(0.5),
              backgroundColor: const Color(0xFFFFFFFF).withOpacity(0.8),
//          backgroundColor: Colors.transparent.withOpacity(1.0),
              iconTheme: IconThemeData(color: Colors.black),
              title: Text(
                "E-Takesh",
                style: TextStyle(color: Colors.black),
              ),
            ),
//        backgroundColor: Colors.transparent,
            drawer: new Drawer(
                child: new ListView(
              children: <Widget>[
                new DrawerHeader(
                  child: Padding(
                    padding: EdgeInsets.only(top: 15.0, bottom: 10.0),
                    child: ListTile(
                      leading: new CircleAvatar(
                        child: new Image.asset("assets/images/avatar.png",
                            width: 30.0, height: 30.0),
                        radius: 32.0,
                        backgroundColor: Colors.white,
                      ),
                      title: new Text(client.username + " " + client.lastname,
                          style:
                              TextStyle(color: Colors.white, fontSize: 18.0)),
                      subtitle: new Text(client.phone,
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  decoration: new BoxDecoration(color: Colors.black),
                ),
                new ListTile(
                  title: new Text(
                    'Vos courses',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => CoursesPage()),
                    );
                  },
                ),
                SizedBox(
                  height: 1.0,
                ),
                new ListTile(
                  title: new Text(
                    'Consulter les tarifs',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      new MaterialPageRoute(builder: (context) => TarifsPage()),
                    );
                  },
                ),
                SizedBox(
                  height: 1.0,
                ),
                new ListTile(
                  title: new Text(
                    'Paiements',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => PaiementPage()),
                    );
                  },
                ),
                SizedBox(
                  height: 1.0,
                ),
                new ListTile(
                  title: new Text(
                    'Parametres',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => ParametersPage()),
                    );
                  },
                ),
              ],
            )),
            body: new Column(
              children: <Widget>[
                Container(
                    height: MediaQuery.of(context).size.height - 83,
                    width: MediaQuery.of(context).size.width,
                    child: GoogleMap(
                      mapType: MapType.normal,
                      onMapCreated: _onMapCreated,
                      initialCameraPosition: CameraPosition(
                        target: _center,
                        zoom: 12.0,
                      ),
                      markers: Set<Marker>.of(
                        <Marker>[
                          Marker(
                            draggable: true,
                            markerId: MarkerId("1"),
                            position: _center,
                            icon: BitmapDescriptor.defaultMarker,
                            infoWindow: const InfoWindow(
                              title: 'Ma Position',
                            ),
                          )
                        ],
                      ),
                    ))
              ],
            ),
          )
        ]));
    }
  }

  ///relance le service en cas d'echec de connexion internet
  void _onRetryClick() {
    setState(() {
      stateIndex = 0;
      _presenter.detailClient(login.userId, login.token);
    });
  }

  ///soucis de connexion internet
  @override
  void onConnectionError() {
    setState(() {
      stateIndex = 1;
    });
  }

  ///en cas de soucis
  @override
  void onLoginError() {
    setState(() {
      stateIndex = 2;
    });
  }

  @override
  void onLoginSuccess(Client1 datas) async {
    if (datas != null) {
      print(" CLIENT" + datas.lastname);
      setState(() {
        client = datas;
        stateIndex = 3;
        DatabaseHelper().saveClient(datas);
      });
    }
  }

  Marker myPosition = Marker(
    markerId: MarkerId("etakesh1"),
    position: _center,
  );
}
