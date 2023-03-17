import 'dart:io';

import 'package:diacritic/diacritic.dart';
import 'package:e_rejestr/enums/documents.dart';

File getFileWithPath({required String path, required String name, required String number}) {
  return File('$path\\${removeDiacritics(name.replaceAll(' ', '-'))}-${number.replaceAll('/', '-')}.pdf');
}

File getKzFileWithPath({required String path, required String number, required DocumentType type}) {
  if (type == DocumentType.medical) {
    return File('$path\\karta-kz-medyczna-${number.replaceAll('/', '-')}.pdf');
  }
  return File('$path\\karta-kz-psychologiczna-${number.replaceAll('/', '-')}.pdf');
}
