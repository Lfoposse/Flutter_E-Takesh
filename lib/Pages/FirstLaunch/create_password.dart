import 'dart:convert';
import 'dart:io';

import 'package:etakesh_client/DAO/Rest_dt.dart';
import 'package:etakesh_client/Utils/AppSharedPreferences.dart';
import 'package:etakesh_client/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class CreatePassWordPage extends StatefulWidget {
  final String phone_n;
  final String email;
  final String nom;
  final String prenom;
  final String d_naissance;
  final String ville;
  CreatePassWordPage(
      {Key key,
      this.phone_n,
      this.email,
      this.nom,
      this.prenom,
      this.ville,
      this.d_naissance})
      : super(key: key);
  @override
  _CreatePassWordPageState createState() => _CreatePassWordPageState();
}

class _CreatePassWordPageState extends State<CreatePassWordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _agreedToTOS = true;
  var _passwordController = TextEditingController();
  var _confirmPassController = TextEditingController();
  RestDatasource api = new RestDatasource();
  @override
  void initState() {
    // TODO: implement initState
    print(this.widget.phone_n);
    print(this.widget.email);
    print(this.widget.nom);
    print(this.widget.prenom);
    print(this.widget.d_naissance);
    print(this.widget.ville);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFF0C60A8),
          foregroundColor: Colors.white,
          child: Icon(Icons.arrow_forward),
          tooltip: "Adresse email",
          onPressed: _submittable() ? _submit : null),
      appBar: AppBar(
        title: const Text('Mot de passe'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: new SafeArea(
        top: false,
        bottom: false,
        child: Form(
          key: _formKey,
          child: new ListView(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Container(
                    margin: EdgeInsets.only(bottom: 50.0, top: 50.0),
                    alignment: Alignment.center,
                    child: Text(
                      "Creez un mot de passe pour votre compte",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.w300),
                    )),
              ),
              new TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Mot de passe',
                  icon: Icon(
                    Icons.enhanced_encryption,
                    color: Colors.black,
                  ),
                ),
                obscureText: true,
                keyboardType: TextInputType.text,
                validator: validatePassword,
              ),
              new TextFormField(
                controller: _confirmPassController,
                decoration: const InputDecoration(
                  labelText: 'Confirmer votre mot de passe',
                  icon: Icon(
                    Icons.enhanced_encryption,
                    color: Colors.black,
                  ),
                ),
                obscureText: true,
                keyboardType: TextInputType.text,
                validator: validatePasswordMatching,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  children: <Widget>[
                    Checkbox(
                      activeColor: Color(0xFF0C60A8),
                      value: _agreedToTOS,
                      onChanged: _setAgreedToTOS,
                    ),
                    GestureDetector(
                      onTap: () => _setAgreedToTOS(!_agreedToTOS),
                      child: const Text(
                        "J'accepte les conditions d'utilisation \nde l'application E-Takesh",
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String validatePassword(String value) {
    if (value.length == 0) {
      return "Mot de passe obligatoire";
    } else if (value.length < 6) {
      return "Le Mot de passe doit comporter au moins 6 caracteres";
    }
    return null;
  }

  String validatePasswordMatching(String value) {
    if (value.length == 0) {
      return "Confirmation vide";
    } else if (value != _passwordController.text) {
      return 'Ne correspond pas avec le mot de passe entre precdement';
    }
    return null;
  }

  bool _submittable() {
    return _agreedToTOS;
  }

  void _submit() {
    if (_formKey.currentState.validate()) {
      createUser();
    }
  }

  Future createUser() async {
//    on creer le User
    final response1 = await http.post(
      Uri.encodeFull("http://api.e-takesh.com:26960/api/Users"),
      body: {"email": this.widget.email, "password": _passwordController.text},
      headers: {HttpHeaders.acceptHeader: "application/json"},
    );

    if (response1.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      var convertDataToJson1 = json.decode(response1.body);
      print(convertDataToJson1["email"]);
      print(convertDataToJson1["id"]);
//    on connecte le User pour avoir le Token
      final response2 = await http.post(
        Uri.encodeFull("http://api.e-takesh.com:26960/api/Users/login"),
        body: {
          "email": this.widget.email,
          "password": _passwordController.text
        },
        headers: {HttpHeaders.acceptHeader: "application/json"},
      );

      if (response2.statusCode == 200) {
//        on utilise le token pour creer le client en question

        var convertDataToJson2 = json.decode(response2.body);
        print("Token");
        print(convertDataToJson2["id"]);
        final response3 = await http.post(
          Uri.encodeFull(
              "http://api.e-takesh.com:26960/api/clients?access_token=" +
                  convertDataToJson2["id"]),
          body: {
            "UserId": convertDataToJson1["id"].toString(),
            "email": this.widget.email,
            "password": _passwordController.text,
            "nom": this.widget.nom,
            "prenom": this.widget.prenom,
            "telephone": this.widget.phone_n,
            "ville": this.widget.ville,
            "date_naissance": "1990-01-02",
            "status": "Creer",
            "pays": "Cameroun"
          },
          headers: {HttpHeaders.acceptHeader: "application/json"},
        );
        if (response3.statusCode == 200) {
//          redirige a la page de connexion
          AppSharedPreferences().setAccountCreate(true);
          Navigator.push(
            context,
            new MaterialPageRoute(builder: (context) => LoginPage()),
          );
        } else {
          // If that call was not successful, throw an error.
          throw Exception(
              'Erreur de creation du client' + response3.body.toString());
        }
      } else {
        // If that call was not successful, throw an error.
        throw Exception(
            'Erreur de connexion du User' + response2.body.toString());
      }
    } else {
      // If that call was not successful, throw an error.
      throw Exception(
          'Erreur de creation du User' + response1.statusCode.toString());
    }
  }

  void _setAgreedToTOS(bool newValue) {
    setState(() {
      _agreedToTOS = newValue;
    });
  }
}