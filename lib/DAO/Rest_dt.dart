import 'dart:async';

import 'package:etakesh_client/Models/clients.dart';
import 'package:etakesh_client/Models/services.dart';

import 'NetworkUtil.dart';

class RestDatasource {
  NetworkUtil _netUtil = new NetworkUtil();
  static final BASE_URL = "http://api.e-takesh.com:26960/api/";
  static final LOGIN_URL = BASE_URL + "Users/login";
  static final ONE_USER = BASE_URL + "clients/findOne?filter=";
  static final SERVICE_URL = BASE_URL + "services?";
  static final CREATE_USER = BASE_URL + "Users";

  ///provisoire
  static final TOKEN =
      "access_token=cZyOtFWiZFAZvxeMc4iGRUPeRXBMP5IEV5Z9pwssqJk5J2w037dXiJLMNCKPFFFZ";

  ///retourne les informations d'un compte client a partir de ses identifiants
  Future<ClientLognin> login(String username, String password) {
    return _netUtil.post(LOGIN_URL,
        body: {"email": username, "password": password}).then((dynamic res) {
      if (res != null) {
        print("resp " + res);
        ClientLognin client;
        client.token = res["id"];
        client.date = res["created"];
        client.userId = res["userId"];
        return client;
      } else
        return null;
    }).catchError(
        (onError) => new Future.error(new Exception(onError.toString())));
  }

  Future<Client> getClient() {
    return _netUtil
        .get(
      ONE_USER,
    )
        .then((dynamic res) {
      if (res != null)
        return Client.map(res);
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

  Future<List<Service>> getService() {
    return _netUtil
        .get(
            "http://api.e-takesh.com:26960/api/services?access_token=kdmbnCPzD2TkZIsCNG29Q7uy6SA5YCbgdZZJTYScU1HTiZe82DCyvTeQpij8lnhX")
        .then((dynamic res) {
      if (res != null)
        return (res as List).map((item) => new Service.map(item)).toList();
      else
        return null as List<Service>;
    }).catchError(
            (onError) => new Future.error(new Exception(onError.toString())));
  }
}
