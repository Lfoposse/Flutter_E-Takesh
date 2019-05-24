class Prestataires {
  int prestataireid;
  String cni;
  String date_naissance;
  String date_creation;
  String email;
  String nom;
  String prenom;
  String pays;
  String status;
  String telephone;
  String ville;
  String positionId;
  int UserId;

  Prestataires({
    this.prestataireid,
    this.cni,
    this.date_creation,
    this.date_naissance,
    this.email,
    this.nom,
    this.prenom,
    this.pays,
    this.status,
    this.telephone,
    this.ville,
    this.positionId,
    this.UserId,
  });

  factory Prestataires.fromJson(Map<String, dynamic> json) {
    return Prestataires(
      prestataireid: json["prestataireid"],
      cni: json["cni"],
      date_naissance: json["date_naissance"],
      date_creation: json["date_creation"],
      email: json["email"],
      nom: json["nom"],
      prenom: json["prenom"],
      pays: json["pays"],
      status: json["status"],
      telephone: json["telephone"],
      ville: json["ville"],
      positionId: json["positionId"],
      UserId: json["UserId"],
    );
  }
}

class Positions {
  int positionid;
  double latitude;
  double longitude;
  String libelle;

  Positions({this.positionid, this.latitude, this.longitude, this.libelle});

  factory Positions.fromJson(Map<String, dynamic> json) {
    return Positions(
      positionid: json["positionid"],
      latitude: json["latitude"],
      longitude: json["longitude"],
      libelle: json["libelle"],
    );
  }
}

class Vehicule {
  int vehiculeid;
  String couleur;
  String status;
  String marque;
  String immatriculation;
  int nombre_places;
  String date;
  String categorievehiculeId;
  String prestataireId;

  Vehicule(
      {this.vehiculeid,
      this.couleur,
      this.status,
      this.immatriculation,
      this.marque,
      this.nombre_places,
      this.date,
      this.categorievehiculeId,
      this.prestataireId});

  factory Vehicule.fromJson(Map<String, dynamic> json) {
    return Vehicule(
      vehiculeid: json["vehiculeid"],
      couleur: json["couleur"],
      status: json["status"],
      immatriculation: json["immatriculation"],
      marque: json["marque"],
      nombre_places: json["nombre_places"],
      date: json["date"],
      categorievehiculeId: json["categorievehiculeId"],
      prestataireId: json["prestataireId"],
    );
  }
}

class PrestataireService {
  int prestationid;
  int vehiculeId;
  String status;
  String serviceId;
  Prestataires prestataire;
  int montant;
  String date;
  Vehicule vehicule;
  int prestataireId;

  PrestataireService(
      {this.prestationid,
      this.vehiculeId,
      this.status,
      this.prestataire,
      this.serviceId,
      this.montant,
      this.date,
      this.vehicule,
      this.prestataireId});

  factory PrestataireService.fromJson(Map<String, dynamic> json) {
    return PrestataireService(
      prestationid: json["prestationid"],
      vehiculeId: json["vehiculeId"],
      status: json["status"],
      prestataire: Prestataires.fromJson(json["prestataire"]),
      serviceId: json["serviceId"],
      montant: json["montant"],
      date: json["date"],
      vehicule: Vehicule.fromJson(json["vehicule"]),
      prestataireId: json["prestataireId"],
    );
  }
}
