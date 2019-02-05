import 'package:flutter/material.dart';
import 'package:etakesh_client/pages/home_page.dart';

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
            fit: BoxFit.cover,
          )),
        ),
        Container(
//          color: Colors.deepOrange,
          decoration: new BoxDecoration(
              image: new DecorationImage(
            image: new AssetImage('assets/images/presentation/Present2.png'),
            fit: BoxFit.cover,
          )),
        ),
        Container(
//          color: Colors.yellow[100],
          decoration: new BoxDecoration(
              image: new DecorationImage(
            image: new AssetImage('assets/images/presentation/Present3.png'),
            fit: BoxFit.cover,
          )),
        ),
        Container(
//          color: Colors.lightGreen,
          decoration: new BoxDecoration(
              image: new DecorationImage(
            image: new AssetImage('assets/images/presentation/Present4.png'),
            fit: BoxFit.cover,
          )),
        ),
        Container(
          color: Colors.white,
          child: ListView(
            children: <Widget>[
             new Image.asset(
                'assets/images/login.png',
                width: 600,
                height: 240,
                fit: BoxFit.cover,
              ),
            new RaisedButton(
                color: Colors.orange,
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: Text(
                  'CONNEXION',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 19.0),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    new MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
              ),
            new Text(
                "si vous n'aveez pas encore de compte cliquez ici",
                style: TextStyle(color: Colors.lightBlue, fontSize: 12.0),
              )
            ],
          ),
        )
      ],
    );
  }
}
