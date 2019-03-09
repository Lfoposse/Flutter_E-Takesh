import 'package:flutter/material.dart';

class SocialMediaPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> mScaffoldState =
      new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: mScaffoldState,
      appBar: new AppBar(
        title: Text("Nouveau chez E-Takesh ?"),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: new Center(
        child: new Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 50.0, top: 40),
              child: new Text(
                "Choisissez un compte",
                style: TextStyle(fontSize: 24),
              ),
            ),
            new ListTile(
              title: new Text(
                'Google',
                style: TextStyle(fontSize: 18.0),
              ),
              leading: Image.asset('assets/images/google.png',
                  height: 20.0, width: 60.0),
              onTap: () {
                showSnackBar();
              },
            ),
            new ListTile(
              title: new Text(
                'Facebook',
                style: TextStyle(fontSize: 18.0),
              ),
              leading: Image.asset('assets/images/facebook.png',
                  height: 20.0, width: 60.0),
              onTap: () {
                showSnackBar();
              },
            ),
          ],
        ),
      ),
    );
  }

  void showSnackBar() {
    var snackBar = SnackBar(
      content: Text("Module en developpement"),
      backgroundColor: Color(0xFF0C60A8),
      action: SnackBarAction(label: "OK", onPressed: () {}),
    );
    mScaffoldState.currentState.showSnackBar(snackBar);
  }
}
