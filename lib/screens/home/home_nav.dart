import 'dart:io';

import 'package:e_rejestr/pdf/karta_kz/karta_kz_page_1.dart';
import 'package:e_rejestr/pdf/karta_kz/karta_kz_page_2.dart';
import 'package:e_rejestr/pdf/medical/kierowcow_starajacych_sie.dart';
import 'package:e_rejestr/pdf/psychologist/psychologist_39.dart';
import 'package:e_rejestr/pdf/psychologist/psychologist_alkohol.dart';
import 'package:e_rejestr/pdf/psychologist/psychologist_ogolny.dart';
import 'package:e_rejestr/pdf/psychologist/psychologist_przedluzenie.dart';
import 'package:e_rejestr/pdf/psychologist/psychologist_przywrocenie.dart';
import 'package:e_rejestr/pdf/psychologist/psychologist_punkty_karne.dart';
import 'package:e_rejestr/pdf/psychologist/psychologist_uprzywilej.dart';
import 'package:e_rejestr/pdf/psychologist/psychologist_wypadek.dart';
import 'package:e_rejestr/utils/colors.dart';
import 'package:e_rejestr/utils/pages.dart';
import 'package:e_rejestr/view_models/home_view_model.dart';
import 'package:e_rejestr/widgets/home_nav_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';

class HomeNav extends StatelessWidget {
  const HomeNav({super.key});

  @override
  Widget build(BuildContext context) {
    var homeViewModel = Provider.of<HomeViewModel>(context, listen: false);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: const BoxDecoration(
        border: Border(
          right: BorderSide(
            color: white,
            width: 3.0,
          ),
        ),
      ),
      child: Column(
        children: [
          HomeNavButton(
            text: 'Rejestr lekarski'.toUpperCase(),
            onTap: () => homeViewModel.changeScreenRecord(medicalRegister),
          ),
          HomeNavButton(
            text: 'Rejestr psychologiczny'.toUpperCase(),
            onTap: () => homeViewModel.changeScreenRecord(psychologicalRegister),
          ),
          HomeNavButton(
            text: 'Generuj pdf'.toUpperCase(),
            onTap: () async {
              var font = await rootBundle.load("fonts/Lato-Regular.ttf");
              var myTheme = pw.ThemeData.withFont(
                base: pw.Font.ttf(await rootBundle.load("fonts/Lato-Regular.ttf")),
                bold: pw.Font.ttf(await rootBundle.load("fonts/Lato-Bold.ttf")),
                // italic: pw.Font.ttf(await rootBundle.load("assets/OpenSans-Italic.ttf")),
                // boldItalic: pw.Font.ttf(await rootBundle.load("assets/OpenSans-BoldItalic.ttf")),
              );
              final pdf = pw.Document(theme: myTheme);
              pw.Font.ttf(font);
              pdf.addPage(
                pw.Page(
                  pageFormat: PdfPageFormat.a4,
                  margin: const pw.EdgeInsets.all(10),
                  orientation: pw.PageOrientation.landscape,
                  build: (pw.Context context) {
                    // return kierowca_starajacy_sie(date: "23-23-2323");
                    return karta_kz_page_1();
                    // return psychologist_wypadek(date: "23-23-2323");
                    // return psychologist_przywrocenie(date: "23-23-232");
                    // return psychologist_punkty_karne(date: "23-23-232");
                    // return psychologist_alkohol(date: "23-23-232");
                    // return psychologist_uprzywilej(date: "23-23-232");
                    // return psychologist_ogolny(date: "23-23-2323");
                    // return psychologist_39(data: "23-23-2323"); //example 2
                  },
                ),
              );
              pdf.addPage(
                pw.Page(
                  pageFormat: PdfPageFormat.a4,
                  margin: const pw.EdgeInsets.all(10),
                  orientation: pw.PageOrientation.landscape,
                  build: (pw.Context context) {
                    return karta_kz_page_2();
                  },
                ),
              );

              final file = File("karta_kz.pdf");
              await file.writeAsBytes(await pdf.save());
            },
          ),
        ],
      ),
    );
  }
}
