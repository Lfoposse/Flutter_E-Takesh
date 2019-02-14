import 'package:etakesh_client/pages/login_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'E-Takesh Client App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final controler = PageController(
    initialPage: 0,
  );

//  texte d'entete'
  Widget headertext(String datas) {
    return Text(
      datas,
      style: TextStyle(
          color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold),
    );
  }

//bar de recherche
  Widget researchBox(
      String hintText, Color bgdColor, Color textColor, Color borderColor) {
    return Container(
      height: double.infinity,
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
      decoration: new BoxDecoration(
          color: bgdColor,
          border: new Border(
            top: BorderSide(
                color: borderColor, style: BorderStyle.solid, width: 1.0),
            bottom: BorderSide(
                color: borderColor, style: BorderStyle.solid, width: 1.0),
            left: BorderSide(
                color: borderColor, style: BorderStyle.solid, width: 1.5),
            right: BorderSide(
                color: borderColor, style: BorderStyle.solid, width: 1.5),
          )),
      child: Row(children: [
        Icon(Icons.crop_square, color: textColor, size: 20.0),
        Expanded(
            child: Container(
                child: TextFormField(
                    autofocus: false,
                    autocorrect: false,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: hintText,
                        hintStyle: TextStyle(color: textColor)),
                    style: TextStyle(
                      fontSize: 14.0,
                      color: textColor,
                      fontWeight: FontWeight.bold,
                    ))))
      ]),
    );
  }

//  end elts login
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: controler,
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        Container(
//          color: Colors.deepPurpleAccent,
          decoration: new BoxDecoration(
              image: new DecorationImage(
            image: new AssetImage('assets/images/presentation/Present1.png'),
            fit: BoxFit.contain,
          )),
//          child: Row(
//            children: <Widget>[
//              headertext('Dites-nous ou vous allez'),
//              researchBox("Ou allez-vous ?", Colors.white, Colors.black87,
//                  Colors.black),
//            ],
//          ),
        ),
        Container(
//          color: Colors.deepOrange,
          decoration: new BoxDecoration(
              image: new DecorationImage(
            image: new AssetImage('assets/images/presentation/Present2.png'),
            fit: BoxFit.contain,
          )),
//          child: Row(
//            children: <Widget>[
//              headertext('Commandez votre chauffeur,24h/24,7j/7'),
//            ],
//          ),
        ),
        Container(
//          color: Colors.yellow[100],
          decoration: new BoxDecoration(
              image: new DecorationImage(
            image: new AssetImage('assets/images/presentation/Present3.png'),
            fit: BoxFit.contain,
          )),
//          child: Row(
//            children: <Widget>[
//              headertext("Nous vous indiquons le prix a l'avance"),
//            ],
//          ),
        ),
        Container(
          child: Padding(
            padding: EdgeInsets.all(0.0),
            child: Container(
              decoration: new BoxDecoration(
                  image: new DecorationImage(
                image:
                    new AssetImage('assets/images/presentation/Present4.png'),
                fit: BoxFit.contain,
              )),
              child: Row(
                children: <Widget>[
                  RaisedButton.icon(
                    onPressed: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (BuildContext context) => LoginPage()));
                    },
                    icon: Icon(
                      Icons.skip_next,
                      color: Colors.orange,
                    ),
                    label: Text('Log'),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

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
