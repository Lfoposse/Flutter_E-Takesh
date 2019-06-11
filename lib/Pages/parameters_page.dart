import 'package:etakesh_client/DAO/Presenters/LoginPresenter.dart';
import 'package:etakesh_client/Database/DatabaseHelper.dart';
import 'package:etakesh_client/Models/clients.dart';
import 'package:etakesh_client/Utils/AppSharedPreferences.dart';
import 'package:etakesh_client/Utils/Loading.dart';
import 'package:etakesh_client/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ParametersPage extends StatefulWidget {
  @override
  State createState() => ParametersPageState();
}

class ParametersPageState extends State<ParametersPage>
    implements ParameterContract {
  bool loading;
  bool err = false;
  Client1 client;
  int stateIndex;
  final GlobalKey<ScaffoldState> _mScaffoldState =
      new GlobalKey<ScaffoldState>();
  ParameterPresenter _presenter;
  ParametersPageState() {
    _presenter = new ParameterPresenter(this);
  }
  @override
  void initState() {
    stateIndex = 0;
    _presenter.datasClient();
    super.initState();
    loading = false;
    err = false;
  }

  void _showErrSnackBar() {
    var snackBar = SnackBar(
      content: Text(
        "Impossible de se deconnecter",
        style: TextStyle(color: Colors.red),
      ),
      backgroundColor: Color(0xFF0C60A8),
      action: SnackBarAction(label: "OK", onPressed: () {}),
    );
    _mScaffoldState.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    switch (stateIndex) {
      case 0:
        return ShowLoadingView();
      case 1:
        return ShowLoadingErrorView(_onRetryClick);

      default:
        return new Scaffold(
            key: _mScaffoldState,
            appBar: new AppBar(
              title: new Text(
                'Paramètres du compte',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.black,
              iconTheme: IconThemeData(color: Colors.white),
            ),
            body: SingleChildScrollView(
                child: Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Column(
                children: <Widget>[
                  new ListTile(
                      leading: new CircleAvatar(
                        child: new Image.asset("assets/images/avatar.png",
                            width: 30.0, height: 30.0),
                        radius: 32.0,
                        backgroundColor: Color(0xFFE2E2E2),
                      ),
                      title: new Text(client.nom + " " + client.prenom,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      subtitle: new Text(client.phone + "\n" + client.email,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      isThreeLine: true),
                  Divider(
                    height: 4.0,
                    color: Color(0xFFE2E2E2),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  ListTile(
                    title: new Text("Favoris",
                        style: TextStyle(color: Colors.black54)),
                  ),
                  SizedBox(
                    height: 0.0,
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.home,
                      color: Colors.black,
                    ),
                    title: new Text("Ajouter un domicile",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    height: 0.0,
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.business_center,
                      color: Colors.black,
                    ),
                    title: new Text("Ajouter une adresse professionnelle",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold)),
                  ),
                  ListTile(
                    title: new Text(
                      "Autres lieux enregistres",
                      style: TextStyle(color: Colors.lightBlueAccent),
                    ),
                  ),
                  Divider(
                    height: 4.0,
                    color: Color(0xFFE2E2E2),
                  ),
                  ListTile(
                    title: new Text("Paramètres de confidentialite",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold)),
                    subtitle: new Text(
                      "Gérer les données que vous partagez avec nous",
                      style: TextStyle(
                          color: Colors.grey.withOpacity(0.7), fontSize: 12.0),
                    ),
                  ),
                  Divider(
                    height: 4.0,
                    color: Color(0xFFE2E2E2),
                  ),
                  ListTile(
                    title: new Text("Déconnexion",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold)),
                    trailing: loading
                        ? CircularProgressIndicator(
                            backgroundColor: Color(0xFF0C60A8),
                          )
                        : Text(""),
                    onTap: () {
                      showDialog<bool>(
                        context: context,
                        builder: (BuildContext context) {
                          return new AlertDialog(
                            title: new Text("Avertissement !!!"),
                            content: new SingleChildScrollView(
                              child: new ListBody(
                                children: <Widget>[
                                  new Text(
                                      "Vous etez sur le point de vouloir vous déconnecter"),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              new FlatButton(
                                child: new Text("ANNULER",
                                    style: TextStyle(color: Colors.lightGreen)),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              new FlatButton(
                                child: new Text("CONFIRMER",
                                    style: TextStyle(color: Colors.blue)),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  setState(() {
                                    loading = true;
                                  });
                                  AppSharedPreferences()
                                      .getToken()
                                      .then((String token) {
                                    if (token != '') {
                                      Future.delayed(Duration(seconds: 2),
                                          () async {
                                        final response1 = await http.post(
                                          Uri.encodeFull(
                                              "http://api.e-takesh.com:26960/api/Users/logout?access_token=" +
                                                  token),
                                        );
                                        if (response1.statusCode == 204) {
                                          AppSharedPreferences()
                                              .setAppLoggedIn(false);
                                          AppSharedPreferences()
                                              .setUserToken('');
                                          DatabaseHelper().clearUser();
                                          DatabaseHelper().clearClient();
                                          Navigator.of(_mScaffoldState
                                                  .currentContext)
                                              .pushAndRemoveUntil(
                                                  new MaterialPageRoute(
                                                      builder: (context) =>
                                                          LoginPage()),
                                                  ModalRoute.withName(Navigator
                                                      .defaultRouteName));
                                          setState(() {
                                            loading = false;
                                          });
                                        } else {
                                          setState(() {
                                            loading = false;
                                          });
                                          _showErrSnackBar();
                                          // If that call was not successful, throw an error.
                                          throw Exception(
                                              'Erreur de connexion du client' +
                                                  response1.body.toString());
                                        }
                                      });
                                    } else {
                                      Navigator.of(context).pop();
                                      setState(() {
                                        loading = false;
                                      });
                                      _showErrSnackBar();
                                    }
                                  }).catchError((error) {
                                    setState(() {
                                      loading = false;
                                    });
                                    _showErrSnackBar();
                                    print("Not get Token " + error.toString());
                                  });
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            )));
    }
  }

  ///relance le service en cas d'echec de connexion internet
  void _onRetryClick() {
    setState(() {
      stateIndex = 0;
      _presenter.datasClient();
    });
  }

  ///en cas de soucis
  @override
  void onLoginError() {
    setState(() {
      stateIndex = 1;
    });
  }

  @override
  void onLoardSuccess(Client1 datas) async {
    if (datas != null) {
      setState(() {
        client = datas;
        stateIndex = 3;
      });
    }
  }
}
