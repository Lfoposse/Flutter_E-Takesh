import 'package:flutter/material.dart';

class ParametersPage extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text('Parametres du compte'),backgroundColor: Colors.black87,),
      body: new Center(
        child: new Text('Consulter mes parametres'),
      ),
    );
  }
}