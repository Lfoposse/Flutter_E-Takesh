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
  ParameterPresenter _presenter;
  ParametersPageState() {
    _presenter = new ParameterPresenter(this);
  }
  @override
  void initState() {
    stateIndex = 0;
    _presenter.datasClient();
    super.initState();
    this.loading = false;
    err = false;
  }

  Widget LoadingIndicator() {
    Container(
      height: 400.0,
//      height: MediaQuery.of(context).size.height,
//      width: MediaQuery.of(context).size.width,
      color: Colors.grey[700],
      child: Center(
        child: SizedBox(
          height: 50.0,
          width: 50.0,
          child: CircularProgressIndicator(
            strokeWidth: 0.7,
            backgroundColor: Color(0xFF0C60A8),
          ),
        ),
      ),
    );
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
            appBar: new AppBar(
              title: new Text(
                'Parametres du compte',
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
                      title: new Text(client.username + " " + client.lastname,
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
                        style: TextStyle(color: Colors.grey)),
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
                    title: new Text("Parametres de confidentialite",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold)),
                    subtitle: new Text(
                      "Gerer les donnees que vous partagez avec nous",
                      style: TextStyle(
                          color: Colors.grey.withOpacity(0.7), fontSize: 12.0),
                    ),
                  ),
                  Divider(
                    height: 4.0,
                    color: Color(0xFFE2E2E2),
                  ),
                  ListTile(
                    title: new Text("Deconnexion",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold)),
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
                                      "Vous etez sur le point de vouloir vous deconnecter"),
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
                                  print("LogOut");
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
                                          Navigator.of(context).pop();
                                          AppSharedPreferences()
                                              .setAppLoggedIn(false);
                                          AppSharedPreferences()
                                              .setUserToken('');
                                          DatabaseHelper().clearUser();
                                          DatabaseHelper().clearClient();
                                          Navigator.of(context)
                                              .pushAndRemoveUntil(
                                                  new MaterialPageRoute(
                                                      builder: (context) =>
                                                          LoginPage()),
                                                  ModalRoute.withName(Navigator
                                                      .defaultRouteName));
                                        } else {
                                          Navigator.of(context).pop();
                                          this.loading = true;
                                          print("Probleme deconnexion");

                                          // If that call was not successful, throw an error.
                                          throw Exception(
                                              'Erreur de connexion du client' +
                                                  response1.body.toString());
                                        }
                                      });
                                    } else {
                                      Navigator.of(context).pop();
                                      print("Not get Token " + token);
                                    }
                                  }).catchError((error) {
                                    Navigator.of(context).pop();
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
