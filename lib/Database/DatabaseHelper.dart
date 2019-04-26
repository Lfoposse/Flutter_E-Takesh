import 'dart:async';
import 'dart:io' as io;

import 'package:etakesh_client/Models/clients.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "etakesh_client_v1.db");
    var theDb = await openDatabase(path, version: 13, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    //after this
    // drop table if already exist
    await db.execute(" DROP TABLE IF EXISTS Client");
    //then

    // create table client where store the connected account informations
    await db.execute("CREATE TABLE Client("
        "id INTEGER PRIMARY KEY, "
        "client_id INTEGER NOT NULL UNIQUE, "
        "username TEXT, "
        "lastname TEXT, "
        "email TEXT NOT NULL, "
        "phone TEXT "
        ")");
  }

  Future<int> clearClient() async {
    var tbClient = await db;
    int res = await tbClient.rawDelete('DELETE FROM Client');
    return res;
  }

  Future<int> saveClient(Client c) async {
    var tbClient = await db;
    String sql =
        'INSERT INTO Client(client_id, username, lastname, email, phone ) VALUES(' +
            c.id_client.toString() +
            ',\'' +
            c.username +
            '\',\'' +
            c.lastname +
            '\',\'' +
            c.email +
            '\',\'' +
            c.phone +
            '\')';
    await tbClient.rawInsert(sql);
    print("saved client infos " + sql.toString());
    return 0;
  }

//  Future<int> addClient(Client t) async {
//    var tbClient = await db;
//    int res = await tbClient.insert("Client", t.toMap());
//    print("client " + t.email + "has add succesful to the database");
//    return res;
//  }

  Future<Client> getClient() async {
    var tbClient = await db;
    List<Map> list = await tbClient
        .rawQuery('SELECT * FROM Client ORDER BY id DESC LIMIT 1');
    Client client;

    client = new Client(
      list[0]["client_id"],
      list[0]["username"],
      list[0]["lastname"],
      list[0]["email"],
      list[0]["phone"],
    );

    return client;
  }
}
