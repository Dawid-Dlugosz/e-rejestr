import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

pw.Widget instructionsKodeks() {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Text(
        'Pouczenie:',
        style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
      ),
      pw.Text(
        '1.***) Osoba badana lub pracodawca może w terminie 7 dni od dnia otrzymania orzeczenia lekarskiego',
        style: const pw.TextStyle(fontSize: 12),
      ),
      pw.Text(
        'wnieść odwołanie wraz z jego uzasadnieniem za pośrednictwem lekarza, który je wydał, do jednego z podmiotów odwoławczych, którymi są:',
        style: const pw.TextStyle(fontSize: 12),
      ),
      pw.Text(
        '1) wojewódzkie ośrodki medycyny pracy właściwe ze względu na miejsce świadczenia pracy lub siedzibę jednostki organizacyjnej, w której jest zatrudniony pracownik;',
        style: const pw.TextStyle(fontSize: 12),
      ),
      pw.Text(
        '2) instytuty badawcze w dziedzinie medycyny pracy lub Uniwersyteckie Centrum Medycyny Morskiej i Tropikalnej w Gdyni, w przypadku orzeczenia lekarskiego wydanego przez lekarza zatrudnionego w wojewódzkim ośrodku medycyny pracy;',
        style: const pw.TextStyle(fontSize: 12),
      ),
      pw.Text(
        '3) Centrum Naukowe Medycyny Kolejowej, w przypadku orzeczenia lekarskiego wydanego przez',
        style: const pw.TextStyle(fontSize: 12),
      ),
      pw.Text(
        'Kolejowy Zakład Medycyny Pracy;',
        style: const pw.TextStyle(fontSize: 12),
      ),
      pw.Text(
        '4) podmioty lecznicze utworzone i wyznaczone przez Ministra Obrony Narodowej.',
        style: const pw.TextStyle(fontSize: 12),
      ),
      pw.Text(
        '2. Orzeczenie lekarskie wydane w trybie odwołania jest ostateczne.',
        style: const pw.TextStyle(fontSize: 12),
      ),
      pw.Text(
        '3. Orzeczenie lekarskie jest wydawane w dwóch egzemplarzach, z których jeden otrzymuje osoba badana, a drugi pracodawca.',
        style: const pw.TextStyle(fontSize: 12),
      ),
    ],
  );
}
