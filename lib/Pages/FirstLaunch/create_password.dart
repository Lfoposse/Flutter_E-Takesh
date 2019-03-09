import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreatePassWordPage extends StatefulWidget {
  final String phone_n;
  final String email;
  final String nom;
  final String prenom;
  final String d_naissance;
  final String ville;
  CreatePassWordPage(
      {Key key,
      this.phone_n,
      this.email,
      this.nom,
      this.prenom,
      this.ville,
      this.d_naissance})
      : super(key: key);
  @override
  _CreatePassWordPageState createState() => _CreatePassWordPageState();
}

class _CreatePassWordPageState extends State<CreatePassWordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _agreedToTOS = true;

  @override
  void initState() {
    // TODO: implement initState
    print(this.widget.phone_n);
    print(this.widget.email);
    print(this.widget.nom);
    print(this.widget.prenom);
    print(this.widget.d_naissance);
    print(this.widget.ville);
    super.initState();
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
        title: const Text('Mot de passe'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: new SafeArea(
        top: false,
        bottom: false,
        child: Form(
          key: _formKey,
          child: new ListView(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            children: <Widget>[
              Center(
                child: Text(
                    this.widget.phone_n +
                        '' +
                        this.widget.email +
                        '' +
                        this.widget.nom +
                        '' +
                        this.widget.prenom +
                        '' +
                        this.widget.d_naissance +
                        '' +
                        this.widget.ville,
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Container(
                    margin: EdgeInsets.only(bottom: 50.0, top: 50.0),
                    alignment: Alignment.center,
                    child: Text(
                      "Creez un mot de passe pour votre compte",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.w300),
                    )),
              ),
              new TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Mot de passe',
                  icon: Icon(
                    Icons.enhanced_encryption,
                    color: Colors.black,
                  ),
                ),
                obscureText: true,
                keyboardType: TextInputType.text,
                validator: (String value) {
                  if (value.trim().isEmpty) {
                    return 'Mot de passe obligatoire';
                  }
                },
              ),
              new TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Confirmer votre mot de passe',
                  icon: Icon(
                    Icons.enhanced_encryption,
                    color: Colors.black,
                  ),
                ),
                obscureText: true,
                keyboardType: TextInputType.text,
                validator: (String value) {
                  if (value.trim().isEmpty) {
                    return 'Confirmation vide';
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
                        "J'accepte les conditions d'utilisation \nde l'application E-Takesh",
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
