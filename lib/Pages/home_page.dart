import 'dart:async';

import 'package:etakesh_client/pages/courses_page.dart';
import 'package:etakesh_client/pages/paiements_page.dart';
import 'package:etakesh_client/pages/parameters_page.dart';
import 'package:etakesh_client/pages/tarifs_page.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatelessWidget {
  Completer<GoogleMapController> _controller = Completer();

  static const LatLng _center = const LatLng(4.521563, 9.677433);

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
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
                  title: new Text("Fotso Pierre",
                      style: TextStyle(color: Colors.white, fontSize: 18.0)),
                  subtitle: new Text("+237670548852",
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
                  new MaterialPageRoute(builder: (context) => CoursesPage()),
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
                  new MaterialPageRoute(builder: (context) => PaiementPage()),
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
                  new MaterialPageRoute(builder: (context) => ParametersPage()),
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
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 11.0,
                ),
              ),
            )
          ],
        ),
      )
    ]));
  }
}
