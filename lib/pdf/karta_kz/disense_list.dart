import 'package:e_rejestr/pdf/karta_kz/disease.dart';
import 'package:pdf/widgets.dart' as pw;

pw.Widget diseaseList() {
  return pw.Column(
    children: [
      disense(
        'Ogólny nastrój badanego:',
        'Zmęczony - wypoczęty, wesoły - pogodny - smutny, zrożnoważony - niezrównoważony, rozdrażniony - gniewliwy',
      ),
      disense(
        'Poziom pobudzenia:',
        'Zahamowany - aktywny i spokojny - aktywny i ożywiony, podniecony i zorganizowany - podniecony i zdezorganizowany - zdenerwowany',
      ),
      disense(
        'Poziom zainteresowania badaniem:',
        'Bardzo zainteresowany - zainteresowany - obojętny - mało zainteresowany - niezainteresowany',
      ),
      disense(
        'Stosunek do badającego:',
        'Życzliwy - niechętny, uległy - dominujący, łatwy w kontakcie - trudny w kontakcie',
      ),
      disense(
        'Samokontrola:',
        'Bardzo pewnym siebie - pewny siebie - niepewny siebie - brak wiary we własne siły, zorganizowany - zdezorganizowany',
      ),
      disense(
        'Uwaga (umiejętność skupienia się przy rozwiązywaniu zadań):',
        'Bardzo uważny, - uważny - dość uważny - niezbyt uważny - rozproszony',
      ),
      disense(
        'Rozumienie:',
        'Chwyta w lot instrukcjie - rozumie je w stopniu przeciętnym - niezbyt dobrze rozumie - trzeba udzielać dodatkowych wyjaśnień - przyjmuje je z trudnością - nie rozumie instrukcji',
      ),
      disense(
        'Zdolność wypowiadania się:',
        'Bardzo dobra - dobra - przeciętna - raczej słaba - bardzo słaba',
      ),
      disense(
        'Tempo pracy:',
        'Bardzo szybkie - szybkie - przeciętne - raczej powolne - bardzo powolne',
      ),
      disense(
        'Stosunek do badań:',
        'Bardzo korzystny - korzystny - niezbyt korzystny - niekorzystny',
      ),
      disense(
        'Wygląd zwenętrzny:',
        'Czysty - brudny, zadbany - niezadbany, wyróżniający się - typowy, cechy charakterystyczne: (blizny tatua, znamiona, ozdoby)',
      ),
    ],
  );
}
