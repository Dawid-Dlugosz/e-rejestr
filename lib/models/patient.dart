import 'package:e_rejestr/models/residental_address.dart';

class Patient {
  Patient({required this.firstName, required this.lastName, required this.residentialAddress, required this.birthday, this.pesel, this.documentNumer});

  final String firstName;
  final String lastName;
  final ResidentialAddress residentialAddress;
  final String birthday;
  String? pesel;
  String? documentNumer;

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      firstName: json['firstName'],
      lastName: json['lastName'],
      birthday: json['birthday'],
      residentialAddress: ResidentialAddress.fromJson(json['residentialAddress']),
      pesel: json['pesel'],
      documentNumer: json['documentNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    var json = <String, dynamic>{};

    json['firstName'] = firstName;
    json['lastName'] = lastName;
    json['residentialAddress'] = residentialAddress.toJson();
    json['pesel'] = pesel;
    json['birthday'] = birthday;
    json['documentNumber'] = documentNumer;

    return json;
  }

  String getDocument() {
    if (pesel != null && pesel!.isNotEmpty) {
      return pesel!;
    }
    return documentNumer!;
  }

  String getFullName() {
    return '$firstName $lastName';
  }
}
