import 'dart:async';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ScanScreen extends StatefulWidget {
  @override
  _ScanState createState() => new _ScanState();
}

class _ScanState extends State<ScanScreen> {
  String barcode = "";

  @override
  initState() {
    super.initState();
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  barcode,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ));
  }

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() => this.barcode = barcode);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode =
              'Vous devez autoriser ETakesh a acceder a votre Camera';
        });
      } else {
        setState(() => this.barcode = 'Probleme Inconnu: $e');
      }
    } on FormatException {
      setState(() =>
          this.barcode = "Le Scan n'est pas acheve merci de recommencer !!!");
    } catch (e) {
      setState(() => this.barcode = 'Probleme Inconnu: $e');
    }
  }
}
