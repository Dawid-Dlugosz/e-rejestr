import 'package:e_rejestr/pdf/medical/utils/sub_list.dart';
import 'package:e_rejestr/utils/judgments.dart';
import 'package:pdf/widgets.dart' as pw;

pw.Widget instructions(String judgmentName) {
  return pw.Align(
    alignment: pw.Alignment.centerLeft,
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Pouczenie',
          style: pw.TextStyle(
            fontWeight: pw.FontWeight.bold,
            fontSize: 12,
          ),
          textAlign: pw.TextAlign.left,
        ),
        pw.Column(
          children: [
            pw.Row(
              children: [
                pw.Text(
                  '1.',
                  style: const pw.TextStyle(fontSize: 10),
                ),
                pw.SizedBox(
                  width: 10,
                ),
                pw.RichText(
                  text: const pw.TextSpan(
                    text: 'Osoba badana lub podmiot kierujący na badanie lekarskie, którzy nie zgadzają się z treścią orzeczenia lekarskiego, \n mogą – w terminie 14 dni od dnia otrzymania orzeczenia lekarskiego – za pośrednictwem uprawnionego lekarza, który je wydał, wystąpić z \n wnioskiem o przeprowadzenie ponownego badania lekarskiego odpowiednio',
                    style: pw.TextStyle(fontSize: 10),
                    children: [
                      pw.TextSpan(
                        text: ' 5):',
                        baseline: 6,
                        style: pw.TextStyle(
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            subList(
              number: '1)',
              text: 'w przypadku orzeczenia wydanego przez uprawnionego lekarza - do wojewódzkiego ośrodka medycyny pracy,\n a w przypadku kandydatów, uczniów lub słuchaczy, o których mowa w art. 75 ust. 1 pkt 7 i 8 ustawy – do wojewódzkiego ośrodka medycyny pracy, właściwego ze względu na siedzibę szkoły;',
            ),
            subList(
              number: '2)',
              text: 'w przypadku orzeczenia wydanego przez uprawnionego lekarza zatrudnionego w wojewódzkim \n ośrodku medycyny pracy do:',
            ),
            subList(
              number: '2.a)',
              text: 'Centrum Naukowego Medycyny Kolejowej w Warszawie,',
              sub: true,
            ),
            subList(
              number: '2.b)',
              text: 'Instytutu Medycyny Pracy im. prof. dr med. Jerzego Nofera w Łodzi,',
              sub: true,
            ),
            subList(
              number: '2.c)',
              text: 'Instytutu Medycyny Wsi im. Witolda Chodźki w Lublinie,',
              sub: true,
            ),
            subList(
              number: '2.d)',
              text: 'Uniwersyteckiego Centrum Medycyny Morskiej i Tropikalnej w Gdyni albo',
              sub: true,
            ),
            subList(
              number: '2.e)',
              text: 'Wojskowego Instytutu Medycyny Lotniczej w Warszawie.',
              sub: true,
            ),
            pw.Row(
              children: [
                pw.Text(
                  '2.',
                  style: const pw.TextStyle(fontSize: 10),
                ),
                pw.SizedBox(
                  width: 10,
                ),
                pw.Text(
                  judgmentName != medicalUprzywilejowany ? 'Orzeczenie lekarskie wydane po przeprowadzeniu ponownego badania lekarskiego jest ostateczne.' : '2. Na ponowne badanie lekarskie należy się zgłosić w terminie 30 dni od dnia wpływu wniosku \n o przeprowadzenie ponownego badania lekarskiego.',
                  style: const pw.TextStyle(fontSize: 10),
                ),
              ],
            ),
            judgmentName == medicalUprzywilejowany
                ? pw.Row(
                    children: [
                      pw.Text(
                        '3.',
                        style: const pw.TextStyle(fontSize: 10),
                      ),
                      pw.SizedBox(
                        width: 10,
                      ),
                      pw.Text(
                        'Orzeczenie lekarskie wydane po przeprowadzeniu ponownego badania lekarskiego jest ostateczne.',
                        style: const pw.TextStyle(fontSize: 10),
                      ),
                    ],
                  )
                : pw.Container(),
          ],
        ),
      ],
    ),
  );
}
