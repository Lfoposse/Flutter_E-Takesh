import 'package:etakesh_client/Presentation/presentation.dart';
import 'package:etakesh_client/Utils/AppSharedPreferences.dart';
import 'package:etakesh_client/pages/FirstLaunch/main_page.dart';
import 'package:etakesh_client/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'theme.dart';

//
void main() {
  runApp(MyApp());
  SystemChrome.setSystemUIOverlayStyle(lightSystemUiOverlayStyle);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Etakesh Client',
      theme: buildThemeData(),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => new _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    AppSharedPreferences().isAppFirstLaunch().then((bool1) {
      if (bool1 == true) {
        // on presente l'appli
        Navigator.pushReplacement(context,
            new MaterialPageRoute(builder: (BuildContext context) {
          return Presentation();
        }));
      } else {
//        Navigator.pushReplacement(context,
//            new MaterialPageRoute(builder: (BuildContext context) {
//          return LoginPage();
//        }));

        AppSharedPreferences().isAppLoggedIn().then((bool2) {
          if (bool2 == false) {
            Navigator.pushReplacement(context,
                new MaterialPageRoute(builder: (BuildContext context) {
              return MainLaunchPage();
            }));
          } else {
            Navigator.pushReplacement(context,
                new MaterialPageRoute(builder: (BuildContext context) {
              return HomePage();
            }));
          }
        }, onError: (e) {});
      }
    }, onError: (e) {
      AppSharedPreferences().setAppFirstLaunch(true);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
//    return new AnimatedBuilder(builder: (context, _) {
    return Material(
      color: Colors.white,
    );
//    });
  }
}

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
//  final controler = PageController(
//    initialPage: 0,
//  );
//
////  texte d'entete'
//  Widget headertext(String datas) {
//    return Text(
//      datas,
//      style: TextStyle(
//          color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold),
//    );
//  }
//
////bar de recherche
//  Widget researchBox(
//      String hintText, Color bgdColor, Color textColor, Color borderColor) {
//    return Container(
//      height: double.infinity,
//      padding: EdgeInsets.only(left: 10.0, right: 10.0),
//      decoration: new BoxDecoration(
//          color: bgdColor,
//          border: new Border(
//            top: BorderSide(
//                color: borderColor, style: BorderStyle.solid, width: 1.0),
//            bottom: BorderSide(
//                color: borderColor, style: BorderStyle.solid, width: 1.0),
//            left: BorderSide(
//                color: borderColor, style: BorderStyle.solid, width: 1.5),
//            right: BorderSide(
//                color: borderColor, style: BorderStyle.solid, width: 1.5),
//          )),
//      child: Row(children: [
//        Icon(Icons.crop_square, color: textColor, size: 20.0),
//        Expanded(
//            child: Container(
//                child: TextFormField(
//                    autofocus: false,
//                    autocorrect: false,
//                    keyboardType: TextInputType.text,
//                    decoration: InputDecoration(
//                        border: InputBorder.none,
//                        hintText: hintText,
//                        hintStyle: TextStyle(color: textColor)),
//                    style: TextStyle(
//                      fontSize: 14.0,
//                      color: textColor,
//                      fontWeight: FontWeight.bold,
//                    ))))
//      ]),
//    );
//  }
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
//            image: new AssetImage('assets/images/presentation/Present1.png'),
//            fit: BoxFit.contain,
//          )),
////          child: Row(
////            children: <Widget>[
////              headertext('Dites-nous ou vous allez'),
////              researchBox("Ou allez-vous ?", Colors.white, Colors.black87,
////                  Colors.black),
////            ],
////          ),
//        ),
//        Container(
////          color: Colors.deepOrange,
//          decoration: new BoxDecoration(
//              image: new DecorationImage(
//            image: new AssetImage('assets/images/presentation/Present2.png'),
//            fit: BoxFit.contain,
//          )),
////          child: Row(
////            children: <Widget>[
////              headertext('Commandez votre chauffeur,24h/24,7j/7'),
////            ],
////          ),
//        ),
//        Container(
////          color: Colors.yellow[100],
//          decoration: new BoxDecoration(
//              image: new DecorationImage(
//            image: new AssetImage('assets/images/presentation/Present3.png'),
//            fit: BoxFit.contain,
//          )),
////          child: Row(
////            children: <Widget>[
////              headertext("Nous vous indiquons le prix a l'avance"),
////            ],
////          ),
//        ),
//        Container(
//          child: Padding(
//            padding: EdgeInsets.all(0.0),
//            child: Container(
//              decoration: new BoxDecoration(
//                  image: new DecorationImage(
//                image:
//                    new AssetImage('assets/images/presentation/Present4.png'),
//                fit: BoxFit.contain,
//              )),
//              child: Row(
//                children: <Widget>[
//                  RaisedButton.icon(
//                    onPressed: () {
//                      Navigator.push(
//                          context,
//                          new MaterialPageRoute(
//                              builder: (BuildContext context) => LoginPage()));
//                    },
//                    icon: Icon(
//                      Icons.skip_next,
//                      color: Colors.orange,
//                    ),
//                    label: Text('Log'),
//                  )
//                ],
//              ),
//            ),
//          ),
//        )
//      ],
//    );
//  }
//}
