import "package:flutter/material.dart";

class LoginPage extends StatelessWidget {
  BoxDecoration decoration = BoxDecoration(
      border: Border(bottom: BorderSide(color: Color(0xEEFFFFFF), width: 1.0)));

  TextStyle CustomTextStyle() {
    return TextStyle(color: Colors.white30, fontSize: 15.0);
  }

  Widget CustomSizeBox({double height}) {
    return SizedBox(
      height: height,
    );
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  FocusNode emailNode = FocusNode();
  FocusNode passawordNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(child: Login())),
    );
  }
}

class Login extends StatefulWidget {
  createState() => LoginState();
}

class LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  bool loading = false;
  FocusNode emailNode;
  FocusNode passawordNode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    passawordNode = FocusNode();
    emailNode = FocusNode();
    loading = false;
  }

  BoxDecoration decoration = BoxDecoration(
      border: Border(bottom: BorderSide(color: Color(0xEEFFFFFF), width: 1.0)));

  TextStyle CustomTextStyle() {
    return TextStyle(color: Colors.black, fontSize: 15.0);
  }

  InputDecoration CustomTextDecoration({String text, IconData icon}) {
    return InputDecoration(
      labelStyle: TextStyle(color: Colors.white30),
      labelText: text,
      prefixIcon: Icon(icon, color: Colors.black),
      enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.blueGrey[700])),
      focusedBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
      errorBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
    );
  }

  Widget CustomSizeBox({double height}) {
    return SizedBox(
      height: height,
    );
  }

  Widget LoginButton(BuildContext context) {
    return new SizedBox(
      height: 45.0,
      width: double.infinity,
      child: new RaisedButton(
        color: Color(0xFFDEA807),
        child: Text(
          "CONNEXION",
          style: TextStyle(color: Color(0xFF0C60A8)),
        ),
        onPressed: () {
          FocusScope.of(context).requestFocus(new FocusNode());
          if (_formKey.currentState.validate()) {
            setState(() {
              loading = true;
            });
            Future.delayed(Duration(seconds: 2), () {
              setState(() {
                loading = false;
              });
              Scaffold.of(context).showSnackBar(new SnackBar(
                content: new Text("Connexion reuissite ..."),
              ));
            });
          } else {
            setState(() {
              _autoValidate = true;
            });
          }
        },
      ),
    );
  }

  Widget LoginUi() {
    return Form(
      key: _formKey,
      autovalidate: _autoValidate,
      child: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            color: Color(0xFF0C60A8),
            child: Image.asset("assets/images/login_icon.png",
                height: 95.0, width: 95.0),
          ),
          CustomSizeBox(height: 50.0),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 40.0),
            child: Column(
              children: <Widget>[
                Container(decoration: decoration),
                TextFormField(
                  enabled: true,
                  enableInteractiveSelection: true,
                  focusNode: emailNode,
                  style: CustomTextStyle(),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration:
                      CustomTextDecoration(icon: Icons.email, text: "Email"),
                  textCapitalization: TextCapitalization.none,
                  onFieldSubmitted: (term) {
                    emailNode.unfocus();
                    FocusScope.of(context).requestFocus(passawordNode);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Veillez saisir votre email';
                    } else if (!new RegExp(
                            r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value)) {
                      return "Email non valide";
                    }
                  },
                ),
                TextFormField(
                  enabled: true,
                  enableInteractiveSelection: true,
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                  style: CustomTextStyle(),
                  focusNode: passawordNode,
                  decoration: CustomTextDecoration(
                      icon: Icons.lock, text: "Mot de Passe"),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Veillez saisir votre mot de passe';
                    } else if (value.length < 6) {
                      return 'Mot de passe tres court';
                    }
                  },
                ),
                CustomSizeBox(height: 20.0),
                LoginButton(context),
                CustomSizeBox(height: 30.0),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Mot de passe oubliez ?",
                    style: TextStyle(
                      color: Color(0xFF0C60A8),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget LoadingIndicator() {
    return Positioned(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.blueGrey,
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: <Widget>[LoginUi(), loading ? LoadingIndicator() : Container()],
    );
  }
}
