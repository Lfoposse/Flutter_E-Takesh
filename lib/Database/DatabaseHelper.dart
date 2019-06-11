import 'dart:async';
import 'dart:io' as io;

import 'package:etakesh_client/Models/clients.dart';
import 'package:etakesh_client/Models/commande.dart';
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
    await db.execute(" DROP TABLE IF EXISTS CmdVal");
    //then

    // create table client where store the connected account informations
    await db.execute("CREATE TABLE Client("
        "id INTEGER PRIMARY KEY, "
        "client_id INTEGER NOT NULL UNIQUE, "
        "user_id INTEGER NOT NULL UNIQUE, "
        "nom TEXT, "
        "prenom TEXT, "
        "email TEXT NOT NULL, "
        "phone TEXT, "
        "date_naissance TEXT, "
        "pays TEXT, "
        "ville TEXT, "
        "date_creation TEXT, "
        "image TEXT, "
        "code TEXT, "
        "status TEXT, "
        "positionId TEXT, "
        "adresse TEXT, "
        "UserId INTEGER "
        ")");

    // create table client where store the connected account informations
    await db.execute("CREATE TABLE User("
        "id INTEGER PRIMARY KEY, "
        "userId INTEGER NOT NULL UNIQUE, "
        "token TEXT, "
        "date TEXT, "
        "ttl INTEGER "
        ")");

    // create table cmdvalide where store the validated orders
    await db.execute("CREATE TABLE CmdVal("
        "id INTEGER PRIMARY KEY, "
        "clientId INTEGER NOT NULL, "
        "prestataireId INTEGER NOT NULL, "
        "cmdId INTEGER NOT NULL UNIQUE, "
        "prestationId INTEGER NOT NULL, "
        "date TEXT "
        ")");
    // create table cmdvalide where store the validated orders
//    await db.execute("CREATE TABLE CmdRef("
//        "id INTEGER PRIMARY KEY, "
//        "clientId INTEGER NOT NULL, "
//        "prestataireId INTEGER NOT NULL, "
//        "cmdId INTEGER NOT NULL UNIQUE, "
//        "prestationId INTEGER NOT NULL, "
//        "date TEXT "
//        ")");
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

  Future<int> clearCmdVal(int cmdi) async {
    var tbCmd = await db;
    int res = await tbCmd
        .rawDelete('DELETE FROM CmdVal WHERE cmdId = ' + cmdi.toString());
    return res;
  }
//
//  Future<int> clearCmdRef() async {
//    var tbCmd = await db;
//    int res = await tbCmd.rawDelete('DELETE FROM CmdRef');
//    return res;
//  }

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
        'INSERT INTO Client(client_id, user_id, nom, prenom, email, phone, date_naissance, pays, ville, date_creation, image, code, status, positionId, UserId, adresse) VALUES(' +
            c.client_id.toString() +
            ',\'' +
            c.user_id.toString() +
            '\',\'' +
            c.nom +
            '\',\'' +
            c.prenom +
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
            '\',\'' +
            c.date_creation +
            '\',\'' +
            c.image +
            '\',\'' +
            c.code +
            '\',\'' +
            c.status +
            '\',\'' +
            c.positionId +
            '\',\'' +
            c.password +
            '\',\'' +
            c.adresse +
            '\')';
    await tbClient.rawInsert(sql);
    print("saved client infos " + sql.toString());
    return 0;
  }

  Future<bool> updateClient(Client1 client) async {
    print("update client  = " + client.toMap().toString());
    var dbClient = await db;
    int res = await dbClient.update("Client", client.toMap(),
        where: "client_id = ?", whereArgs: <int>[client.client_id]);
    return res > 0;
  }

  Future<int> saveCmdVal(CommandeDetail cmd) async {
    var tbClient = await db;
    String sql =
        'INSERT INTO CmdVal(clientId, prestataireId, cmdId, prestationId, date) VALUES(' +
            cmd.clientId +
            ',\'' +
            cmd.prestation.prestataire.prestataireid.toString() +
            '\',\'' +
            cmd.commandeid.toString() +
            '\',\'' +
            cmd.prestationId.toString() +
            '\',\'' +
            cmd.date.toString() +
            '\')';
    await tbClient.rawInsert(sql);
    print("saved cmd valide " + sql.toString());
    return 0;
  }

//  Future<int> saveCmdRef(CommandeDetail cmd) async {
//    var tbClient = await db;
//    String sql =
//        'INSERT INTO CmdRef(clientId, prestataireId, cmdId, prestationId, date) VALUES(' +
//            cmd.clientId +
//            ',\'' +
//            cmd.prestation.prestataire.prestataireid.toString() +
//            '\',\'' +
//            cmd.commandeid.toString() +
//            '\',\'' +
//            cmd.prestationId.toString() +
//            '\',\'' +
//            cmd.date +
//            '\')';
//    await tbClient.rawInsert(sql);
//    print("saved cmd valide " + sql.toString());
//    return 0;
//  }
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
    print("Content DBClient");
    print(list);
    Client1 client;
    if (list.length != 0) {
      client = new Client1.fromJson2(list[0]);
      return client;
    } else {
      return null;
    }
  }

  Future<Login2> getUser() async {
    var tbUser = await db;
    List<Map> list =
        await tbUser.rawQuery('SELECT * FROM User ORDER BY id DESC LIMIT 1');
    Login2 user;
    print("Content DBUser");
    print(list);
    if (list.length != 0) {
      user = new Login2.fromJson2(list[0]);
      return user;
    } else {
      return null;
    }
  }

  Future<List<CommandeLocal>> getCmdVal() async {
    var tbCmd = await db;
    List<Map> list =
        await tbCmd.rawQuery('SELECT * FROM CmdVal ORDER BY id DESC LIMIT 1');

    print("Content DBCmdValide");
    print(list);
    if (list.length != 0) {
      print("Cmd val loc db:" + list.toString());
      List<CommandeLocal> cmds = new List();
      for (int i = 0; i < list.length; i++) {
        var cmd = new CommandeLocal.fromJson(list[0]);
        cmds.add(cmd);
      }
      return cmds;
    } else {
      return null as List<CommandeLocal>;
    }
  }
//
//  Future<List<CommandeLocal>> getCmdRef() async {
//    var tbCmd = await db;
//    List<Map> list =
//        await tbCmd.rawQuery('SELECT * FROM CmdRef ORDER BY id DESC LIMIT 1');
//
//    print("Content DBCmdRef");
//    print(list);
//    if (list.length != 0) {
//      print("Cmd ref loc db:" + list.toString());
//      List<CommandeLocal> cmds = new List();
//      for (int i = 0; i < list.length; i++) {
//        var cmd = new CommandeLocal.fromJson(list[0]);
//        cmds.add(cmd);
//      }
//      return cmds;
//    } else {
//      return null as List<CommandeLocal>;
//    }
//  }
}
