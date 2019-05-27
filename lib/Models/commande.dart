class Commande {
  int commandeid;
  String date_debut;
  String date_fin;
  String date;
  int montant;
  String status;
  String distance_client_prestataire;
  String duree_client_prestataire;

  String date_acceptation;
  String date_prise_en_charge;
  int position_prise_en_charge;
  int position_destination;
  String rate_comment;
  String rate_date;
  int prestationId;

  int clientId;
  Commande(
      {this.commandeid,
      this.date_debut,
      this.date_fin,
      this.date,
      this.montant,
      this.status,
      this.distance_client_prestataire,
      this.duree_client_prestataire,
      this.date_acceptation,
      this.date_prise_en_charge,
      this.position_prise_en_charge,
      this.position_destination,
      this.rate_comment,
      this.rate_date,
      this.prestationId,
      this.clientId});

  factory Commande.fromJson(Map<String, dynamic> obj) {
    return Commande(
      commandeid: obj["commandeid"],
      date_debut: obj["date_debut"],
      date_fin: obj["date_fin"],
      date: obj["date"],
      montant: obj["montant"],
      status: obj["status"],
      distance_client_prestataire: obj["distance_client_prestataire"],
      duree_client_prestataire: obj["duree_client_prestataire"],
      date_acceptation: obj["date_acceptation"],
      date_prise_en_charge: obj["date_prise_en_charge"],
      position_prise_en_charge: obj["position_prise_en_charge"],
      position_destination: obj["position_destination"],
      rate_comment: obj["rate_comment"],
      rate_date: obj["rate_date"],
      prestationId: obj["prestationId"],
      clientId: obj["clientId"],
    );
  }
  factory Commande.fromJson2(Map<String, dynamic> obj) {
    return Commande(
      commandeid: obj["commandeid"],
      date_debut: obj["date_debut"],
      date_fin: obj["date_fin"],
      date: obj["date"],
      montant: obj["montant"],
      status: obj["status"],
      distance_client_prestataire: obj["distance_client_prestataire"],
      duree_client_prestataire: obj["duree_client_prestataire"],
      date_acceptation: obj["date_acceptation"],
      date_prise_en_charge: obj["date_prise_en_charge"],
      position_prise_en_charge: obj["position_prise_en_charge"],
      position_destination: obj["position_destination"],
      rate_comment: obj["rate_comment"],
      rate_date: obj["rate_date"],
      prestationId: obj["prestationId"],
      clientId: obj["clientId"],
    );
  }
}

class PositionModel {
  int positionid;
  double latitude;
  double longitude;
  String libelle;

  PositionModel({this.positionid, this.latitude, this.longitude, this.libelle});

  factory PositionModel.fromJson(Map<String, dynamic> obj) {
    return PositionModel(
      positionid: obj["positionid"],
      latitude: obj["latitude"],
      longitude: obj["longitude"],
      libelle: obj["libelle"],
    );
  }
}
