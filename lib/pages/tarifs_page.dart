import 'dart:convert';
import 'dart:io';

import 'package:etakesh_client/Models/services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TarifsPage extends StatefulWidget {
  @override
  State createState() => TarifsPageState();
}

class TarifsPageState extends State<TarifsPage> {
  final String url = "http://api.e-takesh.com:26960/api/services";
  final String token =
      "?access_token=qo4zzroXKByPdTX7AsAdZNOORyTlJ60FSFcHRqmXK9DTgigallXgCMCHLV29j8hp";

  Future<List<Service1>> getPost() async {
    final response = await http.get(
      Uri.encodeFull(url + token),
      headers: {HttpHeaders.acceptHeader: "application/json"},
    );

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON

      var convertDataToJson = json.decode(response.body);
      List<Service1> services = [];

      for (var p in convertDataToJson) {
        Service1 serv = Service1.fromJson(p);
        services.add(serv);
      }
      return services;
    } else {
      // If that call was not successful, throw an error.
      throw Exception(
          'Failed to load services error' + response.statusCode.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Tarifs des services'),
        backgroundColor: Colors.black87,
      ),
      body: Container(
        child: FutureBuilder(
          future: getPost(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return new Center(
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          new Card(
                            child: new Container(
                              child: new ListTile(
                                title: Text(snapshot.data[index].intitule),
                                subtitle: Text(
                                    snapshot.data[index].prix.toString() +
                                        ' XAF'),
                              ),
                              padding: const EdgeInsets.all(20.0),
                            ),
                          )
                        ],
                      ),
                    );
                  });
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // By default, show a loading spinner
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
