import 'package:etakesh_client/Models/commande.dart';
import 'package:flutter/material.dart';

class DetailsCmdPage extends StatefulWidget {
  final CommandeDetail commande;
  DetailsCmdPage({Key key, this.commande}) : super(key: key);
  @override
  _DetailsCmdPageState createState() => _DetailsCmdPageState();
}

class _DetailsCmdPageState extends State<DetailsCmdPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text("Detail sur la commande",
            style: TextStyle(color: Colors.black)),
      ),
      body: ListView(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 125.0,
                width: 125.0,
                child: Center(
                  child: new Text(widget.commande.prestation.service.intitule,
                      style: TextStyle(color: Colors.black, fontSize: 20.0)),
                ),
              )
            ],
          ),
          ListTile(
            title: Text("Ou vous etes"),
            leading: Padding(
              padding: new EdgeInsets.symmetric(horizontal: 32.0 - 12.0 / 2),
              child: new Container(
                height: 5.0,
                width: 5.0,
                decoration: new BoxDecoration(
                    shape: BoxShape.circle, color: Colors.blue),
              ),
            ),
//            trailing: Text(widget.commande.date_debut),
//            subtitle: Text("Ville"),
          ),
          ListTile(
            title: Text("Destination"),
            leading: Padding(
              padding: new EdgeInsets.symmetric(horizontal: 32.0 - 12.0 / 2),
              child: new Container(
                height: 5.0,
                width: 5.0,
                decoration: new BoxDecoration(
                    shape: BoxShape.circle, color: Color(0xFFDEAC17)),
              ),
            ),
//            trailing: Text(widget.commande.date_debut),
//            subtitle: Text("Ville"),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 100),
            child: RaisedButton(
                color: widget.commande.is_accepted ? Colors.green : Colors.grey,
                child: Text(" TRACKING ",
                    style: TextStyle(
                        color: widget.commande.is_accepted
                            ? Colors.white
                            : Colors.black,
                        fontSize: 20.0)),
                padding: EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 10.0, bottom: 10.0),
                onPressed: () {}),
          )
        ],
      ),
    );
  }
}
