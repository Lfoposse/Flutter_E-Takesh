import 'package:flutter/material.dart';

class ParametersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(
            'Parametres du compte',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.black,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            children: <Widget>[
              new ListTile(
                  leading: new CircleAvatar(
                    child: new Image.asset("assets/images/avatar.png",
                        width: 30.0, height: 30.0),
                    radius: 32.0,
                    backgroundColor: Color(0xFFE2E2E2),
                  ),
                  title: new Text("Fotso Pierre",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                  subtitle: new Text("+237670548852\nclient1@gamail.com",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                  isThreeLine: true),
              Divider(
                height: 4.0,
                color: Color(0xFFE2E2E2),
              ),
              SizedBox(
                height: 10.0,
              ),
              ListTile(
                title:
                    new Text("Favoris", style: TextStyle(color: Colors.grey)),
              ),
              SizedBox(
                height: 0.0,
              ),
              ListTile(
                leading: Icon(
                  Icons.home,
                  color: Colors.black,
                ),
                title: new Text("Ajouter un domicile",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: 0.0,
              ),
              ListTile(
                leading: Icon(
                  Icons.business_center,
                  color: Colors.black,
                ),
                title: new Text("Ajouter une adresse professionnelle",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
              ),
              ListTile(
                title: new Text(
                  "Autres lieux enregistres",
                  style: TextStyle(color: Colors.lightBlueAccent),
                ),
              ),
              Divider(
                height: 4.0,
                color: Color(0xFFE2E2E2),
              ),
              ListTile(
                title: new Text("Parametres de confidentialite",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
                subtitle: new Text(
                  "Gerer les donnees que vous partagez avec nous",
                  style: TextStyle(
                      color: Colors.grey.withOpacity(0.7), fontSize: 12.0),
                ),
              ),
              Divider(
                height: 4.0,
                color: Color(0xFFE2E2E2),
              ),
              ListTile(
                title: new Text("Deconnexion",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        )));
  }
}
