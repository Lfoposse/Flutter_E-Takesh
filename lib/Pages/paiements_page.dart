import 'package:flutter/material.dart';

class PaiementPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Vos Paiements'),
        backgroundColor: Colors.black87,
      ),
      body: new Center(
        child: new Text('Page des Paiements'),
      ),
    );
  }
}
