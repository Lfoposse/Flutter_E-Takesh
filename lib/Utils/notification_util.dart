import 'package:etakesh_client/DAO/Presenters/CoursesPresenter.dart';
import 'package:etakesh_client/Database/DatabaseHelper.dart';
import 'package:etakesh_client/Models/clients.dart';
import 'package:etakesh_client/Models/commande.dart';
import 'package:etakesh_client/Utils/AppSharedPreferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationUtil extends StatefulWidget {
  BuildContext context;
  bool _etat1 = false;
  bool _etat2 = false;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  CommandeDetail cmdToSend;
  CommandeNotifPresenter _presenter;
  init(BuildContext context) {
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
    this.context = context;
    notification();
  }

  //  Action a effectuer lorsqu'on clique sur la notification
  Future onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('Cmd to send at the next page' + payload);
    }
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext contex) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Container(
            height: 350.0,
            width: 200.0,
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      height: 150.0,
                    ),
                    Container(
                      height: 100.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              topRight: Radius.circular(10.0)),
                          color: Color(0xFF0C60A8)),
                    ),
                    Positioned(
                      top: 50.0,
                      left: 94.0,
                      child: Container(
                        height: 90.0,
                        width: 90.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(45.0),
                            border: Border.all(
                                color: Colors.white,
                                style: BorderStyle.solid,
                                width: 2.0),
                            image: DecorationImage(
                                image: NetworkImage(this
                                    .cmdToSend
                                    .prestation
                                    .prestataire
                                    .image),
                                fit: BoxFit.cover)),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20.0),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child:
                      Text("Mr " + this.cmdToSend.prestation.prestataire.nom),
                ),
                this._etat1
                    ? (this._etat2
                        ? Text("Commande Terminée",
                            style: TextStyle(
                                fontSize: 14.0, color: Color(0xFF0C60A8)))
                        : Text("Commande Refusée",
                            style: TextStyle(
                                fontSize: 14.0, color: Color(0xFFC72230))))
                    : Text("Commande acceptée",
                        style: TextStyle(
                            fontSize: 14.0, color: Color(0xFF33B841))),
                SizedBox(height: 20.0),
                FlatButton(
                    color: Colors.transparent,
                    child: Center(
                      child: Text(
                        "OK",
                        style:
                            TextStyle(fontSize: 14.0, color: Color(0xFF0C60A8)),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    })
              ],
            ),
          ),
        );
//          AlertDialog(
//          title: Text('La commande N :',
//              style: new TextStyle(
//                color: Colors.blue[900],
//                fontSize: 14.0,
//                fontWeight: FontWeight.bold,
//              )),
//          content: Container(
//            width: double.maxFinite,
//            height: 120.0,
//            child: Column(
//              children: <Widget>[
//                new Divider(
//                  height: 5,
//                ),
//              ],
//            ),
//          ),
//          actions: <Widget>[
//            new FlatButton(
//              child: new Text('OK'),
//              onPressed: () {
//                Navigator.of(context).pop();
//              },
//            )
//          ],
//        );
      },
    );
  }

  /// Active la notification avec sound customiser cmd valide
  Future _showNotificationCmdVal() async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        icon: '@mipmap/ic_launcher',
        sound: 'iphone_notification',
        importance: Importance.Max,
        priority: Priority.High);
    var iOSPlatformChannelSpecifics =
        new IOSNotificationDetails(sound: "slow_spring_board.aiff");
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'ETakesh',
      'Commande acceptée',
      platformChannelSpecifics,
      payload: 'Custom_Sound',
    );
  }

  /// Active la notification pour les livraisons terminees
  Future _showNotificationCmdLV() async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        icon: '@mipmap/ic_launcher',
        sound: 'iphone_notification',
        importance: Importance.Max,
        priority: Priority.High);
    var iOSPlatformChannelSpecifics =
        new IOSNotificationDetails(sound: "slow_spring_board.aiff");
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'ETakesh',
      'Commande terminée',
      platformChannelSpecifics,
      payload: 'Custom_Sound',
    );
  }

  /// Active la notification pour les livraisons terminees
  Future _showNotificationCmdRe() async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        icon: '@mipmap/ic_launcher',
        sound: 'iphone_notification',
        importance: Importance.Max,
        priority: Priority.High);
    var iOSPlatformChannelSpecifics =
        new IOSNotificationDetails(sound: "slow_spring_board.aiff");
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'ETakesh',
      'Commande non validée',
      platformChannelSpecifics,
      payload: 'Custom_Sound',
    );
  }

  notification() {
    _presenter = new CommandeNotifPresenter();
    DatabaseHelper().getClient().then((Client1 c) {
      if (c != null)
        AppSharedPreferences().getToken().then((String token) {
          if (token != '')
            _presenter
                .getCmdValideClient(token, c.client_id)
                .then((List<CommandeDetail> cmds) {
              if (cmds != null && cmds.length > 0) {
                print("Cmd Valide" + cmds.toString());

                ///        Cmd Validee
                new DatabaseHelper()
                    .getCmdVal()
                    .then((List<CommandeLocal> cmdlocal) {
                  if (cmdlocal == null) {
                    this._etat1 = false;
                    for (int i = 0; i < cmds.length; i++) {
                      this.cmdToSend = cmds[i];
                      new DatabaseHelper().saveCmdVal(cmds[i]);
                      _showNotificationCmdVal();
                    }
                  } else {
                    new DatabaseHelper()
                        .getCmdVal()
                        .then((List<CommandeLocal> cmdlocal2) {
                      for (int i = 0; i < cmdlocal2.length; i++) {
                        _presenter
                            .loadCmdDetail(
                                token, c.client_id, cmdlocal2[i].commandeId)
                            .then((CommandeDetail cmd) {
                          if (cmd != null)

                          ///        Cmd terminees
                          if (cmd.is_terminated == true) {
                            this._etat1 = true;
                            this._etat2 = true;
                            this.cmdToSend = cmd;
                            _showNotificationCmdLV();
                            new DatabaseHelper().clearCmdVal();
                          } else if (cmd.is_refused == true) {
                            this._etat1 = true;
                            this._etat2 = false;
                            this.cmdToSend = cmd;
                            _showNotificationCmdRe();
                          }
                        });
                      }
                    });
                  }
                });
              }
            });
        });
    });
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return null;
  }
}
