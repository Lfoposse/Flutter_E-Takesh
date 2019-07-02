import 'dart:async';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:etakesh_client/DAO/Rest_dt.dart';
import 'package:etakesh_client/Database/DatabaseHelper.dart';
import 'package:etakesh_client/Models/commande.dart';
import 'package:etakesh_client/Utils/AppSharedPreferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ScanScreen extends StatefulWidget {
  @override
  _ScanState createState() => new _ScanState();
}

class _ScanState extends State<ScanScreen> {
  String barcode = "";
  bool _error = false;
  String _token;
  List<CommandeLocal> _cmdLocal;
  RestDatasource api = new RestDatasource();
//stripeAllozoe:pk_live_eo4MYvhD0gazKbeMzchjmrSU
  @override
  initState() {
    super.initState();
    AppSharedPreferences().getToken().then((String token1) {
      if (token1 != '') {
        _token = token1;
        DatabaseHelper().getCmdVal().then((List<CommandeLocal> cmdlocal) {
          if (cmdlocal != null) {
            _cmdLocal = cmdlocal;
          }
        });
      }
    }).catchError((err) {
      print("Not get Token " + err.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text(
            'QR Code Scanner',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.black,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: RaisedButton(
                    color: Color(0xFF33B841),
                    textColor: Colors.white,
                    splashColor: Colors.greenAccent,
                    onPressed: scan,
                    child: const Text('LANCER LE SCAN')),
              ),
              SizedBox(
                height: 35.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  barcode,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: _error ? Colors.red : Colors.blue,
                      fontSize: _error ? 18.0 : 22.0),
                ),
              ),
            ],
          ),
        ));
  }

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();

      if (_cmdLocal.length != 0) {
        for (int i = 0; i < _cmdLocal.length; i++) {
          if (_cmdLocal[i].code == barcode) {
            print("Cmd matching");
            print(_cmdLocal[i].commandeId);
            setState(() {
              _error = false;
              this.barcode = barcode;
              api
                  .updateCmdStatusToStart(_cmdLocal[i], _token)
                  .then((Commande cmd) {
                print("cmd mise a jour other exist");
              });
            });
          } else {
            setState(() {
              _error = true;
              this.barcode =
                  "Desole ce code correspond \n pas a votre commande !!!";
            });
          }
        }
      } else {
        setState(() => this.barcode = "Aucune commande acceptée !!!");
      }
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          _error = true;
          this.barcode =
              'Vous devez autoriser ETakesh a acceder a votre Camera';
        });
      } else {
        setState(() {
          _error = true;
          this.barcode = 'Probleme Inconnu: $e';
        });
      }
    } on FormatException {
      setState(() {
        _error = true;
        this.barcode = "Le Scan n'est pas acheve merci de recommencer !!!";
      });
    } catch (e) {
      _error = true;
      setState(() {
        this.barcode = 'Probleme Inconnu: $e';
      });
    }
  }
}
