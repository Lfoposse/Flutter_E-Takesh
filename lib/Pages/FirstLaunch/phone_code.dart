import 'package:etakesh_client/pages/FirstLaunch/email_adresse.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EnterPhoneCodePage extends StatelessWidget {
  Color backColor = Colors.white;
  var _codeController = new TextEditingController();
  final String phone_n;
  final String ververId;

  EnterPhoneCodePage({Key key, this.phone_n, this.ververId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        floatingActionButton: FloatingActionButton(
            backgroundColor: Color(0xFF0C60A8),
            foregroundColor: Colors.white,
            child: Icon(Icons.arrow_forward),
            tooltip: "Donnees personnelles",
            onPressed: () {
              FirebaseAuth.instance.currentUser().then((user) {
                if (user != null) {
                  Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => EnterEmailPage(phone_n: phone_n)),
                  );
                } else {
                  signIn(context);
                }
              });
            }),
        appBar: new AppBar(
          title: const Text("Code de validation"),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: Container(
          decoration: BoxDecoration(color: backColor),
          child: Column(
            children: [
              new Expanded(
                flex: 1,
                child: new Container(
                  width: double
                      .infinity, // this will give you flexible width not fixed width
                  color: backColor, // variable
                  child: new Column(
                    children: <Widget>[
                      new Expanded(
                        flex: 1,
                        child: new Container(
                            alignment: Alignment.center,
//                        padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0, bottom: 20.0),
                            child: Text(
                              "Saisissez le code a 6 chiffres recu au numero "
                                  "$phone_n",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 24.0, fontWeight: FontWeight.w300),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              new Expanded(
                flex: 2,
                child: new Container(
                  width: double
                      .infinity, // this will give you flexible width not fixed width
                  color: Colors.white,
                  child: new Column(
                    children: <Widget>[
                      new Expanded(
                        flex: 1,
                        child: new Container(
                            padding: EdgeInsets.only(left: 20.0, bottom: 20.0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: SizedBox(
                                      height: 50.0,
                                      child: Container(
                                          padding: EdgeInsets.only(
                                              left: 10.0, right: 10.0),
//                                softWrap: true,
                                          child: TextField(
                                              controller: _codeController,
                                              autofocus: true,
                                              maxLength: 6,
                                              keyboardType: TextInputType.phone,
                                              inputFormatters: [
                                                WhitelistingTextInputFormatter
                                                    .digitsOnly,
                                              ],
                                              style: TextStyle(
                                                  fontSize: 23.0,
                                                  fontWeight: FontWeight.w300,
                                                  color: Colors.black87),
                                              decoration: InputDecoration(
                                                  hintText: '- - - - - -',
                                                  hintStyle: TextStyle(
                                                      fontSize: 30.0,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      color:
                                                          Colors.black87))))),
                                )
                              ],
                            )),
                      ),
                    ],
                  ),
                  //variable
                ),
              ),
            ],
          ),
        ));
  }

  signIn(BuildContext context) {
    FirebaseAuth.instance
        .signInWithPhoneNumber(
            verificationId: ververId, smsCode: _codeController.text)
        .then((user) {
      Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => EnterEmailPage(phone_n: phone_n)),
      );
    }).catchError((e) {
      print(e);
    });
  }
}
