import 'package:flutter/material.dart';

class TarifsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Tarifs des services'),
        backgroundColor: Colors.black87,
      ),
      body: ListView.builder(
        itemCount: 4,
        itemBuilder: (context, l) {
          return new Column(
            children: <Widget>[
              buttonSection,
            ],
          );
        },
      ),
    );
  }

  //Element de tarif

  Widget buttonSection = Container(
      child: Row(
          children: <Widget>[
            _buildItem('Taxi Course', 'Facture par heure'),
            _buildItem('3000 XAF', 'heure'),
            _buildItem('3500 XAF', 'heure'),
          ],
        ),
  );

  static Column _buildItem(String title, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        new Text(
          title,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w400,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
