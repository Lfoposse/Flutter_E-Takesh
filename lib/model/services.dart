
class Service {
  final int serviceid;
  final String code;
  final String intitule;
  final int prix;

  Service({this.serviceid, this.code, this.intitule, this.prix});

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
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

  Login({this.id, this.created, this.userId,this.ttl});

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
      id: json['id'],
        ttl: json['ttl'],
      created: json['created'],
      userId: json['userId']
    );
  }

}