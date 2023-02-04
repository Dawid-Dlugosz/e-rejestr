class ResidentialAddress {
  ResidentialAddress({required this.postCodeCity, required this.street});

  final String postCodeCity;
  final String street;
  factory ResidentialAddress.fromJson(Map<String, dynamic> json) {
    return ResidentialAddress(
      postCodeCity: json['postCodeCity'],
      street: json['street'],
    );
  }

  @override
  String toString() {
    return "$postCodeCity ul. $street";
  }

  Map<String, dynamic> toJson() {
    var json = <String, dynamic>{};

    json['postCodeCity'] = postCodeCity;
    json['street'] = street;

    return json;
  }
}
