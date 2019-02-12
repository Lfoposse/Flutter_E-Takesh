import 'dart:async';

import 'package:etakesh_client/Models/clients.dart';
import 'package:etakesh_client/Models/services.dart';

import 'NetworkUtil.dart';

class RestDatasource {
  NetworkUtil _netUtil = new NetworkUtil();
  static final BASE_URL = "http://api.e-takesh.com:26960/api/";
  static final TOKEN =
      "uZzQiR1abvuQqVBoQV1SRp3uVxhQ65CNU3QfSSr2rQZWJieP59c5CUpyhjfbB8p1";
  static final LOGIN_URL = BASE_URL + "users/login";
  static final SERVICE_URL = BASE_URL + "services";

  ///retourne les informations d'un compte client a partir de ses identifiants
  Future<Client> login(
      String username, String password, bool checkAccountExists) {
    return _netUtil.post(LOGIN_URL,
        body: {"email": username, "password": password}).then((dynamic res) {
      //print(res.toString());
      if (checkAccountExists && res["code"] == 4008)
        return Client.empty();
      else if (res["code"] == 200 &&
          (res["data"]["role"][0].toString() == "ROLE_DELIVER"))
        return Client.map(res["data"]);
      else
        return null;
    }).catchError(
        (onError) => new Future.error(new Exception(onError.toString())));
  }

  Future<List<Service>> getService() {
    return _netUtil
        .get(
            "http://api.e-takesh.com:26960/api/services?access_token=uZzQiR1abvuQqVBoQV1SRp3uVxhQ65CNU3QfSSr2rQZWJieP59c5CUpyhjfbB8p1")
        .then((dynamic res) {
      if (res != null)
        return (res as List).map((item) => new Service.map(item)).toList();
      else
        return null as List<Service>;
    }).catchError(
            (onError) => new Future.error(new Exception(onError.toString())));
  }
}
