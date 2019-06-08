import 'package:etakesh_client/DAO/Presenters/ServicePresenter.dart';
import 'package:etakesh_client/Models/services.dart';
import 'package:etakesh_client/Utils/AppSharedPreferences.dart';
import 'package:etakesh_client/Utils/Loading.dart';
import 'package:flutter/material.dart';

class TarifsPage extends StatefulWidget {
  @override
  State createState() => TarifsPageState();
}

class TarifsPageState extends State<TarifsPage> implements ServiceContract {
  int stateIndex;
  List<Service> services;
  ServicePresenter _presenter;
  String token;
  @override
  void initState() {
    AppSharedPreferences().getToken().then((String token1) {
      if (token1 != '') {
        print("Get Token " + token1);
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

  Widget header() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Padding(
                padding: new EdgeInsets.only(left: 16.0),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Text(
                      "Services",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
                    ),
                  ],
                ),
              ),
              new Padding(
                padding: new EdgeInsets.only(left: 22.0),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Text(
                      "Yaoundé",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
                    ),
                  ],
                ),
              ),
              new Padding(
                padding: const EdgeInsets.only(right: 36.0),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text(
                      "Douala",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
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
                          new Text(services[indexItem].intitule,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.w400)),
                          new Text(
                            "Facturé par heure",
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
                            services[indexItem].prix_yaounde.toString() +
                                " XAF",
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
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Text(
                            services[indexItem].prix_douala.toString() + " XAF",
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.w400),
                          ),
                          new Text(
                            "l'heure",
                            style:
                                TextStyle(color: Colors.grey, fontSize: 12.0),
                          ),
                        ],
                      ),
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
                'Tarifs des services',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.black,
              iconTheme: IconThemeData(color: Colors.white),
            ),
            body: Stack(
              children: <Widget>[
                header(),
                Divider(),
                Container(
                    margin: EdgeInsets.only(top: 50.0),
                    child: ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.all(0.0),
                        scrollDirection: Axis.vertical,
                        itemCount: services.length,
                        itemBuilder: (BuildContext ctxt, int index) {
                          return getItem(index);
                        })),
              ],
            ));
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
