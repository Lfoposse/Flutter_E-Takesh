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
  @override
  Widget build(BuildContext context) {
    return PageView(
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        Container(
          decoration: new BoxDecoration(
              image: new DecorationImage(
            image: new AssetImage('assets/images/presentation/Present1.png'),
            fit: BoxFit.cover,
          )),
        ),
        Container(
          decoration: new BoxDecoration(
              image: new DecorationImage(
            image: new AssetImage('assets/images/presentation/Present2.png'),
            fit: BoxFit.cover,
          )),
        ),
        Container(
          decoration: new BoxDecoration(
              image: new DecorationImage(
            image: new AssetImage('assets/images/presentation/Present3.png'),
            fit: BoxFit.cover,
          )),
        ),
        Container(
          decoration: new BoxDecoration(
              image: new DecorationImage(
            image: new AssetImage('assets/images/presentation/Present4.png'),
            fit: BoxFit.cover,
          )),
        ),
      ],
    );
  }
}
