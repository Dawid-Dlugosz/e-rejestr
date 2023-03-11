import 'package:pdf/widgets.dart' as pw;

pw.Widget infoInstruction(String stars, {bool size = false}) {
  return pw.Row(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Container(
        width: 20,
        child: pw.Text('$stars)', style: const pw.TextStyle(fontSize: 8)),
      ),
      pw.Container(
        width: size ? 380 : null,
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('Należy podać następujące dane:', style: const pw.TextStyle(fontSize: 8)),
            pw.Text('- nazwa i adres pracowni psychologicznej,', style: const pw.TextStyle(fontSize: 8)),
            pw.Text('- numer wpisu do rejestru przedsiębiorców prowadzących pracownie psychologiczną, o którym mowa w art. 83 ust. 1\npkt 1 ustawy z dnia 5 stycznia 2011 r. o kierujących pojazdami, albo do ewidencji jednostek, o której mowa w art. 86\nust 4 tej ustawy, oraz oznaczenie podmiotu prowadzącego odpowiednio rejestr lub ewidencje.', style: const pw.TextStyle(fontSize: 8)),
            pw.Text('- numer identyfikacji podatkowej (NIP) przedsiębiorcy – jeżeli taki posiada.', style: const pw.TextStyle(fontSize: 8)),
          ],
        ),
      )
    ],
  );
}
