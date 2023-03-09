class Firm {
  Firm({required this.name, required this.nip, required this.address, required this.id});

  final String name;
  final String nip;
  final String address;
  final String id;

  factory Firm.fromJson(Map<String, dynamic> json) {
    return Firm(name: json['name'], nip: json['nip'], address: json['address'], id: json['id']);
  }

  Map<String, dynamic> toJson() {
    var json = <String, dynamic>{};

    json['name'] = name;
    json['nip'] = nip;
    json['address'] = address;
    json['id'] = id;
    return json;
  }
}
