import 'package:flutter/material.dart';
import 'package:etakesh_client/pages/login_page.dart';

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
        Scaffold(
          body: Padding(
            padding: EdgeInsets.all(0.0),
            child: Container(
              decoration: new BoxDecoration(
                  image: new DecorationImage(
                image:
                    new AssetImage('assets/images/presentation/Present4.png'),
                fit: BoxFit.cover,
              )),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.orange,
            mini: true,
            onPressed: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (BuildContext context) => LoginPage()));
            },
            child: Icon(Icons.play_circle_filled),
          ),
        )
      ],
    );
  }
}
