import 'dart:async';

import 'package:etakesh_client/DAO/Presenters/PrestatairesServicePresenter.dart';
import 'package:etakesh_client/DAO/Rest_dt.dart';
import 'package:etakesh_client/DAO/google_maps_requests.dart';
import 'package:etakesh_client/Database/DatabaseHelper.dart';
import 'package:etakesh_client/Models/clients.dart';
import 'package:etakesh_client/Models/commande.dart';
import 'package:etakesh_client/Models/google_place_item.dart';
import 'package:etakesh_client/Models/google_place_item_term.dart';
import 'package:etakesh_client/Models/prestataires.dart';
import 'package:etakesh_client/Models/services.dart';
import 'package:etakesh_client/Utils/Loading.dart';
import 'package:etakesh_client/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CommandePage extends StatefulWidget {
  final GooglePlacesItem destination;
  final GooglePlacesItem position;
  final Service service;
  final LocationModel locposition;
  final LocationModel locdestination;

  CommandePage(
      {Key key,
      this.destination,
      this.position,
      this.service,
      this.locposition,
      this.locdestination})
      : super(key: key);
  @override
  State createState() => CommandePageState();
}

class CommandePageState extends State<CommandePage>
    implements PresetataireServiceContract {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  GoogleMapsServices _googleMapsServices = GoogleMapsServices();
  PresetataireServicePresenter _presenter;

  Commande cmd;
  int stateIndex;
  Login2 login;
  Client1 client;
  LatLng target;
  List<PrestataireService> listprestataires;

  CommandePageState() {
    _presenter = new PresetataireServicePresenter(this);
  }

  Set<Marker> markers = Set();
  Set<Polyline> _polyLines = Set();
  GoogleMapController mapController;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  GooglePlacesItem destinationModel = new GooglePlacesItem();
  GooglePlacesItem positiontionModel = new GooglePlacesItem();
  LatLng _mypositio = new LatLng(4.0922421, 9.748265);
  LocationModel position, destination;
  int _selectedIndex = -1;
  PrestataireService _prestataireselect;
  RestDatasource api = new RestDatasource();
  bool loading;

  @override
  void initState() {
    loading = false;
    _addMarkerPosition(widget.position.place_id);
    DatabaseHelper().getUser().then((Login2 l) {
      if (l != null) {
        print("USER " + l.userId.toString());
        login = l;
        _presenter.loadPrestataires(l.token, widget.service.serviceid);
      }
    });
    _addMarkerDestination(widget.destination.place_id);
    stateIndex = 0;
    _sendRequest();
    super.initState();
  }

  /*
* [12.12, 312.2, 321.3, 231.4, 234.5, 2342.6, 2341.7, 1321.4]
* (0-------1-------2------3------4------5-------6-------7)
* */

//  this method will convert list of doubles into latlng
  List<LatLng> convertToLatLng(List points) {
    List<LatLng> result = <LatLng>[];
    for (int i = 0; i < points.length; i++) {
      if (i % 2 != 0) {
        result.add(LatLng(points[i - 1], points[i]));
      }
    }
    return result;
  }

  List decodePoly(String poly) {
    var list = poly.codeUnits;
    var lList = new List();
    int index = 0;
    int len = poly.length;
    int c = 0;
// repeating until all attributes are decoded
    do {
      var shift = 0;
      int result = 0;

      // for decoding value of one attribute
      do {
        c = list[index] - 63;
        result |= (c & 0x1F) << (shift * 5);
        index++;
        shift++;
      } while (c >= 32);
      /* if value is negetive then bitwise not the value */
      if (result & 1 == 1) {
        result = ~result;
      }
      var result1 = (result >> 1) * 0.00001;
      lList.add(result1);
    } while (index < len);

/*adding to previous value as done in encoding */
    for (var i = 2; i < lList.length; i++) lList[i] += lList[i - 2];

    print(lList.toString());

    return lList;
  }

  void createRoute(String encondedPoly) {
    setState(() {
      _polyLines.add(Polyline(
          polylineId: PolylineId(_mypositio.toString()),
          width: 10,
          points: convertToLatLng(decodePoly(encondedPoly)),
          color: Colors.black));
    });
  }

  void _sendRequest() async {
    String route = await _googleMapsServices.getRouteCoordinates(
        widget.locposition, widget.locdestination);
    createRoute(route);
  }

  void _addMarkerDestination(String paceId) async {
    LocationModel dest = await _googleMapsServices.getRoutePlaceById(paceId);
    setState(() {
      destination = dest;
      markers.add(Marker(
          markerId: MarkerId(paceId),
          position: LatLng(destination.lat, destination.lng),
          infoWindow: InfoWindow(
              title: widget.destination.description, snippet: "Destination"),
          icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueGreen)));
    });
  }

  void _addMarkerPosition(String paceId) async {
    LocationModel post = await _googleMapsServices.getRoutePlaceById(paceId);
    setState(() {
      position = post;
      markers.add(Marker(
          markerId: MarkerId(paceId),
          position: LatLng(position.lat, position.lng),
          infoWindow: InfoWindow(
              title: widget.position.description, snippet: "Position"),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue)));
    });
  }

  _onSelected(int index) {
    setState(() => _selectedIndex = index);
  }

  Future<LatLng> _getUserLocation() async {
//    var currentLocation = <String, double>{};
//    final location = LocationManager.Location();
    try {
//      currentLocation = await location.getLocation();
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      var lat = position.latitude;
      var lng = position.longitude;
      setState(() {
        target = LatLng(lat, lng);
        print("Ma Position1 Lat" +
            position.latitude.toString() +
            "Lng" +
            position.longitude.toString());
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
//      currentLocation = null;
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
        return ShowLoadingErrorView(_onRetryClick);
      case 2:
        return ShowConnectionErrorView(_onRetryClick);
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
                    compassEnabled: true,
                    initialCameraPosition: CameraPosition(
                        target: LatLng(
                            widget.locposition.lat, widget.locposition.lng),
                        zoom: 9.0),
                    markers: markers,
                    polylines: _polyLines,
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
              Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                      color: Colors.white,
                      child: new Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 10.0),
                            child: new Center(
                              child: Text(
                                "Commandez vos taxis",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18.0),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5.0),
                            child: new Center(
                              child: Text(
                                "Economique, rapide et fiable",
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 16.0),
                              ),
                            ),
                          ),
                          Container(
                            height: 165.0,
                            child: loading
                                ? Container(
                                    padding: const EdgeInsets.only(
                                        left: 20,
                                        right: 20,
                                        top: 30.0,
                                        bottom: 15.0),
                                    child: Center(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
//                                            padding: EdgeInsets.all(20.0),
                                            child: CircularProgressIndicator(
                                              backgroundColor:
                                                  Color(0xFF0C60A8),
                                            ),
                                          ),
                                          Text(
                                            "Chargement...",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.0,
                                                color: Colors.black),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                : ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    padding: EdgeInsets.only(
                                        left: 5.0,
                                        right: 5.0,
                                        top: 10.0,
                                        bottom: 10.0),
                                    itemCount: listprestataires.length,
                                    itemBuilder:
                                        (BuildContext ctxt, int index) {
                                      return InkWell(
                                        child: Container(child: getItem(index)),
                                        onTap: () {
                                          _onSelected(index);
                                          setState(() {
                                            _prestataireselect =
                                                listprestataires[index];
                                          });
                                        },
                                      );
                                    }),
                          ),
                          Divider(),
                          _prestataireselect != null
                              ? Row(
                                  children: <Widget>[
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.75,
                                        child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 15.0, bottom: 10.0),
                                            child: RaisedButton(
                                                color: Color(0xFFDEAC17),
                                                child: Text(
                                                    " CONFIRMER " +
                                                        _prestataireselect
                                                            .prestataire.prenom,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20.0)),
                                                padding: EdgeInsets.only(
                                                    left: 15.0,
                                                    right: 15.0,
                                                    top: 10.0,
                                                    bottom: 10.0),
                                                onPressed: () {
                                                  setState(() {
                                                    loading = true;
                                                  });
                                                  api
                                                      .savePosition(
                                                          widget.locdestination
                                                              .lat,
                                                          widget.locdestination
                                                              .lng,
                                                          widget.destination
                                                              .description,
                                                          login.token)
                                                      .then(
                                                          (PositionModel dest) {
                                                    if (dest != null) {
                                                      print(" DestPost" +
                                                          dest.positionid
                                                              .toString());
                                                      api
                                                          .savePosition(
                                                              widget.locposition
                                                                  .lat,
                                                              widget.locposition
                                                                  .lng,
                                                              widget.position
                                                                  .description,
                                                              login.token)
                                                          .then((PositionModel
                                                              post) {
                                                        if (post != null) {
                                                          print(" PostPost" +
                                                              post.positionid
                                                                  .toString());
                                                          api
                                                              .saveCmd(
                                                                  widget.service
                                                                      .prix,
                                                                  post
                                                                      .positionid,
                                                                  dest
                                                                      .positionid,
                                                                  client
                                                                      .client_id,
                                                                  _prestataireselect
                                                                      .prestationid,
                                                                  login.token)
                                                              .then((Commande
                                                                  cmdCreate) {
                                                            if (cmdCreate !=
                                                                null)
                                                              setState(() {
                                                                loading = false;
                                                              });
                                                            Navigator.of(context).pushAndRemoveUntil(
                                                                new MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            HomePage()),
                                                                ModalRoute.withName(
                                                                    Navigator
                                                                        .defaultRouteName));
                                                          });
                                                        }
                                                      });
                                                    }
                                                  });
                                                }))),
                                    Container(
                                      height: 50.0,
                                      width: 50.0,
                                      margin: EdgeInsets.only(left: 15.0),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  _prestataireselect
                                                      .prestataire.image),
                                              fit: BoxFit.cover)),
                                    )
                                  ],
                                )
                              : Container(),
                        ],
                      ))),
            ]));
    }
  }

  Widget getItem(indexItem) {
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
                      image: NetworkImage(
                          listprestataires[indexItem].vehicule.image),
                      fit: BoxFit.cover)),
            ),
            Positioned(
              bottom: 50.0,
              left: 50.0,
              child: Container(
                height: 25.0,
                width: 25.0,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.5),
                    image: DecorationImage(
                        image: NetworkImage(
                            listprestataires[indexItem].prestataire.image),
                        fit: BoxFit.cover)),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Center(
          child: Text(
            listprestataires[indexItem].prestataire.prenom,
            style: TextStyle(color: Colors.black, fontSize: 20.0),
          ),
        ),
        SizedBox(height: 5.0),
        Container(
          margin: EdgeInsets.only(right: 10.0),
          padding: EdgeInsets.only(right: 5.0, left: 5.0),
          color: _selectedIndex != -1 && _selectedIndex == indexItem
              ? Color(0xFF0C60A8)
              : Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("15 Min pour arriver",
                  style: TextStyle(
                      color: _selectedIndex != -1 && _selectedIndex == indexItem
                          ? Colors.white
                          : Colors.black54,
                      fontSize: 14.0)),
              SizedBox(height: 0),
              Text("1 Km de vous",
                  style: TextStyle(
                    color: _selectedIndex != -1 && _selectedIndex == indexItem
                        ? Colors.white
                        : Colors.black54,
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
      _presenter.loadPrestataires(login.token, widget.service.serviceid);
    });
  }

  ///soucis de connexion internet
  @override
  void onConnectionError() {
    setState(() {
      stateIndex = 2;
    });
  }

  ///en cas de soucis
  @override
  void onLoadingError() {
    setState(() {
      stateIndex = 1;
    });
  }

  @override
  void onLoadingSuccess(List<PrestataireService> prestataires) async {
    DatabaseHelper().getClient().then((Client1 c) {
      if (c != null) {
        print("Client " + c.client_id.toString());
        setState(() {
          client = c;
        });
      }
    });
    if (prestataires.length != 0) {
      print(" Prestataires List" + prestataires.toString());
      setState(() {
        listprestataires = prestataires;
        stateIndex = 3;
      });
    }
  }
}
