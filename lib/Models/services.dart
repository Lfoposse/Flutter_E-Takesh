class Service1 {
  final int serviceid;
  final String code;
  final String intitule;
  final int prix;

  Service1({this.serviceid, this.code, this.intitule, this.prix});

  factory Service1.fromJson(Map<String, dynamic> json) {
    return Service1(
      serviceid: json['serviceid'],
      code: json['code'],
      intitule: json['intitule'],
      prix: json['prix'],
    );
  }
}

class Login {
  final String id;
  final String ttl;
  final String created;
  final int userId;

  Login({this.id, this.created, this.userId, this.ttl});

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
        id: json['id'],
        ttl: json['ttl'],
        created: json['created'],
        userId: json['userId']);
  }
}

class UserCreate {
  final int id;
  final String email;

  UserCreate({
    this.id,
    this.email,
  });

  factory UserCreate.fromJson(Map<String, dynamic> json) {
    return UserCreate(id: json['id'], email: json['ttl']);
  }
}

class Service {
  int _serviceid;
  String _code;
  String _intitule;
  int _prix;
  int _prix_douala;
  int _prix_yaounde;

  Service(this._serviceid, this._code, this._intitule, this._prix,
      this._prix_douala, this._prix_yaounde);

  Service.empty() {
    this._serviceid = null;
    this._code = null;
    this._intitule = null;
    this._prix = null;
    this._prix_douala = null;
    this._prix_yaounde = null;
  }

  Service.map(dynamic obj) {
    this._serviceid = obj["serviceid"];
    this._code = obj["code"];
    this._intitule = obj["intitule"];
    this._prix = obj["prix"];
    this._prix_douala = obj["prix_douala"];
    this._prix_yaounde = obj["prix_yaounde"];
  }

  int get prix => _prix;

  set prix(int value) {
    _prix = value;
  }

  String get intitule => _intitule;

  set intitule(String value) {
    _intitule = value;
  }

  String get code => _code;

  set code(String value) {
    _code = value;
  }

  int get serviceid => _serviceid;

  set serviceid(int value) {
    _serviceid = value;
  }

  int get prix_yaounde => _prix_yaounde;

  set prix_yaounde(int value) {
    _prix_yaounde = value;
  }

  int get prix_douala => _prix_douala;

  set prix_douala(int value) {
    _prix_douala = value;
  }
}
