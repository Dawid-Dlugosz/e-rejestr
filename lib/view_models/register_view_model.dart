import 'package:e_rejestr/enums/collections.dart';
import 'package:e_rejestr/enums/documents.dart';
import 'package:firedart/firedart.dart';
import 'package:intl/intl.dart';

class RegisterViewModel {
  RegisterViewModel() {
    _init();
  }

  Future<void> _init() async {
    var firestore = Firestore.instance;
    var document = await firestore.collection(Collection.judgments.name).document(DocumentType.medical.name).get();
    var timestamp = document.map['timestamp'];
    var timestampDate = DateTime.fromMillisecondsSinceEpoch(timestamp);
    var currentDate = DateTime.now();
    var formatter = DateFormat('M/yy');

    if (timestampDate.month != currentDate.month) {
      await firestore.collection(Collection.judgments.name).document(DocumentType.medical.name).update({
        'timestamp': currentDate.millisecondsSinceEpoch,
        'number': '1/${formatter.format(DateTime.now())}',
      });
    }
  }

  Future<String> getPsychoRegisterNumber() async {
    var firestore = Firestore.instance;
    var document = await firestore.collection(Collection.judgments.name).document(DocumentType.psycho.name).get();
    return document.map['number'];
  }

  void updatePsychoRegisterNumber(String number) async {
    var firestore = Firestore.instance;
    await firestore.collection(Collection.judgments.name).document(DocumentType.psycho.name).update(
      {'number': number},
    );
  }

  Future<String> getRegisterMedicalNumber() async {
    var firestore = Firestore.instance;
    var document = await firestore.collection(Collection.judgments.name).document(DocumentType.medical.name).get();
    return document.map['number'];
  }

  void updateMedicalRegisterNumber(String number) async {
    var firestore = Firestore.instance;
    await firestore.collection(Collection.judgments.name).document(DocumentType.medical.name).update(
      {'number': number},
    );
  }
}
