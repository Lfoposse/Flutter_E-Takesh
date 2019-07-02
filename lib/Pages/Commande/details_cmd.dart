import 'package:etakesh_client/Models/commande.dart';
import 'package:etakesh_client/Utils/Scan_qr_code.dart';
import 'package:etakesh_client/pages/Commande/tracking_prestataire.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailsCmdPage extends StatefulWidget {
  final CommandeDetail commande;
  DetailsCmdPage({Key key, this.commande}) : super(key: key);
  @override
  _DetailsCmdPageState createState() => _DetailsCmdPageState();
}

class _DetailsCmdPageState extends State<DetailsCmdPage> {
  GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  void initState() {
    super.initState();
    print("CMD Detail");
    print(widget.commande.position_destId);
    print(widget.commande.position_priseId);
  }

  Widget _snackSample() => SnackBar(
        content: Text(
          "Votre commande n'a pas encore été acceptée !!!",
          style: TextStyle(
            color: Color(0xFFDEAC17),
            fontSize: 14,
          ),
          textAlign: TextAlign.center,
        ),
        action: SnackBarAction(
          label: "OK",
          textColor: Color(0xFF0C60A8),
          onPressed: () {
            print("Cmd son acceptee");
          },
        ),
        backgroundColor: Colors.white,
        duration: Duration(milliseconds: 5000),
      );

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: _key,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text("Commande N° " + widget.commande.code,
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
                        shape: BoxShape.rectangle,
                        color: getStatusCommandValueColor(widget.commande)),
                    child: ListTile(
                      title: Text(getStatusCommand((widget.commande)),
                          style: TextStyle(color: Colors.white)),
                      subtitle: Text(
                          DateFormat("yyyy-MM-dd'T'HH:mm:ss")
                                  .parse(widget.commande.date.toString())
                                  .day
                                  .toString() +
                              "/" +
                              DateFormat("yyyy-MM-dd'T'HH:mm:ss")
                                  .parse(widget.commande.date.toString())
                                  .month
                                  .toString() +
                              "/" +
                              DateFormat("yyyy-MM-dd'T'HH:mm:ss")
                                  .parse(widget.commande.date.toString())
                                  .year
                                  .toString() +
                              " à " +
                              DateFormat("yyyy-MM-dd'T'HH:mm:ss")
                                  .parse(widget.commande.date.toString())
                                  .hour
                                  .toString() +
                              ":" +
                              DateFormat("yyyy-MM-dd'T'HH:mm:ss")
                                  .parse(widget.commande.date.toString())
                                  .minute
                                  .toString(),
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
              Padding(
                padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 50),
                child: widget.commande.is_accepted
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          RaisedButton(
                              color: Colors.green,
                              child: Text(" TRACKING ",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20.0)),
                              padding: EdgeInsets.only(
                                  left: 15.0,
                                  right: 15.0,
                                  top: 10.0,
                                  bottom: 10.0),
                              onPressed: () {
                                if (widget.commande.is_accepted == true) {
                                  Navigator.of(context)
                                      .push(new MaterialPageRoute(
                                          builder: (context) => TrackingPage(
                                                commande: widget.commande,
                                              )));
                                }
                              }),
                          RaisedButton(
                              color: Color(0xFF0C60A8),
                              child: Text(" QR-CODE SCAN ",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20.0)),
                              padding: EdgeInsets.only(
                                  left: 15.0,
                                  right: 15.0,
                                  top: 10.0,
                                  bottom: 10.0),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) => ScanScreen()),
                                );
                              })
                        ],
                      )
                    : RaisedButton(
                        color: widget.commande.is_accepted
                            ? Colors.green
                            : Colors.grey,
                        child: Text(" TRACKING ",
                            style: TextStyle(
                                color: widget.commande.is_accepted
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 20.0)),
                        padding: EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 10.0, bottom: 10.0),
                        onPressed: () {
                          if (widget.commande.is_accepted == true) {
                            Navigator.of(context).push(new MaterialPageRoute(
                                builder: (context) => TrackingPage(
                                      commande: widget.commande,
                                    )));
                          } else {
                            final bar = _snackSample();
                            _key.currentState.showSnackBar(bar);
                          }
                        }),
              )
            ],
          )
        ],
      ),
    );
  }

  String getStatusCommand(CommandeDetail cmd) {
    if (cmd.is_created == true &&
        cmd.is_accepted == false &&
        cmd.is_refused == false) return "Commande en cours";
    if (cmd.is_accepted == true &&
        cmd.is_created == true &&
        cmd.is_refused == false) return "Commande validee";
    if (cmd.is_refused == true &&
        cmd.is_created == true &&
        cmd.is_accepted == false) return "Commande refusee";
    if (cmd.is_terminated == true && cmd.is_created == true)
      return "Commande terminee";
  }

  Color getStatusCommandValueColor(CommandeDetail cmd) {
    if (cmd.is_created == true &&
        cmd.is_accepted == false &&
        cmd.is_refused == false) return Color(0xFFDEAC17);
    if (cmd.is_accepted == true &&
        cmd.is_created == true &&
        cmd.is_refused == false) return Color(0xFF0C60A8);
    if (cmd.is_refused == true &&
        cmd.is_created == true &&
        cmd.is_accepted == false) return Color(0xFFC72230);
    if (cmd.is_terminated == true && cmd.is_created == true)
      return Color(0xFF33B841);
  }
}
