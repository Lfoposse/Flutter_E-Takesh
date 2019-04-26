class Client {
  int _client_id;
  int _user_id;
  String _email;
  String _username;
  String _lastname;
  String _phone;
  String _date_naissance;
  String _pays;
  String _ville;
  String _adresse;

  // List<String> _roles;

  Client.empty() {
    this._username = null;
    this._lastname = null;
    this._email = null;
    this._phone = null;
    this._date_naissance = null;
    this._pays = null;
    this._ville = null;
    this._adresse = null;
  }

  Client(this._client_id, this._username, this._lastname, this._email,
      this._phone);

  Client.map(dynamic obj) {
    this._client_id = obj["clientid"];
    this._username = obj["nom"];
    this._lastname = obj["prenom"];
    this._email = obj["email"];
    this._phone = obj["telephone"];
    this._date_naissance = obj["date_naissance"];
    this._ville = obj["ville"];
    this._pays = obj["pays"];
    this._adresse = obj["adresse"];
  }

  int get id_client => _client_id;
  int get user_id => _user_id;
  String get username => _username;
  String get lastname => _lastname;
  String get email => _email;
  String get phone => _phone;
  String get date_naissance => _date_naissance;
  String get ville => _ville;
  String get pays => _pays;
  String get adresse => _adresse;

  //List<String> get roles => _roles;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["client_id"] = _client_id;
    map["nom"] = _username;
    map["prenom"] = lastname;
    map["telephone"] = _phone;
    map["email"] = _email;
    map["date_naissance"] = _date_naissance;
    map["ville"] = _ville;
    map["pays"] = _pays;
    map["adresse"] = _adresse;
    return map;
  }

  set phone(String value) {
    _phone = value;
  }

  set id_client(int value) {
    _client_id = value;
  }

  set email(String value) {
    _email = value;
  }

  set lastname(String value) {
    _lastname = value;
  }

  set username(String value) {
    _username = value;
  }

  set user_id(int value) {
    _user_id = value;
  }

  set date_naissance(String value) {
    _date_naissance = value;
  }

  set ville(String value) {
    _ville = value;
  }

  set pays(String value) {
    _pays = value;
  }

  set adresse(String value) {
    _adresse = value;
  }

  @override
  String toString() {
    return 'Client{_client_id: $_client_id, _email: $_email, _user_id: $_user_id, _username: $_username, _lastname: $_lastname, _phone: $_phone, _date_naissance: $_date_naissance, _ville: $_ville, _pays: $_pays, _adresse: $_adresse}';
  }
}

class ClientLognin {
  String _token;
  String _date;
  int _userId;

  ClientLognin.empty() {
    this._token = null;
    this._date = null;
  }

  ClientLognin(this._token, this._date, this._userId);

  ClientLognin.map(dynamic obj) {
    this._token = obj["id"];
    this._date = obj["created"];
    this._userId = obj["userId"];
  }

  String get token => _token;
  String get date => _date;
  int get userId => _userId;

  //List<String> get roles => _roles;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = _token;
    map["created"] = _date;
    map["userId"] = _userId;
    return map;
  }

  set token(String value) {
    _token = value;
  }

  set userId(int value) {
    _userId = value;
  }

  set date(String value) {
    _date = value;
  }

  @override
  String toString() {
    return 'ClientLognin{_token: $_token, _date: $_date, _userId: $_userId}';
  }
}
