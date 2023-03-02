class Firm {
  Firm({required this.name, required this.nip, required this.address});

  final String name;
  final String nip;
  final String address;

  factory Firm.fromJson(Map<String, dynamic> json) {
    return Firm(name: json['name'], nip: json['nip'], address: json['address']);
  }

  Map<String, dynamic> toJson() {
    var json = <String, dynamic>{};

    json['name'] = name;
    json['nip'] = nip;
    json['address'] = address;

    return json;
  }
}
