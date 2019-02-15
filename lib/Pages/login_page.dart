import 'dart:convert';
import 'dart:io';

import 'package:etakesh_client/Models/services.dart';
import 'package:etakesh_client/Utils/SelectCountryWidget.dart';
import 'package:etakesh_client/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  State createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  SelectCountry _selectContry;

  final String url = "http://api.e-takesh.com:26960/api/Users/login";

  LoginPageState() {
    _selectContry = SelectCountry(false, "cm");
  }
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
//pas de compte

  Widget sinscrire = Container(
      padding: EdgeInsets.only(left: 24.0, right: 24.0),
      child: Row(children: <Widget>[
        new RichText(
          text: new TextSpan(
            children: [
              new TextSpan(
                  text: "Si vous n avez pas encore de compte creer",
                  style: new TextStyle(
                    color: Colors.lightBlue,
                    fontSize: 13.0,
                    fontWeight: FontWeight.w300,
                  )),
            ],
          ),
        ),
        Flexible(
          child: Text("ici",
              style: new TextStyle(
                color: Colors.yellow,
                decoration: TextDecoration.underline,
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
              )),
          flex: 6,
        ),
      ]));

//  element of login page
  Widget logo = Container(
    height: 350.0,
    margin: EdgeInsets.only(top: 0.0, left: 0.0, right: 0.0),
    padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0, bottom: 20.0),
    color: Colors.blue,
    child:
        Image.asset('assets/images/login_icon.jpeg', height: 15.0, width: 15.0),
  );

  Widget textheader = Container(
    margin: EdgeInsets.only(top: 20.0, bottom: 20.0, right: 20.0, left: 20.0),
//    padding: EdgeInsets.only(left: 24.0, right: 24.0),
    child: new Text('Deplacez-vous avec e-Takesh',
        style: new TextStyle(
          color: Colors.black54,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        )),
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
          children: <Widget>[
            logo,
            textheader,
            Padding(
              padding: EdgeInsets.only(left: 24.0, right: 24.0),
              child: Row(children: <Widget>[
                new Flexible(
                  child: _selectContry,
                  flex: 5,
                ),
                SizedBox(width: 8.0),
                new Flexible(
                  child: TextFormField(
                    controller: _phoneController,
                    autofocus: false,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Telephone",
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    ),
                  ),
                  flex: 6,
                ),
              ]),
            ),
            SizedBox(height: 10.0),
            Padding(
              padding: EdgeInsets.only(left: 24.0, right: 24.0),
//              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (BuildContext context) => HomePage()));
                },
                padding: EdgeInsets.all(12),
                color: Colors.orange,
                child: Text('CONEXION', style: TextStyle(color: Colors.white)),
              ),
            ),
            SizedBox(height: 20.0),
            sinscrire
          ],
        ),
      ),
    );
  }
}
//            TextFormField(
//              keyboardType: TextInputType.emailAddress,
//              controller: _emailController,
//              autofocus: false,
//              decoration: InputDecoration(
//                hintText: 'Email',
//                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//                border: OutlineInputBorder(
//                    borderRadius: BorderRadius.circular(32.0)),
//              ),
//            ),
//            SizedBox(height: 8.0),
//            TextFormField(
//              controller: _passwordController,
//              autofocus: false,
//              obscureText: true,
//              decoration: InputDecoration(
//                hintText: 'Password',
//                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//                border: OutlineInputBorder(
//                    borderRadius: BorderRadius.circular(32.0)),
//              ),
//            ),

