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
