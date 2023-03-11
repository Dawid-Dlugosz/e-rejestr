import 'package:e_rejestr/pdf/karta_kz/p2_header.dart';
import 'package:pdf/widgets.dart' as pw;

pw.Widget p2_right_side() {
  return pw.Container(
    padding: const pw.EdgeInsets.only(left: 20),
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        p2Header(3, 'OCENA I OPIS OSOBY BADANEJ POD WZGLĘDEM OSOBOWOŚCI, Z UWZGLENDNIENIEM \n FUNKCJONOWANIA W TRUDNYCH SYTUACJACH, A TAKŻE DOJRZAŁOŚCI SPOŁECZNEJ'),
        pw.Container(
          width: 400,
          padding: const pw.EdgeInsets.all(2),
          child: pw.Text('Nazwa i wynik testu', style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold)),
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
                  width: 120,
                  padding: const pw.EdgeInsets.all(5),
                  child: pw.Text(
                    'Nazwa testu',
                    style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold),
                    textAlign: pw.TextAlign.center,
                  ),
                ),
                pw.Container(
                  width: 51,
                  padding: const pw.EdgeInsets.all(5),
                  child: pw.Text(
                    'Wyniki\nsurowe',
                    style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold),
                    textAlign: pw.TextAlign.center,
                  ),
                ),
                pw.Container(
                  width: 51,
                  padding: const pw.EdgeInsets.all(5),
                  child: pw.Text(
                    'Wynikin\nprzeliczone',
                    style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold),
                    textAlign: pw.TextAlign.center,
                  ),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(5),
                  child: pw.Container(
                    width: 158,
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
                  padding: const pw.EdgeInsets.only(top: 20),
                  child: pw.Text(
                    '1',
                    style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold),
                    textAlign: pw.TextAlign.center,
                  ),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(3),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                    children: [
                      pw.Text(
                        'EPQ-R(S)',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10),
                      ),
                      pw.Column(
                        children: [
                          pw.Text('N', style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.normal)),
                          pw.Text('E', style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.normal)),
                          pw.Text('P', style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.normal)),
                          pw.Text('K', style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.normal)),
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
                  padding: const pw.EdgeInsets.only(top: 20),
                  child: pw.Text(
                    '3',
                    style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold),
                    textAlign: pw.TextAlign.center,
                  ),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(3),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                    children: [
                      pw.Text(
                        'CISS',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10),
                      ),
                      pw.SizedBox(width: 20),
                      pw.Column(
                        children: [
                          pw.Text('SSZ', style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.normal)),
                          pw.Text('SSE', style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.normal)),
                          pw.Text('SSU', style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.normal)),
                          pw.Text('AK', style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.normal)),
                          pw.Text('PKT', style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.normal)),
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
            pw.TableRow(
              children: [
                pw.SizedBox(width: 10),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(3),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                    children: [
                      pw.Text(
                        'Stai',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10),
                      ),
                    ],
                  ),
                ),
                pw.Container(
                  child: pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text('X1', style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold)),
                      pw.SizedBox(height: 10),
                      pw.Text('X2', style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold)),
                    ],
                  ),
                ),
                pw.Container(),
                pw.Container(),
              ],
            ),
          ],
        ),
        p2Header(4, 'SPRAWNOSC PSYCHOMOTORYCZNA'),
        pw.Container(
          width: 400,
          padding: const pw.EdgeInsets.all(2),
          child: pw.Text('Nazwa i wynik testu', style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold)),
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
                  width: 120,
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
                    width: 260,
                    child: pw.Text(
                      'Wyniki',
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
                  padding: const pw.EdgeInsets.only(top: 30),
                  child: pw.Text(
                    '1',
                    style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold),
                    textAlign: pw.TextAlign.center,
                  ),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.only(left: 3),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                    children: [
                      pw.RichText(
                        text: pw.TextSpan(
                          text: 'Aparat\nKrzyżowy - \n',
                          style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold),
                          children: [
                            pw.TextSpan(
                              text: 'Koordynacja\nwzrokowo\nruchowa',
                              style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                      pw.Column(
                        children: [
                          pw.Container(
                            height: 40,
                            width: 53,
                            decoration: const pw.BoxDecoration(
                              border: pw.Border(
                                left: pw.BorderSide(
                                  width: 1,
                                ),
                                top: pw.BorderSide(
                                  width: 1,
                                ),
                                bottom: pw.BorderSide(
                                  width: 1,
                                ),
                              ),
                            ),
                          ),
                          pw.Container(
                            height: 40,
                            width: 53,
                            decoration: const pw.BoxDecoration(
                              border: pw.Border(
                                left: pw.BorderSide(
                                  width: 1,
                                ),
                                top: pw.BorderSide(
                                  width: 1,
                                ),
                                bottom: pw.BorderSide(
                                  width: 1,
                                ),
                              ),
                            ),
                            child: pw.Align(
                              alignment: pw.Alignment.center,
                              child: pw.Text(
                                'Tempo\nnarzucone...',
                                style: const pw.TextStyle(fontSize: 8),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                pw.Column(
                  children: [
                    pw.Row(
                      children: [
                        pw.Container(
                          width: 180,
                          height: 40,
                          decoration: const pw.BoxDecoration(
                            border: pw.Border(
                              right: pw.BorderSide(
                                width: 1,
                              ),
                              bottom: pw.BorderSide(
                                width: 1,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    pw.Row(
                      children: [
                        pw.Container(
                          width: 180,
                          height: 40,
                          decoration: const pw.BoxDecoration(
                            border: pw.Border(
                              right: pw.BorderSide(
                                width: 1,
                              ),
                              bottom: pw.BorderSide(
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                        pw.Container(
                          height: 40,
                          width: 90,
                          decoration: const pw.BoxDecoration(
                            border: pw.Border(
                              top: pw.BorderSide(width: 1),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
            pw.TableRow(
              children: [
                pw.Padding(
                  padding: const pw.EdgeInsets.only(top: 30),
                  child: pw.Text(
                    '2',
                    style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold),
                    textAlign: pw.TextAlign.center,
                  ),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.only(left: 3),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                    children: [
                      pw.Text(
                        'Miernik\nczasu\nreakcji',
                        style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold),
                      ),
                      pw.SizedBox(width: 19),
                      pw.Column(
                        children: [
                          pw.Container(
                            height: 40,
                            width: 53,
                            decoration: const pw.BoxDecoration(
                              border: pw.Border(
                                left: pw.BorderSide(
                                  width: 1,
                                ),
                                top: pw.BorderSide(
                                  width: 1,
                                ),
                                bottom: pw.BorderSide(
                                  width: 1,
                                ),
                              ),
                            ),
                            child: pw.Align(
                              alignment: pw.Alignment.center,
                              child: pw.Text(
                                'Czas reakcji\nprosty',
                                style: const pw.TextStyle(fontSize: 8),
                              ),
                            ),
                          ),
                          pw.Container(
                            height: 40,
                            width: 53,
                            decoration: const pw.BoxDecoration(
                              border: pw.Border(
                                left: pw.BorderSide(
                                  width: 1,
                                ),
                                top: pw.BorderSide(
                                  width: 1,
                                ),
                                bottom: pw.BorderSide(
                                  width: 1,
                                ),
                              ),
                            ),
                            child: pw.Align(
                              alignment: pw.Alignment.center,
                              child: pw.Text(
                                'Czas reakcji\nzłożony',
                                style: const pw.TextStyle(fontSize: 8),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                pw.Column(
                  children: [
                    pw.Row(
                      children: [
                        pw.Container(
                          width: 180,
                          height: 40,
                          decoration: const pw.BoxDecoration(
                            border: pw.Border(
                              right: pw.BorderSide(
                                width: 1,
                              ),
                              bottom: pw.BorderSide(
                                width: 1,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    pw.Row(
                      children: [
                        pw.Container(
                          width: 180,
                          height: 40,
                          decoration: const pw.BoxDecoration(
                            border: pw.Border(
                              right: pw.BorderSide(
                                width: 1,
                              ),
                              bottom: pw.BorderSide(
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                        pw.Container(
                          height: 40,
                          width: 90,
                          decoration: const pw.BoxDecoration(
                            border: pw.Border(
                              top: pw.BorderSide(width: 1),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
            pw.TableRow(
              children: [
                pw.Padding(
                  padding: const pw.EdgeInsets.only(top: 30),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.only(left: 3),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                    children: [
                      pw.SizedBox(width: 55),
                      pw.Column(
                        children: [
                          pw.Container(
                            height: 30,
                            width: 53,
                            decoration: const pw.BoxDecoration(
                              border: pw.Border(
                                left: pw.BorderSide(
                                  width: 1,
                                ),
                                top: pw.BorderSide(
                                  width: 1,
                                ),
                                bottom: pw.BorderSide(
                                  width: 1,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                pw.Row(
                  children: [
                    pw.Container(
                      width: 180,
                      height: 30,
                      decoration: const pw.BoxDecoration(
                        border: pw.Border(
                          right: pw.BorderSide(
                            width: 1,
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ],
    ),
  );
}
