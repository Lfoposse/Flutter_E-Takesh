import 'package:flutter/material.dart';
import 'package:etakesh_client/pages/home_page.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:etakesh_client/Models/services.dart';

class LoginPage extends StatefulWidget {
  @override
  State createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final String url = "http://api.e-takesh.com:26960/api/Users/login";

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void showDialogSingleButton(
      BuildContext context, String title, String message, String buttonLabel) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(title),
          content: new Text(message),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text(buttonLabel),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<Login> requestLoginAPI(
      BuildContext context, String email, String password) async {
    Map<String, String> body = {
      'email': email,
      'password': password,
    };

    final response = await http.post(
      url,
      body: body,
      headers: {HttpHeaders.acceptHeader: "application/json"},
    );

    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
//   navigation avec le passage de donne en params
//      Login datasClient = Login.fromJson(responseJson);
      Navigator.push(context,
          new MaterialPageRoute(builder: (BuildContext context) => HomePage()));

      return Login.fromJson(responseJson);
    } else {
      showDialogSingleButton(
          context,
          "Impossible de se connecter",
          "La combinaison de votre 'Email'/'Mot de passe' est invalide. Veillez reessayer ou contacter notre equipe support",
          "OK");
      return null;
    }
  }

//  element of login page
  Widget logo = Container(
    margin: EdgeInsets.only(top: 0.0, left: 0.0, right: 0.0),
    padding: EdgeInsets.only(top: 0.0),
//    color: Colors.blue,
    child: Image.asset(
      'assets/images/login_icon.jpeg',
      height: 100.0,
      width: 90.0,
    ),
  );

  Widget forgotLabel = FlatButton(
    child: Text(
      "Si vous n'avez pas encore de compte cliquez ici",
      style: TextStyle(color: Colors.blueAccent),
    ),
    onPressed: () {},
  );

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: 60.0),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
              autofocus: false,
              decoration: InputDecoration(
                hintText: 'Email',
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
              ),
            ),
            SizedBox(height: 8.0),
            TextFormField(
              controller: _passwordController,
              autofocus: false,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Password',
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
              ),
            ),
            SizedBox(height: 24.0),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                onPressed: () {
                  requestLoginAPI(
                      context, _emailController.text, _passwordController.text);
                },
                padding: EdgeInsets.all(12),
                color: Colors.orange,
                child: Text('CONEXION', style: TextStyle(color: Colors.white)),
              ),
            ),
            forgotLabel
          ],
        ),
      ),
    );
  }
}
