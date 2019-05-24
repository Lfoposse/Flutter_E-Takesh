class GooglePlacesItemTerm {
  int offset;
  String value;

  GooglePlacesItemTerm({this.offset, this.value});

  factory GooglePlacesItemTerm.fromJson(Map<String, dynamic> json) {
    return GooglePlacesItemTerm(
      offset: json['offset'],
      value: json['value'],
    );
  }
}

class LocationModel {
  double lat;
  double lng;

  LocationModel({this.lat, this.lng});

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      lat: json["lat"],
      lng: json["lng"],
    );
  }
}
