//import 'dart:io';
//
//import 'package:flutter/material.dart';
//import 'package:http/http.dart' as http;
//import 'dart:convert';
//import 'package:etakesh_client/Models/services.dart';
//
//
//class TarifsPage extends StatefulWidget {
//  @override
//  State createState() => TarifsPageState();
//}
//
//class TarifsPageState extends State<TarifsPage> {
//  final String url = "http://api.e-takesh.com:26960/api/services";
//  final String token = "?access_token=uZzQiR1abvuQqVBoQV1SRp3uVxhQ65CNU3QfSSr2rQZWJieP59c5CUpyhjfbB8p1";
//
//  Future<List<Service1>> getPost() async {
//    final response = await http
//        .get(Uri.encodeFull(url+token), headers: {HttpHeaders.acceptHeader: "application/json"},);
//
//    if (response.statusCode == 200) {
//      // If the call to the server was successful, parse the JSON
//
//      var convertDataToJson = json.decode(response.body);
//      List<Service1> services = [];
//
//      for (var p in convertDataToJson){
//        Service1 serv = Service1.fromJson(p);
//        services.add(serv);
//      }
//      return services;
//    } else {
//      // If that call was not successful, throw an error.
//      throw Exception('Failed to load services error'+response.statusCode.toString());
//    }
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return new Scaffold(
//      appBar: new AppBar(
//        title: new Text('Tarifs des services'),
//        backgroundColor: Colors.black87,
//      ),
//      body: Container(
//        child: FutureBuilder(
//          future: getPost(),
//          builder: (BuildContext context, AsyncSnapshot snapshot) {
//            if (snapshot.hasData) {
//              return ListView.builder(
//                  itemCount: snapshot.data.length,
//                  itemBuilder: (BuildContext context, int index) {
//                    return new Center(
//                      child: new Column(
//                        crossAxisAlignment: CrossAxisAlignment.stretch,
//                        children: <Widget>[
//                          new Card(
//                            child: new Container(
//                              child: new ListTile(
//                                title: Text(snapshot.data[index].intitule),
//                              subtitle: Text(snapshot.data[index].prix.toString()+' XAF'),),
//                              padding: const EdgeInsets.all(20.0),
//                            ),
//                          )
//                        ],
//                      ),
//                    );
//                  });
//            } else if (snapshot.hasError) {
//              return Text("${snapshot.error}");
//            }
//
//            // By default, show a loading spinner
//            return Center(
//              child: CircularProgressIndicator(),
//            );
//          },
//        ),
//      ),
//
//    );
//  }
//
//}
import 'package:etakesh_client/DAO/Presenters/ServicePresenter.dart';
import 'package:etakesh_client/Models/services.dart';
import 'package:etakesh_client/Utils/Loading.dart';
import 'package:flutter/material.dart';

class TarifsPage extends StatefulWidget {
  @override
  State createState() => TarifsPageState();
}

class TarifsPageState extends State<TarifsPage> implements ServiceContract {
  List<Service> _service;
  ServicePresenter _presenter;
  int stateIndex;
  @override
  void initState() {
    stateIndex = 0;
    _presenter = new ServicePresenter(this);
    _presenter.loadTarif();
    super.initState();
  }

  Widget getDivider(double height, {bool horizontal}) {
    return Container(
      width: horizontal ? double.infinity : height,
      height: horizontal ? height : double.infinity,
      color: Color.fromARGB(15, 0, 0, 0),
    );
  }

  void _onRetryClick() {
    setState(() {
      stateIndex = 0;
      _presenter.loadTarif();
    });
  }

  @override
  Widget build(BuildContext context) {
    Container getItem(itemIndex) {
      return Container(
        margin: EdgeInsets.all(0.0),
        padding: EdgeInsets.all(10.0),
        // color: Colors.white,
        height: 120.0,
        child: Card(
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              margin: EdgeInsets.all(5.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          width: double.infinity,
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text(_service[itemIndex].intitule.toString(),
                                      textAlign: TextAlign.left,
                                      overflow: TextOverflow.ellipsis,
                                      style: new TextStyle(
                                        color: Colors.black,
                                        decoration: TextDecoration.none,
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ],
                              ),
                              //Icon(Icons.shopping_cart, color: Color.fromARGB(255, 255, 215, 0),size: 14.0, ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )),
        ),
      );
    }

    switch (stateIndex) {
      case 0:
        return ShowLoadingView();

      case 1:
        return ShowLoadingErrorView(_onRetryClick);

      case 2:
        return ShowConnectionErrorView(_onRetryClick);

      default:
        return Column(
          children: <Widget>[
            Flexible(
                child: Container(
                    color: Colors.black12,
                    child: ScrollConfiguration(
                      behavior: ScrollBehavior(),
                      child: new ListView.builder(
                          padding: EdgeInsets.all(0.0),
                          scrollDirection: Axis.vertical,
                          itemCount: _service.length,
                          itemBuilder: (BuildContext ctxt, int index) {
                            return getItem(index);
                          }),
                    )))
          ],
        );
    }
  }

  @override
  void onConnectionError() {
    setState(() {
      stateIndex = 2;
    });
  }

  @override
  void onLoadingError() {
    setState(() {
      stateIndex = 1;
    });
  }

  @override
  void onLoadingSuccess(List<Service> service) {
    setState(() {
      stateIndex = 3;
      _service = service;
    });
  }
}
