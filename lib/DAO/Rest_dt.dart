import 'dart:async';
import 'dart:convert';

import 'package:etakesh_client/Models/clients.dart';
import 'package:etakesh_client/Models/commande.dart';
import 'package:etakesh_client/Models/prestataires.dart';
import 'package:etakesh_client/Models/services.dart';
import 'package:http/http.dart' as http;

import 'NetworkUtil.dart';

const kGoogleApiKey = "AIzaSyBNm8cnYw5inbqzgw8LjXyt3rMhFhEVTjY";

class RestDatasource {
  NetworkUtil _netUtil = new NetworkUtil();
  static final BASE_URL = "http://api.e-takesh.com:26960/api/";
  static final LOGIN_URL = BASE_URL + "Users/login";
  static final ONE_USER = BASE_URL + "clients/findOne";
  static final CMD_URL = BASE_URL + "commandes";
  static final POSITIONS_URL = BASE_URL + "positions";
  static final SERVICE_URL = BASE_URL + "services";
  static final CREATE_USER = BASE_URL + "Users";
  static final GOOGLE_MAP_URL =
      "https://maps.googleapis.com/maps/api/place/autocomplete/json";
  static final PRESTATION = BASE_URL + "prestations";
  static final ALLPRESTATAIRE =
      PRESTATION + "?filter[include]=prestataire&filter[include]=vehicule";
  static final CMD_PRESTATION = CMD_URL +
      "?filter[include][prestation]=service&filter[include][prestation]=vehicule&filter[include][prestation]=prestataire";
  static final CMD_PRESTATION_DETAIL =
      "?filter[include][prestation]=service&filter[include][prestation]=vehicule&filter[include][prestation]=prestataire";

  ///provisoire
  static final FILTER = "&filter=";
  static final FILTERSERVICE = "&filter[where][serviceId]=";
  static final FILTERCLIENT = "&filter[where][clientId]=";
  static final CMDCREATE =
      "&filter[where][is_created]=true&filter[where][is_terminated]=false";
  static final CMDVALIDE =
      "&filter[where][is_accepted]=true&filter[where][is_terminated]=false";
  static final CMDTERMINE =
      "&filter[where][is_accepted]=true&filter[where][is_terminated]=true";
  static final CMDOLD = "&filter[where][is_terminated]=true";
  static final TOKEN1 = "?access_token=";
  static final TOKEN2 = "&access_token=";

  ///retourne les informations(token) d'un compte client a partir de ses identifiants
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

  ///Retourne un client
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

  ///Liste des services offerts par ETakesh
  Future<List<Service>> getService(String token) {
    return _netUtil.get(SERVICE_URL + TOKEN1 + token).then((dynamic res) {
      if (res != null)
        return (res as List).map((item) => new Service.fromJson(item)).toList();
      else
        return null as List<Service>;
    }).catchError(
        (onError) => new Future.error(new Exception(onError.toString())));
  }

  ///Liste toutes les commandes passees par client
  Future<List<CommandeDetail>> getNewCmdClient(String token, int clientId) {
    return _netUtil
        .get(CMD_PRESTATION +
            FILTERCLIENT +
            clientId.toString() +
            CMDCREATE +
            TOKEN2 +
            token)
        .then((dynamic res) {
      if (res != null)
        return (res as List)
            .map((item) => new CommandeDetail.fromJson(item))
            .toList();
      else
        return null as List<CommandeDetail>;
    }).catchError(
            (onError) => new Future.error(new Exception(onError.toString())));
  }

  ///Liste toutes les commandes acceptee du client
  Future<List<CommandeDetail>> getCmdValideClient(String token, int clientId) {
    return _netUtil
        .get(CMD_PRESTATION +
            FILTERCLIENT +
            clientId.toString() +
            CMDVALIDE +
            TOKEN2 +
            token)
        .then((dynamic res) {
      if (res != null)
        return (res as List)
            .map((item) => new CommandeDetail.fromJson(item))
            .toList();
      else
        return null as List<CommandeDetail>;
    }).catchError(
            (onError) => new Future.error(new Exception(onError.toString())));
  }

  ///Details sur ume commande
  Future<CommandeDetail> getCmdClient(String token, int clientId, int cmdId) {
    return _netUtil
        .get(CMD_URL +
            "/" +
            cmdId.toString() +
            CMD_PRESTATION_DETAIL +
            FILTERCLIENT +
            clientId.toString() +
            CMDVALIDE +
            TOKEN2 +
            token)
        .then((dynamic res) {
      if (res != null) return new CommandeDetail.fromJson(res);
    }).catchError(
            (onError) => new Future.error(new Exception(onError.toString())));
  }

  ///Liste les anciennes commandes deja effectuees par client
  Future<List<CommandeDetail>> getOldCmdClient(String token, int clientId) {
    return _netUtil
        .get(CMD_PRESTATION +
            FILTERCLIENT +
            clientId.toString() +
            CMDOLD +
            TOKEN2 +
            token)
        .then((dynamic res) {
      if (res != null)
        return (res as List)
            .map((item) => new CommandeDetail.fromJson(item))
            .toList();
      else
        return null as List<CommandeDetail>;
    }).catchError(
            (onError) => new Future.error(new Exception(onError.toString())));
  }

  /// liste des prestataires avec leur vehicules
  Future<List<PrestataireService>> getAllPrestatairesServices(
      String token, int serviceId) {
    return _netUtil
        .get(ALLPRESTATAIRE +
            FILTERSERVICE +
            serviceId.toString() +
            TOKEN2 +
            token)
        .then((dynamic res) {
      if (res != null)
        return (res as List)
            .map((item) => new PrestataireService.fromJson(item))
            .toList();
      else
        return null as List<PrestataireService>;
    }).catchError(
            (onError) => new Future.error(new Exception(onError.toString())));
  }

  ///Enregistre une position(destination,position) dans le serveur
  Future<PositionModel> savePosition(
      double lat, double lng, String libele, String token) {
    return _netUtil.post(POSITIONS_URL + TOKEN1 + token, body: {
      "latitude": lat.toString(),
      "longitude": lng.toString(),
      "libelle": libele,
    }).then((dynamic res) {
      if (res != null) {
        return PositionModel.fromJson(json.decode(res));
      } else
        return null;
    }).catchError(
        (onError) => new Future.error(new Exception(onError.toString())));
  }

  ///Enregistre une commande dans le serveur
  Future<Commande> saveCmd(
      int montant, int post, int dest, int client, int prest, String token) {
    return _netUtil.post(CMD_URL + TOKEN1 + token, body: {
      "montant": montant.toString(),
      "date": DateTime.now().toString(),
      "date_debut": DateTime.now().toString(),
      "date_fin": DateTime.now().toString(),
      "status": "CREATED",
      "position_prise_en_charge": post.toString(),
      "position_destination": dest.toString(),
      "code": "ET" +
          DateTime.now().month.toString() +
          DateTime.now().day.toString() +
          DateTime.now().hour.toString() +
          DateTime.now().second.toString() +
          "CMD" +
          DateTime.now().year.toString(),
      "distance_client_prestataire": "3",
      "duree_client_prestataire": "30",
      "position_priseId": post.toString(),
      "position_destId": dest.toString(),
      "rate_comment": "No",
      "rate_value": "0",
      "is_created": true.toString(),
      "is_accepted": false.toString(),
      "is_refused": false.toString(),
      "is_terminated": false.toString(),
      "clientId": client.toString(),
      "prestationId": prest.toString()
    }).then((dynamic res) {
      if (res != null) {
        print("Save Cmd");
        return Commande.fromJson(json.decode(res));
      } else
        return null;
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
