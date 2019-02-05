import 'package:flutter/material.dart';
import 'package:etakesh_client/pages/courses_page.dart';
import 'package:etakesh_client/pages/parameters_page.dart';
import 'package:etakesh_client/pages/tarifs_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text('Etakesh'),backgroundColor: Colors.lightBlue,),
     drawer: new Drawer(

       child: ListView(
         children: <Widget>[
           new UserAccountsDrawerHeader(
               accountName: new Text('Rainbow Cl'),
               accountEmail: new Text('wilfried@rainbowcl.net'),
               currentAccountPicture: new GestureDetector(
                 child: new CircleAvatar(
                   backgroundImage: new AssetImage('assets/images/avatar.jpg'),
                 ),
               ),
             decoration: new BoxDecoration(
               color: Colors.black87,
//               shape: BoxShape.rectangle
             ),
           ),
           new ListTile(
             title: new Text('Vos courses'),
             onTap: (){
               Navigator.of(context).pop();
               Navigator.push(
                 context,
                 new MaterialPageRoute(builder: (context) => CoursesPage()),
               );
             },
           ),
           new ListTile(
             title: new Text('Consulter les tarifs'),
             onTap: (){
               Navigator.of(context).pop();
               Navigator.push(
                 context,
                 new MaterialPageRoute(builder: (context) => TarifsPage()),
               );
             },
           ),
           new ListTile(
             title: new Text('Parametres'),
             onTap: (){
               Navigator.of(context).pop();
               Navigator.push(
                 context,
                 new MaterialPageRoute(builder: (context) => ParametersPage()),
               );
             },
           ),
//           proposition : ferner + icon
         Divider(),
           new ListTile(
             title: new Text('Fermer'),
             trailing: new Icon(Icons.cancel),
             onTap: ()=> Navigator.of(context).pop(),
           ),
         ],
       ),
     ),
      body: new Center(

        child: new Text('Map content'),
      ),
    );
  }
}