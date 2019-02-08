import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:etakesh_client/model/services.dart';

class TarifsPage extends StatelessWidget {

  Future<Service> getService() async {
    final response =
    await http.get('http://api.e-takesh.com:26960/api/services/2?access_token=ORYTcHljQHxQHbUGxBJnUjmPZ58xrjMkXBnLBncw9yiNiz3RploBX1aRGeNCP19o');

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return Service.fromJson(json.decode(response.body));
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
      body: FutureBuilder<Service>(
        future: getService(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                new Text(
                  snapshot.data.intitule,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  child: Text(
                    snapshot.data.prix.toString(),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          // By default, show a loading spinner
          return CircularProgressIndicator();
        },
      ),

//      ListView.builder(
//        itemCount: 4,
//        itemBuilder: (context, l) {
//          return new Column(
//            children: <Widget>[
//              buttonSection,
//            ],
//          );
//        },
//      ),

    );
  }

  //Element de tarif

//  Widget buttonSection = Container(
//      child: Row(
//          children: <Widget>[
//            _buildItem('Taxi Course', 'Facture par heure'),
//            _buildItem('3000 XAF', 'heure'),
//            _buildItem('3500 XAF', 'heure'),
//          ],
//        ),
//  );

//  static Column _buildItem(String title, String label) {
//    return Column(
//      mainAxisSize: MainAxisSize.min,
//      mainAxisAlignment: MainAxisAlignment.center,
//      children: [
//        new Text(
//          title,
//          style: TextStyle(
//            fontSize: 22,
//            fontWeight: FontWeight.w400,
//          ),
//        ),
//        Container(
//          margin: const EdgeInsets.only(top: 8),
//          child: Text(
//            label,
//            style: TextStyle(
//              fontSize: 12,
//              fontWeight: FontWeight.w400,
//            ),
//          ),
//        ),
//      ],
//    );
//  }
}
