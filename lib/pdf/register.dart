import 'package:e_rejestr/models/register.dart';

import 'package:pdf/widgets.dart';

Widget register({required List<Register> registers}) {
  return Column(
    children: [
      register_header(),
      ...registers.map((e) {
        return register_row(register: e);
      }).toList(),
    ],
  );
}

Widget register_row({Register? register}) {
  return Row(
    children: [
      register_cell(width: 40, text: register != null ? register.lp : ''),
      register_cell(width: 185, text: register != null ? register.getNameAndAddress() : ''),
      register_cell(width: 165, text: register != null ? register.documentNumber : ''),
      register_cell(width: 205, text: register != null ? register.getFormatedArticels() : ''),
      register_cell(width: 55, text: ''),
      register_cell(width: 65, text: register != null ? register.releaseDate : ''),
      register_cell(width: 95, text: ''),
    ],
  );
}

Widget register_header() {
  return Row(
    children: [
      register_cell(width: 40, text: 'Lp.'),
      register_cell(width: 185, text: 'Imię i nazwisko, adres zamieszkania osoby badanej'),
      register_cell(width: 165, text: 'Nr PESEL, a w przypadku osoby, której nie nadano nr PESEL - nazwa i numer dokumentu tożsamości'),
      register_cell(width: 205, text: 'Określenie rodzaju wyanego orzeczenia wraz z podaniem kategorii prawa jazdy'),
      register_cell(width: 55, text: 'Uwagi'),
      register_cell(width: 65, text: 'Data Wydania'),
      register_cell(width: 95, text: 'Potwierdzenie odbioru'),
    ],
  );
}

Widget register_cell({String text = '', required double width}) {
  return Container(
    decoration: BoxDecoration(border: Border.all()),
    padding: const EdgeInsets.all(10),
    width: width,
    height: 60,
    child: Center(child: Text(text, textAlign: TextAlign.center, style: const TextStyle(fontSize: 10))),
  );
}
