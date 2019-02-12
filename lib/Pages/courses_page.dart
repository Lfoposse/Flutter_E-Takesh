import 'package:flutter/material.dart';

class CoursesPage extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text('Vos courses'),backgroundColor: Colors.black87,),
      body: new Center(
        child: new Text('Visualiser mes courses'),
      ),
    );
  }
}