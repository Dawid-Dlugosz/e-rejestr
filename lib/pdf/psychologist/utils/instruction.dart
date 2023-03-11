import 'package:pdf/widgets.dart' as pw;

pw.Widget instruction() {
  return pw.Container(
    margin: const pw.EdgeInsets.only(bottom: 20),
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'POUCZENIE:',
          style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold),
        ),
        pw.Text(
          '1. Osoba badana lub podmiot kierujący na badanie psychologiczne, którzy nie zgadzają się z treścią orzeczenia psychologicznego mogą – w terminie 14 dni od dnia otrzymania orzeczenia psychologicznego – za pośrednictwem uprawnionego psychologa, który je wydał, wystąpić z wnioskiem o przeprowadzenie ponownego badania psychologicznego do wojewódzkiego ośrodka medycyny pracy, właściwego ze względu na miejsce zamieszkania osoby badanej **) ',
          style: const pw.TextStyle(fontSize: 8),
        ),
        pw.Text(
          '2. Orzeczenie psychologiczne wydane po przeprowadzeniu ponownego badania psychologicznego jest ostateczne. **)',
          style: const pw.TextStyle(fontSize: 8),
        )
      ],
    ),
  );
}
