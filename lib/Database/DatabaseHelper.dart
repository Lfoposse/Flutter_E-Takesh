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
    await db.execute(" DROP TABLE IF EXISTS User");
    //then

    // create table client where store the connected account informations
    await db.execute("CREATE TABLE Client("
        "id INTEGER PRIMARY KEY, "
        "client_id INTEGER NOT NULL UNIQUE, "
        "user_id INTEGER NOT NULL UNIQUE, "
        "username TEXT, "
        "lastname TEXT, "
        "email TEXT NOT NULL, "
        "phone TEXT, "
        "date_naissance TEXT, "
        "pays TEXT, "
        "ville TEXT "
        ")");

    // create table client where store the connected account informations
    await db.execute("CREATE TABLE User("
        "id INTEGER PRIMARY KEY, "
        "userId INTEGER NOT NULL UNIQUE, "
        "token TEXT, "
        "date TEXT, "
        "ttl INTEGER "
        ")");
  }

  Future<int> clearClient() async {
    var tbClient = await db;
    int res = await tbClient.rawDelete('DELETE FROM Client');
    return res;
  }

  Future<int> clearUser() async {
    var tbUser = await db;
    int res = await tbUser.rawDelete('DELETE FROM User');
    return res;
  }

  Future<int> saveUser(Login2 l) async {
    var tbUser = await db;
    String sql = 'INSERT INTO User(userId, token, date, ttl) VALUES(' +
        l.userId.toString() +
        ',\'' +
        l.token +
        '\',\'' +
        l.date +
        '\',\'' +
        l.ttl.toString() +
        '\')';
    await tbUser.rawInsert(sql);
    print("saved user infos " + sql.toString());
    return 0;
  }

  Future<int> saveClient(Client1 c) async {
    var tbClient = await db;
    String sql =
        'INSERT INTO Client(client_id, user_id, username, lastname, email, phone, date_naissance, pays, ville) VALUES(' +
            c.client_id.toString() +
            ',\'' +
            c.user_id.toString() +
            '\',\'' +
            c.username +
            '\',\'' +
            c.lastname +
            '\',\'' +
            c.email +
            '\',\'' +
            c.phone +
            '\',\'' +
            c.date_naissance +
            '\',\'' +
            c.pays +
            '\',\'' +
            c.ville +
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

  Future<Client1> getClient() async {
    var tbClient = await db;
    List<Map> list = await tbClient
        .rawQuery('SELECT * FROM Client ORDER BY id DESC LIMIT 1');
    Client1 client;

    client = new Client1.fromJson2(list[0]);

    return client;
  }

  Future<Login2> getUser() async {
    var tbUser = await db;
    List<Map> list =
        await tbUser.rawQuery('SELECT * FROM User ORDER BY id DESC LIMIT 1');
    Login2 user;
    user = new Login2.fromJson2(list[0]);
    return user;
  }
}
