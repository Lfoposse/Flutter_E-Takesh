import 'package:etakesh_client/DAO/Presenters/UpdateAcountPresenter.dart';
import 'package:etakesh_client/Database/DatabaseHelper.dart';
import 'package:etakesh_client/Models/clients.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:positioned_tap_detector/positioned_tap_detector.dart';

class UpdateAccountPage extends StatefulWidget {
  final String token;
  UpdateAccountPage({Key key, this.token}) : super(key: key);
  @override
  createState() => new UpdateAccountPageState();
}

class UpdateAccountPageState extends State<UpdateAccountPage>
    implements UpdateAccountContract {
  bool isOnEditingMode = false;
  Client1 client;
  bool _isLoading = false;

  final nomKey = new GlobalKey<FormState>();
  final adresseKey = new GlobalKey<FormState>();
  final prenomKey = new GlobalKey<FormState>();
  final phoneKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  UpdateAccountPresenter _presenter;

  String _nom, _prenom, _adresse, _phone;

  UpdateAccountPageState() {
    _presenter = new UpdateAccountPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  dispose() {
    super.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  void _showSnackBar(String text) {
    scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(text)));
  }

  void _submit() {
    nomKey.currentState.save();
    prenomKey.currentState.save();
    adresseKey.currentState.save();
    phoneKey.currentState.save();

    if (_nom.length == 0 ||
        _prenom.length == 0 ||
        _adresse.length == 0 ||
        _phone.length == 0) {
      _showSnackBar("Veuillez renseigner tous les champs");
    } else {
      client.nom = _nom;
      client.prenom = _prenom;
      client.adresse = _adresse;
      client.phone = _phone;

      setState(() {
        _isLoading = true;
      });

      _presenter.updateAccountDatas(client, widget.token);
    }
  }

  Widget getAppropriateItem(key, String hintText, bool editable) {
    if (isOnEditingMode && editable) {
      return Form(
          key: key,
          child: TextFormField(
              onSaved: (val) {
                if (key == nomKey)
                  _nom = val;
                else if (key == prenomKey)
                  _prenom = val;
                else if (key == adresseKey)
                  _adresse = val;
                else if (key == phoneKey) _phone = val;
              },
              obscureText: false,
              autofocus: false,
              autocorrect: false,
              maxLines: 1,
              initialValue: hintText == null ? "" : hintText,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0.0),
                  border: InputBorder.none,
                  hintText: hintText == null ? "Non définit" : hintText),
              style: TextStyle(
                fontSize: 13.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              )));
    } else {
      return Text(hintText == null ? "Non définit" : hintText,
          textAlign: TextAlign.left,
          overflow: TextOverflow.ellipsis,
          style: new TextStyle(
            color: Colors.black,
            fontSize: 13.0,
            fontWeight: FontWeight.bold,
          ));
    }
  }

  Widget buildUserItem(
      key, String label, String titleText, bool show_border, bool editable) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      decoration: new BoxDecoration(
          border: !show_border
              ? new Border()
              : new Border(
                  bottom: BorderSide(
                      color: Colors.grey,
                      style: BorderStyle.solid,
                      width: 1.0)),
          color: Colors.white),
      child: Center(
        child: Container(
          width: double
              .infinity, // remove this line in order to center the content of each element
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 15.0),
                child: Text(label,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    style: new TextStyle(
                      color: Colors.grey,
                      fontSize: 12.0,
                      fontWeight: FontWeight.normal,
                    )),
              ),
              Container(
                  color: isOnEditingMode && editable
                      ? Color.fromARGB(5, 0, 0, 0)
                      : Colors.transparent,
                  margin: EdgeInsets.only(top: 5.0, bottom: 10.0),
                  padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                  child: getAppropriateItem(key, titleText, editable))
            ],
          ),
        ),
      ),
    );
  }

  Widget getActionButton() {
    if (isOnEditingMode) {
      return Container(
          color: Colors.white,
          padding: const EdgeInsets.only(
            top: 30.0,
            bottom: 20.0,
            left: 20.0,
            right: 20.0,
          ),
          child: _isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : RaisedButton(
                  onPressed: _submit,
                  child: SizedBox(
                    width: double.infinity,
                    child: Text("Enregistrer",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)),
                  textColor: Colors.white,
                  color: Color(0xFF33B841),
                  elevation: 1.0,
                ));
    } else {
      return Container();
    }
  }

  Widget getAppropriateRootView(Widget child) {
    return Scaffold(
      key: scaffoldKey,
      //resizeToAvoidBottomPadding: false, // this avoids the overflow error
      body: child,
      floatingActionButton: !isOnEditingMode
          ? Container(
              margin: EdgeInsets.only(bottom: 30.0, right: 10.0),
              child: FloatingActionButton(
                backgroundColor: Color(0xFF33B841),
                onPressed: () {
                  setState(() {
                    isOnEditingMode = true;
                  });
                },
                mini: false,
                child: Icon(Icons.edit, size: 30.0),
              ),
            )
          : null,
    );
  }

  Widget getContent() {
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              height: 150.0,
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 40.0),
                    child: Image.asset(
                      'assets/images/avatar.png',
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Container(
                    color: Color.fromARGB(0, 0, 255, 0),
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  isOnEditingMode && true
                      ? Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            margin: EdgeInsets.only(bottom: 10.0, right: 10.0),
                            padding: EdgeInsets.all(10.0),
                            decoration: new BoxDecoration(
                              color: Colors.grey,
                              shape: BoxShape.circle,
                            ),
                            child: PositionedTapDetector(
                              onTap: (position) {
                                print("Select Image");
                              },
                              child: Icon(Icons.photo_camera),
                            ),
                          ),
                        )
                      : new Container()
                ],
              ),
            ),
            Expanded(
//                child: ScrollConfiguration(
                child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  buildUserItem(null, "Email", client.email, true, false),
                  buildUserItem(nomKey, "Nom", client.nom, true, true),
                  buildUserItem(prenomKey, "Prenom", client.prenom, true, true),
                  buildUserItem(
                      adresseKey, "Adresse", client.adresse, true, true),
                  buildUserItem(phoneKey, "Numéro", client.phone, true, true),
                  getActionButton()
                ],
              ),
            ))
          ],
        ),
        Container(
          height: AppBar().preferredSize.height + 50,
          child: AppBar(
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
        ),
      ],
    );
  }

  Widget getPageBody() {
    return FutureBuilder(
      future: DatabaseHelper().getClient(),
      builder: (BuildContext buildContext, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          client = snapshot.data;
          return getContent();
        } else
          return Container(
              height: double.infinity,
              width: double.infinity,
              child: Center(
                child: CircularProgressIndicator(),
              ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(child: getAppropriateRootView(getPageBody()));
  }

  @override
  void onConnectionError() {
    _showSnackBar("Échec de connexion. Vérifier votre connexion internet");
    setState(() => _isLoading = false);
  }

  @override
  void onRequestError() {
    _showSnackBar("Erreur survénue. Réessayez svp");
    setState(() => _isLoading = false);
  }

  @override
  void onRequestSuccess(Client1 client) {
    DatabaseHelper().updateClient(client).then((success) {
      setState(() {
        _isLoading = false;
        isOnEditingMode = false;
      });
      _showSnackBar("Modification des informations réussie");
    });
  }
}
