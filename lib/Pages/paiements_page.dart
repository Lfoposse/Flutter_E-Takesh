import 'package:flutter/material.dart';

//class TarifsPage extends StatefulWidget {
//  @override
//  State createState() => TarifsPageState();
//}
//
//class TarifsPageState extends State<TarifsPage> implements ServiceContract {}
class PaiementPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          'Mes Paiements',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: new Center(
        child: new Text('Page des Paiements'),
      ),
    );
  }
}
