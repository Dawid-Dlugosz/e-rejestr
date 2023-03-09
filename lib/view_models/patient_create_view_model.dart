import 'package:e_rejestr/enums/collections.dart';
import 'package:e_rejestr/models/judgment.dart';
import 'package:e_rejestr/models/patient.dart';
import 'package:e_rejestr/models/residental_address.dart';
import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:uuid/uuid.dart';

class PatientCreateViewModel extends ChangeNotifier {
  PatientCreateViewModel(this.context, {this.uid}) {
    _init();
  }

  final BuildContext context;
  final String? uid;

  bool loaded = false;
  Patient? editPatient;

  var nameController = TextEditingController();
  var lastNameController = TextEditingController();
  var birthayController = TextEditingController();
  var domicileController = TextEditingController();
  var streetController = TextEditingController();
  var peselController = TextEditingController();
  var documentNumberController = TextEditingController();

  var birthdayMask = MaskTextInputFormatter(
    mask: '##-##-####',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  var postalMask = MaskTextInputFormatter(
    mask: '##-### **********************************************',
    filter: {"#": RegExp(r'[0-9]'), "*": RegExp(r'.')},
    type: MaskAutoCompletionType.lazy,
  );

  Future<void> _init() async {
    if (uid != null) {
      await getPatient(uid!);
    }
    loaded = true;
    notifyListeners();
  }

  bool peselValidator() {
    if (peselController.text.length < 11) {
      return false;
    }

    var weight = [1, 3, 7, 9, 1, 3, 7, 9, 1, 3];
    var sum = 0;

    var controlNumber = int.parse(peselController.text.substring(10, 11));

    for (var i = 0; i < weight.length; i++) {
      sum += (int.parse(peselController.text.substring(i, i + 1)) * weight[i]);
    }
    sum = sum % 10;
    return (10 - sum) % 10 == controlNumber;
  }

  bool checkBasicData() {
    if (nameController.text.isEmpty || lastNameController.text.isEmpty || domicileController.text.isEmpty || streetController.text.isEmpty || birthayController.text.isEmpty) {
      return false;
    }
    return true;
  }

  bool checkExtraDate() {
    if (peselController.text.isEmpty && documentNumberController.text.isEmpty) {
      return false;
    }
    return true;
  }

  void _clearData() {
    nameController.clear();
    documentNumberController.clear();
    domicileController.clear();
    streetController.clear();
    lastNameController.clear();
    birthayController.clear();
    peselController.clear();
    notifyListeners();
  }

  Future<void> getPatient(String uid) async {
    // I have only one user with bcz uid is unique
    var documents = await Firestore.instance.collection(Collection.patients.name).where('uid', isEqualTo: uid).get();
    var patientDocument = documents.first;
    editPatient = Patient.fromJson(patientDocument.map);
    nameController.text = editPatient!.firstName;
    lastNameController.text = editPatient!.lastName;
    birthayController.text = editPatient!.birthday;
    domicileController.text = editPatient!.residentialAddress.postCodeCity;
    streetController.text = editPatient!.residentialAddress.street;
    if (editPatient!.pesel != null && editPatient!.pesel!.isNotEmpty) {
      peselController.text = editPatient!.pesel!;
    } else {
      documentNumberController.text = editPatient!.documentNumer!;
    }

    notifyListeners();
  }

  Future<void> inserData({bool clear = false}) async {
    var patient = Patient(
      firstName: nameController.text,
      lastName: lastNameController.text,
      residentialAddress: ResidentialAddress(postCodeCity: domicileController.text, street: streetController.text),
      birthday: birthayController.text,
      pesel: peselController.text,
      documentNumer: documentNumberController.text,
      uid: const Uuid().v4(),
    );
    await Firestore.instance.collection(Collection.patients.name).document(patient.uid).set(patient.toJson());
    if (clear) {
      _clearData();
    }
  }

  Future<void> editData() async {
    var patient = Patient(
      firstName: nameController.text,
      lastName: lastNameController.text,
      residentialAddress: ResidentialAddress(postCodeCity: domicileController.text, street: streetController.text),
      birthday: birthayController.text,
      pesel: peselController.text,
      documentNumer: documentNumberController.text,
      uid: editPatient!.uid,
    );

    await Firestore.instance.collection(Collection.patients.name).document(patient.uid).update(patient.toJson());
  }
}
