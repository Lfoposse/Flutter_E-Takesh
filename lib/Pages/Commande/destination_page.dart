import 'dart:convert';

import 'package:etakesh_client/DAO/Rest_dt.dart';
import 'package:etakesh_client/Models/google_place_item.dart';
import 'package:etakesh_client/Models/google_place_model.dart';
import 'package:flutter/material.dart';

class DestinationPage extends StatefulWidget {
  final double latitude;
  final double longitude;
  DestinationPage({Key key, this.latitude, this.longitude}) : super(key: key);
  @override
  DestinationPageState createState() => new DestinationPageState();
}

class DestinationPageState extends State<DestinationPage> {
  TextEditingController _searchDestination;
  TextEditingController _searchPosition;
  RestDatasource api = new RestDatasource();
  var _locations = new List<GooglePlacesItem>();

  @override
  initState() {
    super.initState();
    _searchDestination = new TextEditingController();
    _searchPosition = new TextEditingController();
  }

  _findLocation(String input) {
    api
        .findLocation(input, "fr", widget.latitude, widget.longitude)
        .then((response) {
      final String responseString = response.body;
      setState(() {
        GooglePlacesModel placesModel =
            new GooglePlacesModel.fromJson(json.decode(responseString));
        _locations = placesModel.predictions;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 14.0),
        child: Column(
          children: <Widget>[
            Card(
              elevation: 4.0,
              margin: EdgeInsets.only(left: 10.0, right: 10.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2.0),
              ),
              child: Container(
                  margin: EdgeInsets.only(
                      top: 2.0, bottom: 2.0, left: 4.0, right: 4.0),
                  child: Column(children: <Widget>[
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            flex: 0,
                            child: IconButton(
                              onPressed: () {
                                if (Navigator.canPop(context)) {
                                  Navigator.pop(context);
                                }
                              },
                              icon: Icon(
                                Icons.arrow_back,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 60.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Icon(
                                  Icons.account_circle,
                                ),
                                Text(
                                  "Pour moi",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 19.0),
                                ),
                                Icon(Icons.keyboard_arrow_down,
                                    color: Colors.black),
                              ],
                            ),
                          ),
                        ]),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: Container(
                            height: 5.0,
                            width: 5.0,
                            decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFF0C60A8)),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: new TextField(
                            controller: _searchDestination,
                            enabled: true,
                            autofocus: true,
                            enableInteractiveSelection: true,
                            keyboardType: TextInputType.text,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 19.0,
                            ),
                            decoration: new InputDecoration(
                              contentPadding: EdgeInsets.all(12.0),
                              hintText: "Ou allez vous ?",
                              hintStyle: TextStyle(color: Colors.black26),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                            ),
                            onChanged: (text) {
                              if (text.isNotEmpty) {
                                _findLocation(text);
                                return;
                              } else {
                                setState(() {
                                  _searchDestination.text = "";
                                });
                              }
                            },
                          ),
                        ),
                        _searchDestination.text.isNotEmpty
                            ? Expanded(
                                flex: 0,
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _searchDestination.text = "";
                                    });
                                  },
                                  icon: Icon(Icons.clear, color: Colors.black),
                                ),
                              )
                            : Container(),
                      ],
                    ),

                    ///ou allez vous ?

                    Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: Container(
                            height: 5.0,
                            width: 5.0,
                            decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFFDEAC17)),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: new TextField(
                            enabled: false,
                            enableInteractiveSelection: true,
                            keyboardType: TextInputType.text,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 19.0,
                            ),
                            decoration: new InputDecoration(
                              contentPadding: EdgeInsets.all(12.0),
                              hintText: "Ou etes vous ?",
                              hintStyle: TextStyle(color: Colors.black26),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                            ),
                            onChanged: (text) {
                              if (text.isNotEmpty) {
                                _findLocation(text);
                                return;
                              } else {
                                setState(() {
                                  _searchPosition.text = "";
                                });
                              }
                            },
                          ),
                        ),
                        _searchPosition.text.isNotEmpty
                            ? Expanded(
                                flex: 0,
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _searchPosition.text = "";
                                    });
                                  },
                                  icon: Icon(Icons.clear, color: Colors.black),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ])),
            ),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.all(8.0),
                itemCount: _locations.length,
                itemBuilder: (context, index) {
                  String title = _locations[index].terms[0].value;
                  String subtitle = "";

                  for (int i = 1; i < _locations[index].terms.length; i++) {
                    subtitle = _locations[index].terms[i].value + ", ";
                  }
                  return ListTile(
                    leading: Icon(
                      Icons.location_on,
                      color: Colors.black,
                    ),
                    title: Text(
                      title,
                      style: TextStyle(color: Colors.black),
                    ),
                    subtitle: Text(subtitle),
                    onTap: () {
                      Navigator.of(context).pop(_locations[index]);
                      print("onTap Location item index=${index}");
                      print("Destinatiion Selected " +
                          _locations[index].description);
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
