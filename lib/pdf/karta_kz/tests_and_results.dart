import 'package:pdf/widgets.dart' as pw;

pw.Widget testsAndResults() {
  return pw.Column(
    children: [
      pw.Container(
        width: 400,
        padding: const pw.EdgeInsets.all(2),
        child: pw.Text('Nazwa testu i wyniki', style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold)),
        decoration: pw.BoxDecoration(
          border: pw.Border.all(width: 1),
        ),
      ),
      pw.Table(
        border: pw.TableBorder.all(style: pw.BorderStyle.solid, width: 1),
        children: [
          pw.TableRow(
            children: [
              pw.SizedBox(width: 10),
              pw.Container(
                width: 130,
                padding: const pw.EdgeInsets.all(5),
                child: pw.Text(
                  'Nazwa testu',
                  style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold),
                  textAlign: pw.TextAlign.center,
                ),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.all(5),
                child: pw.Container(
                  width: 51,
                  child: pw.Text(
                    'Wyniki\nsurowe',
                    style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold),
                    textAlign: pw.TextAlign.center,
                  ),
                ),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.all(5),
                child: pw.Container(
                  width: 51,
                  child: pw.Text(
                    'Wyniki\nprzeliczone',
                    style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold),
                    textAlign: pw.TextAlign.center,
                  ),
                ),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.all(5),
                child: pw.Container(
                  width: 110,
                  child: pw.Text(
                    'Uwagi',
                    style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold),
                    textAlign: pw.TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
          pw.TableRow(
            children: [
              pw.Padding(
                padding: const pw.EdgeInsets.only(top: 25),
                child: pw.Text(
                  '1',
                  style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold),
                  textAlign: pw.TextAlign.center,
                ),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.all(3),
                child: pw.Row(
                  children: [
                    pw.RichText(
                      text: pw.TextSpan(
                        text: 'Test Matrycy Revena - \n',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10),
                        children: [
                          pw.TextSpan(
                            text: 'Wersja Standard Forma Kalsyczna \n (sprawność intelektualna)',
                            style: pw.TextStyle(fontWeight: pw.FontWeight.normal, fontSize: 9),
                          ),
                        ],
                      ),
                      textAlign: pw.TextAlign.center,
                    ),
                    pw.Column(
                      children: [
                        pw.Text('A', style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.normal)),
                        pw.Text('B', style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.normal)),
                        pw.Text('C', style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.normal)),
                        pw.Text('D', style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.normal)),
                        pw.Text('E', style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.normal)),
                      ],
                    )
                  ],
                ),
              ),
              pw.Container(),
              pw.Container(),
              pw.Container(),
            ],
          ),
          pw.TableRow(
            children: [
              pw.Padding(
                padding: const pw.EdgeInsets.only(top: 10),
                child: pw.Text(
                  '2',
                  style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold),
                  textAlign: pw.TextAlign.center,
                ),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.all(3),
                child: pw.Row(
                  children: [
                    pw.RichText(
                      text: pw.TextSpan(
                        text: 'Test Tablic Poppelreutera \n',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10),
                        children: [
                          pw.TextSpan(
                            text: '(uwaga)',
                            style: pw.TextStyle(fontWeight: pw.FontWeight.normal, fontSize: 9),
                          ),
                        ],
                      ),
                      textAlign: pw.TextAlign.center,
                    ),
                    pw.SizedBox(width: 20),
                    pw.Column(
                      children: [
                        pw.Text('I', style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.normal)),
                        pw.Text('II', style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.normal)),
                      ],
                    ),
                  ],
                ),
              ),
              pw.Container(),
              pw.Container(),
              pw.Container(),
            ],
          ),
        ],
      ),
    ],
  );
}
