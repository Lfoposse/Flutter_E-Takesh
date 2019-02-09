import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
//import 'package:etakesh_client/model/services.dart';


class TarifsPage extends StatefulWidget {
  @override
  State createState() => TarifsPageState();
}

class TarifsPageState extends State<TarifsPage> {
  final String url = "http://api.e-takesh.com:26960/api/services?access_token=ORYTcHljQHxQHbUGxBJnUjmPZ58xrjMkXBnLBncw9yiNiz3RploBX1aRGeNCP19o";
//  final String token = "ORYTcHljQHxQHbUGxBJnUjmPZ58xrjMkXBnLBncw9yiNiz3RploBX1aRGeNCP19o";
  List services;

  @override
  void initState(){
    super.initState();
    this.getService();
  }

  Future<String> getService() async {
    final response =
    await http.get(Uri.encodeFull(url),headers: {"Accept": "application/json"});

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      setState(() {
        var convertDataToJson = json.decode(response.body);
        services = convertDataToJson;
      });
      return "Success";
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Tarifs des services'),
        backgroundColor: Colors.black87,
      ),
      body: ListView.builder(
          itemCount: services == null ? 0 : services.length,
          itemBuilder: (BuildContext context , int index){
            return new Center(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  new Card(
                    child: new Container(
                      child: new ListTile(
                        title: Text(services[index]['intitule']),
                        subtitle: Text(services[index]['prix'].toString()),
                      ),
//                      padding: const EdgeInsets.all(20.0),
                    ),
                  )
                ],
              ),
            );
          }
      )

    );
  }

}
