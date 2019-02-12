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
    // create table client where store the connected account informations
    await db.execute("CREATE TABLE Client("
        "id INTEGER PRIMARY KEY, "
        "client_id INTEGER NOT NULL UNIQUE, "
        "username TEXT, "
        "firstname TEXT, "
        "lastname TEXT, "
        "email TEXT NOT NULL, "
        "phone TEXT "
        ")");
  }

  Future<int> clearClient() async {
    var dbProduit = await db;
    int res = await dbProduit.rawDelete('DELETE FROM Client');
    return res;
  }

  Future<int> saveClient(Client c) async {
    String sql =
        'INSERT INTO Client(client_id, username, firstname, lastname,email,phone ) VALUES(' +
            c.id.toString() +
            ',\'' +
            c.username +
            '\',\'' +
            c.lastname +
            '\',\'' +
            c.lastname +
            '\',\'' +
            c.email +
            '\',\'' +
            c.email +
            '\')';
    //int res = await dbProduit.rawInsert(sql);
    print("saved client id = " + sql.toString());
    return 0;
  }

  Future<int> addClient(Client t) async {
    var dbProduit = await db;
    int res = await dbProduit.insert("Client", t.toMap());
    print("client " + t.email + "has add succesful to the database");
    return res;
  }

  Future<Client> getClient() async {
    var dbProduit = await db;
    List<Map> list = await dbProduit
        .rawQuery('SELECT * FROM Client ORDER BY id DESC LIMIT 1');
    Client client;

    client = new Client(list[0]["client_id"], list[0]["username"],
        list[0]["lastname"], list[0]["email"]);

    return client;
  }
}
