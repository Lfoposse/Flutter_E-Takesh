import 'dart:async';

import 'package:etakesh_client/DAO/Presenters/LoginPresenter.dart';
import 'package:etakesh_client/Database/DatabaseHelper.dart';
import 'package:etakesh_client/Models/clients.dart';
import 'package:etakesh_client/Models/google_place_item.dart';
import 'package:etakesh_client/Utils/Loading.dart';
import 'package:etakesh_client/pages/Commande/destination_page.dart';
import 'package:etakesh_client/pages/Commande/position_page.dart';
import 'package:etakesh_client/pages/Commande/services.dart';
import 'package:etakesh_client/pages/courses_page.dart';
import 'package:etakesh_client/pages/paiements_page.dart';
import 'package:etakesh_client/pages/parameters_page.dart';
import 'package:etakesh_client/pages/tarifs_page.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as LocationManager;

const kGoogleApiKey = "AIzaSyBNm8cnYw5inbqzgw8LjXyt3rMhFhEVTjY";

class HomePage extends StatefulWidget {
  @override
  State createState() => HomePageState();
}

class HomePageState extends State<HomePage> implements LoginContract {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  bool pret_a_commander = false;
  bool destination_selected = false;
  LoginPresenter _presenter;
  String destination, position;
  int stateIndex;
  Login2 login;
  Client1 client;
  LatLng target;
  double mylat, mylng;

  HomePageState() {
    _presenter = new LoginPresenter(this);
  }
  Set<Marker> markers = Set();
  GoogleMapController mapController;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  GooglePlacesItem destinationModel = new GooglePlacesItem();
  GooglePlacesItem positiontionModel = new GooglePlacesItem();

  Future<Null> selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(selectedDate.year, 1),
        lastDate: DateTime(selectedDate.year + 1));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
    selectTime(context);
  }

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime)
      setState(() {
        selectedTime = picked;
      });
    Navigator.of(context).pushAndRemoveUntil(
        new MaterialPageRoute(
            builder: (context) => ServicesPage(
                  destination: destinationModel,
                  position: positiontionModel,
                )),
        ModalRoute.withName(Navigator.defaultRouteName));
  }

  @override
  void initState() {
    mylat = 4.0922421;
    mylng = 9.748265;
    destination_selected = false;
    pret_a_commander = false;
    destination = "Ou allez vous ?";
    position = "Ou etes vous ?";
    DatabaseHelper().getUser().then((Login2 l) {
      if (l != null) {
        print("USER " + l.userId.toString());
        login = l;
        _presenter.detailClient(l.userId, l.token);
      }
    });
    stateIndex = 0;
    getUserLocation();
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

//  void refresh() async {
//    final center = await getUserLocation();
//    print("Ma Position2 " + center.toString());
//    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
//        target: center == null ? LatLng(0, 0) : center, zoom: 11.0)));
//  }

//  void _onMapCreated(GoogleMapController controller) {
////    _controller.complete(controller);
//    mapController = controller;
////    refresh();
//  }

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
            drawer: new Drawer(
                child: new ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                new DrawerHeader(
                  child: ListTile(
                    leading: new CircleAvatar(
                      child: new Image.asset("assets/images/avatar.png",
                          width: 30.0, height: 30.0),
                      radius: 32.0,
                      backgroundColor: Colors.white,
                    ),
                    title: new Text(client.username + " " + client.lastname,
                        style: TextStyle(color: Colors.white, fontSize: 18.0)),
                    subtitle: new Text(client.phone,
                        style: TextStyle(color: Colors.white)),
                  ),
//                  ),
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
                        target: LatLng(mylat, mylng), zoom: 17.0),
                    markers: markers,
                  )),
              Positioned(
                height: 50.0,
                left: 5.0,
                top: 15.0,
                child: IconButton(
                  onPressed: () {
                    _scaffoldKey.currentState.openDrawer();
                  },
                  icon: Icon(
                    Icons.menu,
                    color: Colors.black,
                  ),
                ),
              ),
              Positioned(
                  top: 70.0,
                  left: 10.0,
                  right: 10.0,
                  height: 60.0,
                  child: Card(
                      elevation: 8.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2.0),
                      ),
                      child: InkWell(
                        child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            child: Container(
                              color: Color(0x88F9FAFC),
                              child: Row(
                                children: <Widget>[
                                  new Padding(
                                    padding: new EdgeInsets.symmetric(
                                        horizontal: 32.0 - 12.0 / 2),
                                    child: new Container(
                                      height: 5.0,
                                      width: 5.0,
                                      decoration: new BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          color: Color(0xFFDEAC17)),
                                    ),
                                  ),
                                  new Text(
                                    destination,
                                    style: TextStyle(
                                        color: Colors.black26, fontSize: 16.0),
                                  )
                                ],
                              ),
                            )),
                        onTap: () {
                          showDestinationPlaces();
                        },
                      ))),
            ]));
    }
  }

  void showDestinationPlaces() async {
    destinationModel = await Navigator.of(context)
        .push(new MaterialPageRoute<GooglePlacesItem>(
            builder: (BuildContext context) {
              return new DestinationPage(latitude: mylat, longitude: mylng);
            },
            fullscreenDialog: true));
    if (destinationModel != null) {
      print("Destination choisie" + destinationModel.description);
      setState(() {
        destination_selected = true;
        destination = destinationModel.terms[0].value;
      });
      showPositionPlaces();
    }
  }

  Future showPositionPlaces() async {
    positiontionModel = await Navigator.of(context)
        .push(new MaterialPageRoute<GooglePlacesItem>(
            builder: (BuildContext context) {
              return new PositionPage(
                latitude: mylat,
                longitude: mylng,
                destination: destinationModel,
              );
            },
            fullscreenDialog: true));
    if (positiontionModel != null) {
      print("Destination choisie" + positiontionModel.description);
      setState(() {
        pret_a_commander = true;
        position = positiontionModel.terms[0].value;
      });
      Navigator.of(context).pushAndRemoveUntil(
          new MaterialPageRoute(
              builder: (context) => ServicesPage(
                  destination: destinationModel, position: positiontionModel)),
          ModalRoute.withName(Navigator.defaultRouteName));
    }
  }

  Widget listItem(String title, Color color) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: Container(
          color: Color(0x88F9FAFC),
          child: Row(
            children: <Widget>[
              new Padding(
                padding: new EdgeInsets.symmetric(horizontal: 32.0 - 12.0 / 2),
                child: new Container(
                  height: 10.0,
                  width: 10.0,
                  decoration: new BoxDecoration(
                      shape: BoxShape.rectangle, color: color),
                ),
              ),
              new Text(title)
            ],
          ),
        ));
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
