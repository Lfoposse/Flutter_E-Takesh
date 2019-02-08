
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