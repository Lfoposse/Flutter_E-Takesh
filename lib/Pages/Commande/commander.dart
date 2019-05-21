import 'dart:async';

import 'package:etakesh_client/DAO/Presenters/LoginPresenter.dart';
import 'package:etakesh_client/Database/DatabaseHelper.dart';
import 'package:etakesh_client/Models/clients.dart';
import 'package:etakesh_client/Models/google_place_item.dart';
import 'package:etakesh_client/Models/services.dart';
import 'package:etakesh_client/Utils/Loading.dart';
import 'package:etakesh_client/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as LocationManager;

const kGoogleApiKey = "AIzaSyBNm8cnYw5inbqzgw8LjXyt3rMhFhEVTjY";

class CommandePage extends StatefulWidget {
  final GooglePlacesItem destination;
  final GooglePlacesItem position;
  final Service service;
  CommandePage({Key key, this.destination, this.position, this.service})
      : super(key: key);
  @override
  State createState() => CommandePageState();
}

class CommandePageState extends State<CommandePage> implements LoginContract {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  LoginPresenter _presenter;

  int stateIndex;
  Login2 login;
  Client1 client;
  LatLng target;
  double mylat, mylng;

  CommandePageState() {
    _presenter = new LoginPresenter(this);
  }
  Set<Marker> markers = Set();
  GoogleMapController mapController;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  GooglePlacesItem destinationModel = new GooglePlacesItem();
  GooglePlacesItem positiontionModel = new GooglePlacesItem();

