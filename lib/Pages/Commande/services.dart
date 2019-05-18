import 'package:etakesh_client/DAO/Presenters/ServicePresenter.dart';
import 'package:etakesh_client/Models/google_place_item.dart';
import 'package:etakesh_client/Models/services.dart';
import 'package:etakesh_client/Utils/AppSharedPreferences.dart';
import 'package:etakesh_client/Utils/Loading.dart';
import 'package:etakesh_client/pages/Commande/commander.dart';
import 'package:flutter/material.dart';

class ServicesPage extends StatefulWidget {
  final GooglePlacesItem destination;
  final GooglePlacesItem position;
  final DateTime cmdDate;
  final TimeOfDay cmdTime;
  ServicesPage(
      {Key key, this.destination, this.position, this.cmdDate, this.cmdTime})
      : super(key: key);
  @override
  State createState() => ServicesPageState();
}

class ServicesPageState extends State<ServicesPage> implements ServiceContract {
  bool service_selected;
  int stateIndex;
  List<Service> services;
  ServicePresenter _presenter;
  String token;
  int curent_service = 0;
  @override
  void initState() {
    service_selected = false;
    AppSharedPreferences().getToken().then((String token1) {
      if (token1 != '') {
        token = token1;
        _presenter = new ServicePresenter(this);
        _presenter.loadServices(token1);
      }
    }).catchError((err) {
      print("Not get Token " + err.toString());
    });
    stateIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Card getItem(indexItem) {
      return Card(
          child: Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Padding(
                      padding: new EdgeInsets.only(left: 16.0),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Text(this.services[indexItem].intitule,
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.w400)),
                          new Text(
                            "Facture par heure",
                            style:
                                TextStyle(color: Colors.grey, fontSize: 12.0),
                          ),
                        ],
                      ),
                    ),
                    new Padding(
                      padding: new EdgeInsets.only(left: 1.0),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Text(
                            this.services[indexItem].prix.toString() + " XAF",
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.w400),
                          ),
                          new Text(
                            "l'heure",
                            style:
                                TextStyle(color: Colors.grey, fontSize: 12.0),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                    new Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: new Radio(
                          activeColor: Color(0xFFDEAC17),
                          value: this.services[indexItem].serviceid,
                          groupValue: curent_service,
                          onChanged: (active) {
                            setState(() {
                              curent_service =
                                  this.services[indexItem].serviceid;
                              service_selected = true;
                              print("ServiceSelected" +
                                  this
                                      .services[indexItem]
                                      .serviceid
                                      .toString());
                            });
                          }),
                    ),
                  ],
                ),
              )));
    }

    switch (stateIndex) {
      case 0:
        return ShowLoadingView();

      case 2:
        return ShowConnectionErrorView(_onRetryClick);

      default:
        return new Scaffold(
          appBar: new AppBar(
            title: new Text(
              'Services',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.black,
//            iconTheme: IconThemeData(color: Colors.white),
          ),
          body: Container(
              child: SingleChildScrollView(
                  child: Column(
            children: <Widget>[
              Divider(),
              ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.all(0.0),
                  scrollDirection: Axis.vertical,
                  itemCount: this.services.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return getItem(index);
                  }),
              Padding(
                padding: EdgeInsets.only(top: 100.0),
                child: Center(
                  child: service_selected
                      ? RaisedButton(
                          padding: EdgeInsets.only(left: 5.0, right: 5.0),
                          color: Color(0xFFDEAC17),
                          child: Text(
                            "OK",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 21.0),
                          ),
                          onPressed: () {
                            Navigator.of(context).pushAndRemoveUntil(
                                new MaterialPageRoute(
                                    builder: (context) => CommandePage()),
                                ModalRoute.withName(
                                    Navigator.defaultRouteName));
                          })
                      : RaisedButton(
                          padding: EdgeInsets.only(left: 5.0, right: 5.0),
                          color: Colors.grey,
                          child: Text(
                            "OK",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 21.0),
                          ),
                          onPressed: () {}),
                ),
              ),
            ],
          ))),
        );
    }
  }

  ///relance le service en cas d'echec de connexion internet
  void _onRetryClick() {
    setState(() {
      stateIndex = 0;
      _presenter.loadServices(token);
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

  ///si tout ce passe bien
  @override
  void onLoadingSuccess(List<Service> services) {
    setState(() {
      this.services = services;
      stateIndex = 3;
    });
  }
}
