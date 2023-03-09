import 'package:e_rejestr/enums/collections.dart';
import 'package:e_rejestr/models/firm.dart';
import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class FirmViewModel extends ChangeNotifier {
  FirmViewModel() {
    _init();
  }

  bool loaded = false;
  List<Firm> firms = [];

  Future<void> _init() async {
    await createFirmList();

    loaded = true;
    notifyListeners();
  }

  Future<void> createFirmList() async {
    firms.clear();

    var collection = await Firestore.instance.collection(Collection.firms.name).get();
    for (var element in collection) {
      firms.add(Firm.fromJson(element.map));
    }
    notifyListeners();
  }

  Future<void> createFirm(Firm firm) async {
    await Firestore.instance.collection(Collection.firms.name).document(firm.id).set(firm.toJson());
  }

  Future<void> updateFirm(Firm firm) async {
    await Firestore.instance.collection(Collection.firms.name).document(firm.id).set(firm.toJson());
  }
}
