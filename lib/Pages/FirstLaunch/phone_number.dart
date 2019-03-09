import 'package:etakesh_client/pages/FirstLaunch/phone_code.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EnterPhoneNumberPage extends StatefulWidget {
  @override
  _EnterPhoneNumberPageState createState() => _EnterPhoneNumberPageState();
}

class _EnterPhoneNumberPageState extends State<EnterPhoneNumberPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _agreedToTOS = true;
  var _phoneController = new TextEditingController();
  String verificationId;
  bool loading = false;
//  final String ververId

  Widget form() {
    _formKey.currentState?.validate();
    return SafeArea(
      top: false,
      bottom: false,
      child: Form(
        key: this._formKey,
        child: new ListView(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Container(
                  margin: EdgeInsets.only(bottom: 50.0, top: 50.0),
                  alignment: Alignment.center,
                  child: Text(
                    "Saisissez votre numero de telephone portable",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.w300),
                  )),
            ),
            TextFormField(
              controller: _phoneController,
              decoration: InputDecoration(
                hintText: '6 70 54 99 26',
                icon: Icon(
                  Icons.phone,
                  color: Colors.black,
                ),
                errorStyle: TextStyle(color: Colors.red, fontSize: 14),
                hintStyle: TextStyle(
                    fontSize: 23.0,
                    fontWeight: FontWeight.w300,
                    color: Colors.black87),
              ),
              autofocus: true,
              maxLength: 9,
              style: TextStyle(
                  fontSize: 23.0,
                  fontWeight: FontWeight.w300,
                  color: Colors.black87),
              keyboardType: TextInputType.phone,
              inputFormatters: [
                WhitelistingTextInputFormatter.digitsOnly,
              ],
              validator: (String value) {
                if (value.trim().isEmpty) {
                  return "Vous n'avez pas renseigne le numero de telephone ";
                } else if (value.length < 9) {
                  return 'Numero de telephone non valide';
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                children: <Widget>[
                  Checkbox(
                    activeColor: Color(0xFF0C60A8),
                    value: _agreedToTOS,
                    onChanged: _setAgreedToTOS,
                  ),
                  GestureDetector(
                      onTap: () => _setAgreedToTOS(!_agreedToTOS),
                      child: Text(
                        "En continuant vous allez recvoire un \ncode de verification par SMS.\n"
                            " Vous devez renseigner ce code \na la page suivante.",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.w300),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFF0C60A8),
          foregroundColor: Colors.white,
          child: Icon(Icons.arrow_forward),
          tooltip: "Adresse email",
          onPressed: _submittable() ? _submit : null),
      appBar: AppBar(
        title: Text('Nouveau chez E-Takesh ?'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: form(),
    );
  }

  bool _submittable() {
    return _agreedToTOS;
  }

  _submit() {
    if (_formKey.currentState.validate()) {
      setState(() {
        loading = true;
      });
      verifyPhone(context);
    }
  }

  Future verifyPhone(context) async {
    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
      this.verificationId = verId;
    };

    final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]) {
      this.verificationId = verId;
      Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => EnterPhoneCodePage(
                phone_n: "+237" + _phoneController.text,
                ververId: this.verificationId)),
      );
    };

    final PhoneVerificationCompleted verifiedSuccess = (FirebaseUser user) {
      print('verified');
    };

    final PhoneVerificationFailed veriFailed = (AuthException exception) {
      print('${exception.message}');
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "+237" + _phoneController.text,
        codeAutoRetrievalTimeout: autoRetrieve,
        codeSent: smsCodeSent,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verifiedSuccess,
        verificationFailed: veriFailed);
  }

  _setAgreedToTOS(bool newValue) {
    setState(() {
      _agreedToTOS = newValue;
    });
  }
}

