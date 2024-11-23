class Address {
  String? address1;
  String? address2;
  String? city;
  String? state;
  String? zipCode;

  Address({this.address1, this.address2, this.city, this.state, this.zipCode});

  Address.fromJson(Map<String, dynamic> json) {
    address1 = json["street_address"] as String;
    address2 = json["street_address_line_2"] as String;
    city = json["city"] as String;
    state = json["state"] as String;
    zipCode = json["zip_code"].toString();
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      "street_address": address1,
      "street_address_line_2": address2,
      "city": city,
      "state": state,
      "zip_code": zipCode,
    };
    return map;
  }

  void copyWith(Address? address) {
    address1 = address?.address1;
    address2 = address?.address2;
    city = address?.city;
    state = address?.state;
    zipCode = address?.zipCode;
  }
}
