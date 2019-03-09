import 'package:etakesh_client/pages/FirstLaunch/create_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EnterEmailPage extends StatefulWidget {
  final String phone_n;

  EnterEmailPage({Key key, this.phone_n}) : super(key: key);
  @override
  _EnterEmailPageState createState() => _EnterEmailPageState();
}

class _EnterEmailPageState extends State<EnterEmailPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _agreedToTOS = true;
  var _emailController = new TextEditingController();
  var _nomController = new TextEditingController();
  var _prenomController = new TextEditingController();
  var _villeController = new TextEditingController();
  var _naissanceController = new TextEditingController();
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
        title: Text("Saisie de donnee"),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: new SafeArea(
        top: false,
        bottom: false,
        child: Form(
          key: _formKey,
          child: new ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Informations complementaires pour votre compte",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.w300),
                    )),
              ),
              new TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  icon: Icon(Icons.email, color: Colors.black),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (String value) {
                  if (value.trim().isEmpty) {
                    return 'Adresse email obligatoire';
                  }
                },
              ),
              new TextFormField(
                controller: _nomController,
                decoration: const InputDecoration(
                  labelText: 'Nom',
                  icon: Icon(Icons.person, color: Colors.black),
                ),
                validator: (String value) {
                  if (value.trim().isEmpty) {
                    return 'Nom obligatoire';
                  }
                },
              ),
              new TextFormField(
                controller: _prenomController,
                decoration: const InputDecoration(
                  labelText: 'Prenom',
                  icon: Icon(Icons.person, color: Colors.black),
                ),
                validator: (String value) {
                  if (value.trim().isEmpty) {
                    return 'Prenom obligatoire';
                  }
                },
              ),
              new TextFormField(
                controller: _naissanceController,
                decoration: const InputDecoration(
                    labelText: 'Date de naissance',
                    icon: Icon(Icons.calendar_today, color: Colors.black)),
                keyboardType: TextInputType.datetime,
                validator: (String value) {
                  if (value.trim().isEmpty) {
                    return 'Date de naissance obligatoire';
                  }
                },
              ),
              new TextFormField(
                controller: _villeController,
                decoration: const InputDecoration(
                    labelText: 'Ville de residence',
                    icon: Icon(Icons.location_city, color: Colors.black)),
                validator: (String value) {
                  if (value.trim().isEmpty) {
                    return 'Ville obligatoire';
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
                      child: const Text(
                        "Je certifie avoir ecris , lus \n et valide ces informations ",
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _submittable() {
    return _agreedToTOS;
  }

  void _submit() {
    if (_formKey.currentState.validate()) {
      Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => CreatePassWordPage(
                  phone_n: widget.phone_n,
                  email: _emailController.text,
                  nom: _nomController.text,
                  prenom: _prenomController.text,
                  ville: _villeController.text,
                  d_naissance: _naissanceController.text,
                )),
      );

      const SnackBar snackBar = SnackBar(content: Text('Form submitted'));

      Scaffold.of(context).showSnackBar(snackBar);
    }
  }

  void _setAgreedToTOS(bool newValue) {
    setState(() {
      _agreedToTOS = newValue;
    });
  }
}

//import 'package:flutter/material.dart';
//class EnterEmailPage extends StatelessWidget {
//  Color backColor = Colors.white;
//  final String phone_n;
//
//  EnterEmailPage({Key key, this.phone_n}) : super(key: key);
//  @override
//  Widget build(BuildContext context) {
//    return new Scaffold(
//        floatingActionButton: FloatingActionButton(
//            backgroundColor: Colors.black,
//            foregroundColor: Colors.white,
//            child: Icon(Icons.arrow_forward),
//            tooltip: "Adresse email",
//            onPressed: () {}),
//        appBar: new AppBar(
//          title: Text("Vos informations"),
//          backgroundColor: Colors.black87,
//        ),
//        body: Container(
//          decoration: BoxDecoration(color: backColor),
//          child: Column(
//            children: [
//              new Expanded(
//                flex: 1,
//                child: new Container(
//                  width: double
//                      .infinity, // this will give you flexible width not fixed width
//                  color: backColor, // variable
//                  child: new Column(
//                    children: <Widget>[
//                      new Expanded(
//                        flex: 1,
//                        child: new Container(
//                            alignment: Alignment.center,
////                        padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0, bottom: 20.0),
//                            child: Text(
//                              "Quelle est votre adresse email ?"
//                                  "$phone_n",
//                              overflow: TextOverflow.ellipsis,
//                              maxLines: 2,
//                              textAlign: TextAlign.center,
//                              style: TextStyle(
//                                  fontSize: 24.0, fontWeight: FontWeight.w300),
//                            )),
//                      ),
//                    ],
//                  ),
//                ),
//              ),
//              new Expanded(
//                flex: 2,
//                child: new Container(
//                  width: double
//                      .infinity, // this will give you flexible width not fixed width
//                  color: Colors.white,
//                  child: new Column(
//                    children: <Widget>[
//                      new Expanded(
//                        flex: 1,
//                        child: new Container(
//                            padding: EdgeInsets.only(left: 20.0, bottom: 20.0),
//                            child: Column(
//                              children: <Widget>[
//                                Expanded(
//                                  child: SizedBox(
//                                      height: 50.0,
//                                      child: Container(
//                                          padding: EdgeInsets.only(
//                                              left: 10.0, right: 10.0),
////                                softWrap: true,
//                                          child: TextField(
//                                              autofocus: true,
//                                              keyboardType:
//                                                  TextInputType.emailAddress,
//                                              style: TextStyle(
//                                                  fontSize: 23.0,
//                                                  fontWeight: FontWeight.w300,
//                                                  color: Colors.black87),
//                                              decoration: InputDecoration(
//                                                  icon: Icon(Icons.email),
//                                                  hintText: 'nom@example.com',
//                                                  hintStyle: TextStyle(
//                                                      fontSize: 23.0,
//                                                      fontWeight:
//                                                          FontWeight.w300,
//                                                      color:
//                                                          Colors.black87))))),
//                                ),
//                                Expanded(
//                                  child: SizedBox(
//                                      height: 50.0,
//                                      child: Container(
//                                          padding: EdgeInsets.only(
//                                              left: 10.0, right: 10.0),
//                                          child: TextField(
//                                              autofocus: true,
//                                              keyboardType: TextInputType.text,
//                                              style: TextStyle(
//                                                  fontSize: 23.0,
//                                                  fontWeight: FontWeight.w300,
//                                                  color: Colors.black87),
//                                              decoration: InputDecoration(
//                                                  icon:
//                                                      Icon(Icons.perm_identity),
//                                                  hintText: 'nom',
//                                                  hintStyle: TextStyle(
//                                                      fontSize: 23.0,
//                                                      fontWeight:
//                                                          FontWeight.w300,
//                                                      color:
//                                                          Colors.black87))))),
//                                ),
//                                Expanded(
//                                  child: SizedBox(
//                                      height: 50.0,
//                                      child: Container(
//                                          padding: EdgeInsets.only(
//                                              left: 10.0, right: 10.0),
//                                          child: TextField(
//                                              autofocus: true,
//                                              keyboardType: TextInputType.text,
//                                              style: TextStyle(
//                                                  fontSize: 23.0,
//                                                  fontWeight: FontWeight.w300,
//                                                  color: Colors.black87),
//                                              decoration: InputDecoration(
//                                                  icon:
//                                                      Icon(Icons.perm_identity),
//                                                  hintText: 'prenom',
//                                                  hintStyle: TextStyle(
//                                                      fontSize: 23.0,
//                                                      fontWeight:
//                                                          FontWeight.w300,
//                                                      color:
//                                                          Colors.black87))))),
//                                )
//                              ],
//                            )),
//                      ),
//                    ],
//                  ),
//                  //variable
//                ),
//              ),
//            ],
//          ),
//        ));
//  }
//}
