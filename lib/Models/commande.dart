class Commande {
  int commandeid;
  String date_debut;
  String date_fin;
  String date;
  int montant;
  String status;
  String distance_client_prestataire;
  int clientId;
  Commande(
      {this.commandeid,
      this.date_debut,
      this.date_fin,
      this.date,
      this.montant,
      this.clientId});

  factory Commande.fromJson(Map<String, dynamic> obj) {
    return Commande(
      commandeid: obj["commandeid"],
      date_debut: obj["date_debut"],
      date_fin: obj["date_fin"],
      date: obj["date"],
      montant: obj["montant"],
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
      clientId: obj["clientId"],
    );
  }
}
