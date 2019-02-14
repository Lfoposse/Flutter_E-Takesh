import 'dart:async';

import 'package:etakesh_client/pages/courses_page.dart';
import 'package:etakesh_client/pages/parameters_page.dart';
import 'package:etakesh_client/pages/tarifs_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GoogleMapController mapController;
  Map<String, double> currentLocation = new Map();
  StreamSubscription<Map<String, double>> locationSubscription;
  Location location = new Location();
  String error;

  Widget researchBox(
      String hintText, Color bgdColor, Color textColor, Color borderColor) {
    return Container(
      height: double.infinity,
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
      decoration: new BoxDecoration(
          color: bgdColor,
          border: new Border(
            top: BorderSide(
                color: borderColor, style: BorderStyle.solid, width: 1.0),
            bottom: BorderSide(
                color: borderColor, style: BorderStyle.solid, width: 1.0),
            left: BorderSide(
                color: borderColor, style: BorderStyle.solid, width: 1.5),
            right: BorderSide(
                color: borderColor, style: BorderStyle.solid, width: 1.5),
          )),
      child: Row(children: [
        Icon(Icons.search, color: textColor, size: 30.0),
        Expanded(
            child: Container(
                child: TextFormField(
                    autofocus: false,
                    autocorrect: false,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: hintText,
                        hintStyle: TextStyle(color: textColor)),
                    style: TextStyle(
                      fontSize: 14.0,
                      color: textColor,
                      fontWeight: FontWeight.bold,
                    ))))
      ]),
    );
  }

  @override
  void initState() {
    super.initState();
    currentLocation['latitude'] = 0.0;
    currentLocation['longitude'] = 0.0;

    initPlstformeState();
    locationSubscription =
        location.onLocationChanged().listen((Map<String, double> result) {
      setState(() {
        currentLocation = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Lat/Lng:${currentLocation['latitude']}/${currentLocation['longitude']}',
          overflow: TextOverflow.fade,
        ),
      ),
      drawer: new Drawer(
        child: ListView(
          children: <Widget>[
            new DrawerHeader(
              child: Container(
                margin: EdgeInsets.all(0.0),
                decoration: BoxDecoration(color: Colors.black),
                child: new UserAccountsDrawerHeader(
                  accountName: new Text('Rainbow Cl'),
                  accountEmail: new Text('wilfried@rainbowcl.net'),
                  currentAccountPicture: new GestureDetector(
                    child: new CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage:
                          new AssetImage('assets/images/avatar.png'),
                    ),
                  ),
                  decoration: new BoxDecoration(
//                      color: Colors.black
//               shape: BoxShape.rectangle87,
                      ),
                ),
              ),
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
            new ListTile(
              title: new Text(
                'Paiements',
                style: TextStyle(fontSize: 18.0),
              ),
              onTap: () {},
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
        ),
      ),
      body: new Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height - 83,
            width: MediaQuery.of(context).size.width,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                bearing: 270.0,
                target: LatLng(4.0926404, 9.7482474),
                tilt: 30.0,
                zoom: 12.0,
              ),
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
                mapController.addMarker(
                  MarkerOptions(
                    position: LatLng(4.0926404, 9.7482474),
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueBlue),
                    infoWindowText: InfoWindowText("E-Takesh", "UserName"),
                    consumeTapEvents: true,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void initPlstformeState() async {
    Map<String, double> my_location;
    try {
      my_location = await location.getLocation();
      error = "";
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DINIED')
        error = 'Permission refuser';
      else if (e.code == 'PERMISSION_DENIED_NEVER_ASK')
        error =
            'Permission refuser svp demander a utilisateur de faire cela dans les parametresde votre mobile';
      my_location = null;
    }
    setState(() {
      currentLocation = my_location;
    });
  }
}
