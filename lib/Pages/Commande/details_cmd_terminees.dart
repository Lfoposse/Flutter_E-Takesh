import 'package:etakesh_client/Models/commande.dart';
import 'package:flutter/material.dart';

class DetailsCmdTerminePage extends StatefulWidget {
  final CommandeDetail commande;
  DetailsCmdTerminePage({Key key, this.commande}) : super(key: key);
  @override
  _DetailsCmdTerminePageState createState() => _DetailsCmdTerminePageState();
}

class _DetailsCmdTerminePageState extends State<DetailsCmdTerminePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text("Commande N°" + widget.commande.code,
            style: TextStyle(color: Colors.black, fontSize: 16.0)),
      ),
      body: Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Center(
                      child: Container(
                    height: 170.0,
                    width: 170.0,
                    margin: EdgeInsets.only(top: 10.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(80.0),
                        image: DecorationImage(
                            image: NetworkImage(
                                widget.commande.prestation.vehicule.image),
                            fit: BoxFit.cover),
                        boxShadow: [
                          BoxShadow(blurRadius: 7.0, color: Colors.black)
                        ]),
                  )),
                  Positioned(
                    bottom: 110.0,
                    right: 105.0,
                    child: Container(
                      height: 60.0,
                      width: 60.0,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30.0),
                          image: DecorationImage(
                              image: NetworkImage(
                                  widget.commande.prestation.prestataire.image),
                              fit: BoxFit.fill),
                          boxShadow: [
                            BoxShadow(blurRadius: 7.0, color: Colors.black)
                          ]),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Center(
                child: Text(
                  "Mr " + widget.commande.prestation.prestataire.nom,
                  style: TextStyle(color: Colors.black, fontSize: 20.0),
                ),
              ),
              SizedBox(height: 10.0),
              Center(
                child: Text(
                  "Service : " + widget.commande.prestation.service.intitule,
                  style: TextStyle(color: Colors.black87, fontSize: 20.0),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ListTile(
                    title: Text(widget.commande.position_prise_en_charge),
                    leading: Padding(
                      padding:
                          new EdgeInsets.symmetric(horizontal: 32.0 - 12.0 / 2),
                      child: new Container(
                        height: 10.0,
                        width: 10.0,
                        decoration: new BoxDecoration(
                            shape: BoxShape.circle, color: Colors.blue),
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text(widget.commande.position_destination),
                    leading: Padding(
                      padding:
                          new EdgeInsets.symmetric(horizontal: 32.0 - 12.0 / 2),
                      child: new Container(
                        height: 10.0,
                        width: 10.0,
                        decoration: new BoxDecoration(
                            shape: BoxShape.circle, color: Color(0xFFDEAC17)),
                      ),
                    ),
                  ),
                  Container(
                    margin:
                        EdgeInsets.only(left: 25.0, right: 25.0, bottom: 5.0),
                    decoration: new BoxDecoration(
                        shape: BoxShape.rectangle, color: Color(0xFF33B841)),
                    child: ListTile(
                      title: Text("Commande terminée",
                          style: TextStyle(color: Colors.white)),
                      subtitle: Text(widget.commande.date.toString(),
                          style: TextStyle(color: Colors.white)),
                      trailing: Text(
                          widget.commande.prestation.service.prix.toString() +
                              " XAF",
                          style:
                              TextStyle(color: Colors.white, fontSize: 16.0)),
                    ),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
