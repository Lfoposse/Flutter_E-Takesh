import 'dart:async';
import 'dart:convert';

import 'package:etakesh_client/Models/clients.dart';
import 'package:etakesh_client/Models/services.dart';

import 'NetworkUtil.dart';

class RestDatasource {
  NetworkUtil _netUtil = new NetworkUtil();
  static final BASE_URL = "http://api.e-takesh.com:26960/api/";
  static final LOGIN_URL = BASE_URL + "Users/login";
  static final ONE_USER = BASE_URL + "clients/findOne";
  static final SERVICE_URL = BASE_URL + "services";
  static final CREATE_USER = BASE_URL + "Users";

  ///provisoire
  static final FILTER = "&filter=";
  static final TOKEN1 = "?access_token=";

  ///retourne les informations d'un compte client a partir de ses identifiants
  Future<Login2> login(String username, String password) {
    return _netUtil.post(LOGIN_URL,
        body: {"email": username, "password": password}).then((dynamic res) {
      if (res != null) {
//        ClientLognin client;
//        client.token = res["id"];
//        client.date = res["created"];
//        client.userId = res["userId"];
//        print(client);
        return Login2.fromJson(json.decode(res));
      } else
        return null;
    }).catchError(
        (onError) => new Future.error(new Exception(onError.toString())));
  }

  Future<Client1> getClient(int userID, String token) {
    var filter = """{
      "where": {"UserId": $userID}
    }""";
    return _netUtil
        .getOne(
      ONE_USER + TOKEN1 + token + FILTER + filter,
//      headers: {HttpHeaders.acceptHeader: "application/json"},
    )
        .then((dynamic res) {
      if (res != null)
        return Client1.fromJson(json.decode(res));
      else
        return null;
    }).catchError(
            (onError) => new Future.error(new Exception(onError.toString())));
  }

//  Future<UserCreate> createUser(String username, String password) {
//    return _netUtil.post(CREATE_USER,
//        body: {"email": username, "password": password}).then((dynamic res) {
//      if (res["code"] == 200)
//        return UserCreate.map(res["data"]);
//      else
//        return null;
//    }).catchError(
//        (onError) => new Future.error(new Exception(onError.toString())));
//  }

  Future<List<Service>> getService(String token) {
    return _netUtil.get(SERVICE_URL + TOKEN1 + token).then((dynamic res) {
      if (res != null)
        return (res as List).map((item) => new Service.map(item)).toList();
      else
        return null as List<Service>;
    }).catchError(
        (onError) => new Future.error(new Exception(onError.toString())));
  }
}
