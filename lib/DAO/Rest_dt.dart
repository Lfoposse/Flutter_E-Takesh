import 'dart:async';
import 'dart:convert';

import 'package:etakesh_client/Models/clients.dart';
import 'package:etakesh_client/Models/services.dart';
import 'package:http/http.dart' as http;

import 'NetworkUtil.dart';

const kGoogleApiKey = "AIzaSyBNm8cnYw5inbqzgw8LjXyt3rMhFhEVTjY";

class RestDatasource {
  NetworkUtil _netUtil = new NetworkUtil();
  static final BASE_URL = "http://api.e-takesh.com:26960/api/";
  static final LOGIN_URL = BASE_URL + "Users/login";
  static final ONE_USER = BASE_URL + "clients/findOne";
  static final SERVICE_URL = BASE_URL + "services";
  static final CREATE_USER = BASE_URL + "Users";
  static final GOOGLE_MAP_URL =
      "https://maps.googleapis.com/maps/api/place/autocomplete/json";

  ///provisoire
  static final FILTER = "&filter=";
  static final TOKEN1 = "?access_token=";

  ///retourne les informations d'un compte client a partir de ses identifiants
  Future<Login2> login(String username, String password) {
    return _netUtil.post(LOGIN_URL,
        body: {"email": username, "password": password}).then((dynamic res) {
      if (res != null) {
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

  Future<List<Service>> getService(String token) {
    return _netUtil.get(SERVICE_URL + TOKEN1 + token).then((dynamic res) {
      if (res != null)
        return (res as List).map((item) => new Service.map(item)).toList();
      else
        return null as List<Service>;
    }).catchError(
        (onError) => new Future.error(new Exception(onError.toString())));
  }

  Future findLocation(String keyword, String lang, double lat, double lng) {
    var url = GOOGLE_MAP_URL +
        "?input=" +
        keyword +
        "&language=" +
        lang +
        "&key=" +
        kGoogleApiKey +
        "&location=" +
        lat.toString() +
        "," +
        lng.toString() +
        "&radius=800";
    return http.get(url);
  }
}
//dio 1.0.13 package for searh nearby place
//  Future<void> searchNearby(String keyword) async {
//    var dio = Dio();
//    var url = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json';
//    var params = {
//      'key': kGoogleApiKey,
//      'location': '$mylat,$mylng',
//      'radius': '800',
//      'keyword': keyword,
//    };
//    var response = await dio.get(url, data: params);
//    print("Search Result");
//    print(response.data['results'].toString());
//  }