//import 'package:etakesh_client/pages/home_page.dart';
//import 'package:flutter/material.dart';
//
//void main() => runApp(MyApp());
//
//class MyApp extends StatelessWidget {
//  // This widget is the root of your application.
//
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      debugShowCheckedModeBanner: false,
//      title: 'Flutter Demo',
//      theme: ThemeData(
//        // This is the theme of your application.
//        primarySwatch: Colors.blue,
//      ),
//      home: MyHomePage(title: 'E-Takesh Client App'),
//    );
//  }
//}
//
//void showDialogSingleButton(
//    BuildContext context, String title, String message, String buttonLabel) {
//  // flutter defined function
//  showDialog(
//    context: context,
//    builder: (BuildContext context) {
//      // return object of type Dialog
//      return AlertDialog(
//        title: new Text(title),
//        content: new Text(message),
//        actions: <Widget>[
//          // usually buttons at the bottom of the dialog
//          new FlatButton(
//            child: new Text(buttonLabel),
//            onPressed: () {
//              Navigator.of(context).pop();
//            },
//          ),
//        ],
//      );
//    },
//  );
//}
//
//class MyHomePage extends StatefulWidget {
//  MyHomePage({Key key, this.title}) : super(key: key);
//
//  final String title;
//
//  @override
//  _MyHomePageState createState() => _MyHomePageState();
//}
//
//class _MyHomePageState extends State<MyHomePage> {
//  final TextEditingController _emailController = TextEditingController();
//  final TextEditingController _passwordController = TextEditingController();
//
//  final controler = PageController(
//    initialPage: 0,
//  );
//
////  element of login page
//  final logo = Container(
//    margin: EdgeInsets.only(top: 0.0, left: 0.0, right: 0.0),
//    padding: EdgeInsets.only(top: 0.0),
////    color: Colors.blue,
//    child: Image.asset(
//      'assets/images/login_icon.jpeg',
//      height: 100.0,
//      width: 90.0,
//    ),
//  );
//
//  final email = TextFormField(
//    keyboardType: TextInputType.emailAddress,
//    autofocus: false,
//    initialValue: 'wilfried@rainbowcl.net',
//    decoration: InputDecoration(
//      hintText: 'Email',
//      contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//      border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
//    ),
//  );
//
//  final password = TextFormField(
//    autofocus: false,
//    initialValue: '123456789',
//    obscureText: true,
//    decoration: InputDecoration(
//      hintText: 'Password',
//      contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//      border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
//    ),
//  );
//
//  final forgotLabel = FlatButton(
//    child: Text(
//      "Si vous n'avez pas encore de compte cliquez ici",
//      style: TextStyle(color: Colors.blueAccent),
//    ),
//    onPressed: () {},
//  );
//
////  end elts login
//  @override
//  Widget build(BuildContext context) {
//    return PageView(
//      controller: controler,
//      scrollDirection: Axis.horizontal,
//      children: <Widget>[
//        Container(
////          color: Colors.deepPurpleAccent,
//          decoration: new BoxDecoration(
//              image: new DecorationImage(
//                image: new AssetImage('assets/images/presentation/Present1.png'),
//                fit: BoxFit.cover,
//              )),
//        ),
//        Container(
////          color: Colors.deepOrange,
//          decoration: new BoxDecoration(
//              image: new DecorationImage(
//                image: new AssetImage('assets/images/presentation/Present2.png'),
//                fit: BoxFit.cover,
//              )),
//        ),
//        Container(
////          color: Colors.yellow[100],
//          decoration: new BoxDecoration(
//              image: new DecorationImage(
//                image: new AssetImage('assets/images/presentation/Present3.png'),
//                fit: BoxFit.cover,
//              )),
//        ),
//        Container(
////          color: Colors.lightGreen,
//          decoration: new BoxDecoration(
//              image: new DecorationImage(
//                image: new AssetImage('assets/images/presentation/Present4.png'),
//                fit: BoxFit.cover,
//              )),
//        ),
//        Scaffold(
//          backgroundColor: Colors.white,
//          body: Center(
//            child: ListView(
//              shrinkWrap: true,
//              padding: EdgeInsets.only(left: 24.0, right: 24.0),
//              children: <Widget>[
//                logo,
//                SizedBox(height: 60.0),
//                email,
//                SizedBox(height: 8.0),
//                password,
//                SizedBox(height: 24.0),
//                Padding(
//                  padding: EdgeInsets.symmetric(vertical: 16.0),
//                  child: RaisedButton(
//                    shape: RoundedRectangleBorder(
//                      borderRadius: BorderRadius.circular(10),
//                    ),
//                    onPressed: () {
//                      Navigator.push(
//                          context,
//                          new MaterialPageRoute(
//                              builder: (BuildContext context) => HomePage()));
//                    },
//                    padding: EdgeInsets.all(12),
//                    color: Colors.orange,
//                    child:
//                    Text('CONEXION', style: TextStyle(color: Colors.white)),
//                  ),
//                ),
//                forgotLabel
//              ],
//            ),
//          ),
//        ),
//      ],
//    );
//  }
//}
