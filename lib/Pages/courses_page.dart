import 'package:flutter/material.dart';

class CoursesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: new AppBar(
              bottom: TabBar(
                indicatorColor: Color(0xFF2773A1),
                tabs: [
                  Tab(
                    child: Text(
                      "Anciennes",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "A venir",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              title: new Text(
                'Mes courses',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.black,
              iconTheme: IconThemeData(color: Colors.white),
            ),
            body: TabBarView(
              children: [
                ListView(
                  children: <Widget>[
                    listItem("Course", "MEA8756", "4h15min", Color(0xFF0C60A8)),
                    listItem("Depot", "ORA7746", "3h10min", Color(0xFFC72230)),
                    listItem("Prive", "DAA8740", "1h10min", Color(0xFFDEAC17)),
                    listItem("Aeropot", "PEA8746", "10min", Color(0xFF33B841))
                  ],
                ),

                ///si on n'a pas encore effectuer une course
//                Center(
//                  child: Text("Vous n'avez pas encore effectue de course"),
//                ),
                ListView(
                  children: <Widget>[
                    listItem("Course", "MEA8756", "4h15min", Color(0xFF0C60A8)),
                    listItem("Depot", "ORA7746", "3h10min", Color(0xFFC72230)),
                    listItem("Prive", "DAA8740", "1h10min", Color(0xFFDEAC17)),
                    listItem("Aeropot", "PEA8746", "10min", Color(0xFF33B841))
                  ],
                ),

                ///si on n'a pas aucune course programmee
//                Center(
//                  child: Text("Vous n'avez aucune course planifiee"),
//                )
              ],
            )));
  }

  Widget listItem(String title, String cmd, String time, Color color) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Container(
          color: Color(0x88F9FAFC),
          child: Row(
            children: <Widget>[
              new Padding(
                padding: new EdgeInsets.symmetric(horizontal: 32.0 - 12.0 / 2),
                child: new Container(
                  height: 12.0,
                  width: 12.0,
                  decoration:
                      new BoxDecoration(shape: BoxShape.circle, color: color),
                ),
              ),
              new Expanded(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text(
                      title,
                      style: new TextStyle(
                          fontSize: 18.0, color: Color(0xFF9FA0A2)),
                    ),
                    SizedBox(
                      height: 7.0,
                    ),
                    new Text(
                      'Commande No ' + cmd,
                      style: new TextStyle(
                          fontSize: 12.0,
                          color: Color(0xFF9FA0A2).withOpacity(0.5)),
                    )
                  ],
                ),
              ),
              new Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    new Text(
                      "Aujourd'hui",
                      style: new TextStyle(
                        fontSize: 14.0,
                        color: Color(0xFF50AED8),
                      ),
                    ),
                    SizedBox(
                      height: 7.0,
                    ),
                    new Text(
                      "il y'a 20 " + time,
                      style: new TextStyle(
                          fontSize: 12.0, color: Color(0xFF93BFD8)),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