  @override
  void initState() {
    mylat = 4.0922421;
    mylng = 9.748265;
    print("desti " + widget.destination.description);
    print("posit " + widget.position.description);
    print("servic " + widget.service.serviceid.toString());
    DatabaseHelper().getUser().then((Login2 l) {
      if (l != null) {
        print("USER " + l.userId.toString());
        login = l;
        _presenter.detailClient(l.userId, l.token);
      }
    });
    stateIndex = 0;
    getUserLocation();
    markers.add(
      Marker(
        markerId: MarkerId('destination position'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        position: LatLng(4.0867588, 9.6275952),
        infoWindow: InfoWindow(
          title: 'Destination',
          snippet: 'Vous allez a Makepe',
        ),
      ),
    );
    super.initState();
  }

  Future<LatLng> getUserLocation() async {
    var currentLocation = <String, double>{};
    final location = LocationManager.Location();
    try {
      currentLocation = await location.getLocation();
      var lat = currentLocation["latitude"];
      var lng = currentLocation["longitude"];
      setState(() {
        mylat = currentLocation["latitude"];
        mylng = currentLocation["longitude"];
        target = LatLng(lat, lng);
        print("Ma Position1 " + currentLocation.toString());
        markers.add(
          Marker(
            markerId: MarkerId('current position'),
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
            position: target,
            infoWindow: InfoWindow(
              title: 'Ma position courante',
              snippet: 'Vous vous trouvez ici en ce moment',
            ),
          ),
        );
      });
      return target;
    } on Exception {
      currentLocation = null;
      return null;
    }
  }

  Completer<GoogleMapController> _controller = Completer();

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
        return new Scaffold(
            key: _scaffoldKey,
            body: Stack(children: <Widget>[
              Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: GoogleMap(
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                    myLocationEnabled: true,
                    zoomGesturesEnabled: true,
                    scrollGesturesEnabled: true,
                    rotateGesturesEnabled: true,
                    tiltGesturesEnabled: true,
                    initialCameraPosition: CameraPosition(
                        target: LatLng(mylat, mylng), zoom: 11.0),
                    markers: markers,
                  )),
              Positioned(
                height: 50.0,
                left: 5.0,
                top: 15.0,
                child: IconButton(
                  onPressed: () {
                    showDialog<bool>(
                      context: context,
                      builder: (BuildContext context) {
                        return new AlertDialog(
                          title: new Text("Avertissement !!!"),
                          content: new SingleChildScrollView(
                            child: new ListBody(
                              children: <Widget>[
                                new Text(
                                    "Vous etez sur le point d'annuler votre commande"),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            new FlatButton(
                              child: new Text("ANNULER",
                                  style: TextStyle(color: Colors.lightGreen)),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            new FlatButton(
                              child: new Text("CONFIRMER",
                                  style: TextStyle(color: Colors.blue)),
                              onPressed: () {
                                Navigator.of(context).pushAndRemoveUntil(
                                    new MaterialPageRoute(
                                        builder: (context) => HomePage()),
                                    ModalRoute.withName(
                                        Navigator.defaultRouteName));
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
              ),
//              Positioned(
//                  height: MediaQuery.of(context).size.height / 2,
//                  bottom: 0,
//                  left: 0,
//                  right: 0,
//                  child: Container(
////                      color: Color(0x88F9FAFC),
//                      color: Colors.white,
//                      child: new Column(
//                        children: <Widget>[
//                          Padding(
//                            padding: EdgeInsets.only(top: 10.0),
//                            child: new Center(
//                              child: Text(
//                                "Commandez vos taxis",
//                                style: TextStyle(
//                                    color: Colors.black, fontSize: 18.0),
//                              ),
//                            ),
//                          ),
//                          Padding(
//                            padding: EdgeInsets.only(top: 5.0),
//                            child: new Center(
//                              child: Text(
//                                "Economique, rapide et fiable",
//                                style: TextStyle(
//                                    color: Colors.black26, fontSize: 16.0),
//                              ),
//                            ),
//                          ),
//                          Container(
//                            height: 165.0,
//                            child: ListView(
//                              scrollDirection: Axis.horizontal,
//                              padding: EdgeInsets.only(
//                                  left: 5.0,
//                                  right: 5.0,
//                                  top: 10.0,
//                                  bottom: 10.0),
//                              children: <Widget>[
//                                listItem('assets/images/cameroun_flag.png',
//                                    'assets/images/avatar.png', 'Leger', 30, 3),
//                                listItem(
//                                    'assets/images/login_icon.png',
//                                    'assets/images/facebook.png',
//                                    'Eddy',
//                                    30,
//                                    3),
//                                listItem(
//                                    'assets/images/avatar.png',
//                                    'assets/images/google.png',
//                                    'Romuald',
//                                    30,
//                                    3),
//                                listItem(
//                                    'assets/images/facebook.png',
//                                    'assets/images/cameroun_flag.png',
//                                    'Odelphine',
//                                    30,
//                                    3),
//                                listItem(
//                                    'assets/images/google.png',
//                                    'assets/images/login_icon.png',
//                                    'Wilfried',
//                                    30,
//                                    3),
//                              ],
//                            ),
//                          ),
//                          Divider(),
//                          Row(
//                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                            children: <Widget>[
//                              RaisedButton(
//                                  color: Color(0xFFDEAC17),
//                                  child: Text(" CONFIRMER ",
//                                      style: TextStyle(
//                                          color: Colors.white, fontSize: 20.0)),
//                                  padding: EdgeInsets.only(
//                                      left: 15.0,
//                                      right: 15.0,
//                                      top: 5.0,
//                                      bottom: 5.0),
//                                  onPressed: () {}),
//                              Container(
//                                height: 50.0,
//                                width: 50.0,
//                                decoration: BoxDecoration(
//                                    borderRadius: BorderRadius.circular(25.0),
//                                    image: DecorationImage(
//                                        image: AssetImage(
//                                            'assets/images/google.png'),
//                                        fit: BoxFit.cover)),
//                              )
//                            ],
//                          )
//                        ],
//                      ))),
            ]));
    }
  }

  Widget listItem(String imgCar, String imgDriver, String driverName, int time,
      double distance) {
    return Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Container(
              height: 75.0,
              width: 75.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(37.5),
                  image: DecorationImage(
                      image: AssetImage(imgCar), fit: BoxFit.cover)),
            ),
            Positioned(
              bottom: 50.0,
              left: 50.0,
              child: Container(
                height: 25.0,
                width: 25.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.5),
                    image: DecorationImage(
                        image: AssetImage(imgDriver), fit: BoxFit.cover)),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Center(
          child: Text(
            driverName,
            style: TextStyle(color: Colors.black, fontSize: 20.0),
          ),
        ),
        SizedBox(height: 5.0),
        Container(
          margin: EdgeInsets.only(right: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(time.toString() + " Min pour arriver",
                  style: TextStyle(color: Colors.black26, fontSize: 14.0)),
              SizedBox(height: 0),
              Text(distance.toString() + " Km de vous",
                  style: TextStyle(
                    color: Colors.black26,
                    fontSize: 14.0,
                  )),
            ],
          ),
        )
      ],
    );
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
        DatabaseHelper().getUser().then((Login2 l) {
          if (l != null) {
            print("USERExist " + l.userId.toString());
          } else {
            DatabaseHelper().saveClient(datas);
          }
        });
      });
    }
  }
}