//import 'package:etakesh_client/pages/FirstLaunch/phone_code.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
//
//class EnterPhoneNumberPage extends StatelessWidget {
//  String smsCode;
//  String verificationId;
//  Color backColor = Colors.white;
//  var _pnoneController = new TextEditingController();
//  @override
//  Widget build(BuildContext context) {
//    return new Scaffold(
//        floatingActionButton: FloatingActionButton(
//            backgroundColor: Color(0xFF0C60A8),
//            foregroundColor: Colors.white,
//            child: Icon(Icons.arrow_forward),
//            tooltip: "Valider mon numero",
//            onPressed: () {
//
//              verifyPhone(context);
//            }),
//        appBar: new AppBar(
//          title: Text("Nouveau chez E-Takesh ?"),
//          centerTitle: true,
//          elevation: 0.0,
//        ),
//        body: Stack(
//          children: <Widget>[
//            Body(),
//          ],
//        ));
//  }
//
//  Future<void> verifyPhone(BuildContext context) async {
//    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
//      this.verificationId = verId;
//    };
//
//    final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]) {
//      this.verificationId = verId;
//      Navigator.push(
//        context,
//        new MaterialPageRoute(
//            builder: (context) => EnterPhoneCodePage(
//                phone_n: "+237" + _pnoneController.text,
//                ververId: this.verificationId)),
//      );
//    };
//
//    final PhoneVerificationCompleted verifiedSuccess = (FirebaseUser user) {
//      print('verified');
//    };
//
//    final PhoneVerificationFailed veriFailed = (AuthException exception) {
//      print('${exception.message}');
//    };
//
//    await FirebaseAuth.instance.verifyPhoneNumber(
//        phoneNumber: "+237" + _pnoneController.text,
//        codeAutoRetrievalTimeout: autoRetrieve,
//        codeSent: smsCodeSent,
//        timeout: const Duration(seconds: 5),
//        verificationCompleted: verifiedSuccess,
//        verificationFailed: veriFailed);
//  }
//
//  Future<bool> smsCodeDialog(BuildContext context) {
//    return showDialog(
//        context: context,
//        barrierDismissible: false,
//        builder: (BuildContext context) {
//          return new AlertDialog(
//            title: Text('Entrer le code '),
//            content: TextField(
//              onChanged: (value) {
//                this.smsCode = value;
//              },
//            ),
//            contentPadding: EdgeInsets.all(10.0),
//            actions: <Widget>[
//              new FlatButton(
//                child: Text('Done'),
//                onPressed: () {
//                  FirebaseAuth.instance.currentUser().then((user) {
//                    if (user != null) {
//                      Navigator.of(context).pop();
//                      Navigator.of(context).pushReplacementNamed('/homepage');
//                    } else {
//                      Navigator.of(context).pop();
//                      signIn();
//                    }
//                  });
//                },
//              )
//            ],
//          );
//        });
//  }
//
//  signIn() {
//    FirebaseAuth.instance
//        .signInWithPhoneNumber(verificationId: verificationId, smsCode: smsCode)
//        .then((user) {})
//        .catchError((e) {
//      print(e);
//    });
//  }
//
//  Widget Body() {
//    return Container(
//      decoration: BoxDecoration(color: backColor),
//      child: Column(
//        children: [
//          new Expanded(
//            flex: 1,
//            child: new Container(
//              width: double
//                  .infinity, // this will give you flexible width not fixed width
//              color: backColor, // variable
//              child: new Column(
//                children: <Widget>[
//                  new Expanded(
//                    child: new Container(
//                        alignment: Alignment.center,
////                        padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0, bottom: 20.0),
//                        child: Text(
//                          "Saisissez votre numero de telephone portable",
//                          textAlign: TextAlign.center,
//                          overflow: TextOverflow.ellipsis,
//                          maxLines: 2,
//                          style: TextStyle(
//                              fontSize: 24.0,
//                              fontWeight: FontWeight.w300),
//                        )),
//                  ),
//                ],
//              ),
//            ),
//          ),
//          new Expanded(
//            child: new Container(
//              width: double
//                  .infinity, // this will give you flexible width not fixed width
//              color: Colors.white,
//              child: new Column(
//                children: <Widget>[
//                  new Expanded(
//                    flex: 1,
//                    child: new Container(
//                        padding:
//                        EdgeInsets.only(left: 20.0, bottom: 20.0),
//                        child: Row(
//                          children: <Widget>[
//                            Container(
//                              child: Image.asset(
//                                  'assets/images/cameroun_flag.png',
//                                  height: 20.0,
//                                  width: 60.0),
//                            ),
//                            Container(
//                                child: Text(
//                                  "+237",
//                                  overflow: TextOverflow.fade,
//                                  textAlign: TextAlign.justify,
//                                  style: new TextStyle(
//                                    fontSize: 23.0,
//                                    color: Colors.black,
//                                  ),
//                                )),
//                            Expanded(
//                                child: SizedBox(
//                                  height: 50.0,
//                                  child: Container(
//                                      padding: EdgeInsets.only(
//                                          left: 10.0, right: 10.0),
////                                softWrap: true,
//                                      child: TextField(
//                                          controller: _pnoneController,
//                                          autofocus: true,
//                                          maxLength: 9,
//                                          cursorColor: Color(0xFF0C60A8),
//                                          cursorRadius: Radius.circular(10.0),
//                                          cursorWidth: 3.0,
//                                          style: TextStyle(
//                                              fontSize: 23.0,
//                                              fontWeight: FontWeight.w300,
//                                              color: Colors.black87),
//                                          keyboardType: TextInputType.phone,
//                                          inputFormatters: [
//                                            WhitelistingTextInputFormatter
//                                                .digitsOnly,
//                                          ],
//                                          decoration: InputDecoration(
//                                              hintText: '6 70 54 99 26',
//                                              errorStyle: TextStyle(
//                                                  color: Colors.red,
//                                                  fontSize: 14),
//                                              hintStyle: TextStyle(
//                                                  fontSize: 23.0,
//                                                  fontWeight: FontWeight.w300,
//                                                  color: Colors.black87)))),
//                                ))
//                          ],
//                        )),
//                  ),
//                ],
//              ),
//              //variable
//            ),
//          ),
////      new Expanded(
////                    flex: 1,
////                    child: Container(
////                        padding: EdgeInsets.only(
////                            left: 20.0, right: 20.0, bottom: 20.0),
////                        alignment: Alignment.center,
////                        child: new Text(
////                          "En continuant vous allez recvoire un Code de verification par SMS.\n"
////                              " Vous devez renseigner ce code a la page suivante.",
////                          style:
////                              new TextStyle(fontSize: 15.0, color: backColor),
////                        ) //variable above
////                        ),
////                  ),
//        ],
//      ),
//    );
//  }
//}
