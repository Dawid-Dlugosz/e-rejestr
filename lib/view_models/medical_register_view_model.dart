import 'package:e_rejestr/enums/collections.dart';
import 'package:e_rejestr/enums/documents.dart';
import 'package:firedart/firedart.dart';
import 'package:intl/intl.dart';

class MedicalRegisterViewModel {
  MedicalRegisterViewModel() {
    _init();
  }

  Future<void> _init() async {
    var firestore = Firestore.instance;
    var document = await firestore.collection(Collection.judgments.name).document(Documents.medical.name).get();
    var timestamp = document.map['timestamp'];
    var timestampDate = DateTime.fromMillisecondsSinceEpoch(timestamp);
    var currentDate = DateTime.now();
    var formatter = DateFormat('M/yy');

    if (timestampDate.day != currentDate.day) {
      await firestore.collection(Collection.judgments.name).document(Documents.medical.name).update({
        'timestamp': currentDate.millisecondsSinceEpoch,
        'number': '1/${formatter.format(DateTime.now())}',
      });
    }
  }

  Future<String> getRegisterNumbre() async {
    var firestore = Firestore.instance;
    var document = await firestore.collection(Collection.judgments.name).document(Documents.medical.name).get();
    return document.map['number'];
  }

  void updateRegisterNumber(String number) async {
    var firestore = Firestore.instance;
    await firestore.collection(Collection.judgments.name).document(Documents.medical.name).update(
      {'number': number},
    );
  }
}
