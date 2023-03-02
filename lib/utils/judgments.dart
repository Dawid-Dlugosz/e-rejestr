const judgmentOgolny = 'Ogólny';
const judgmentPrzedluzenie = 'Przedłużenie';
const judgment39 = '39';
const judgmentUprzywilej = 'Uprzywilej';
const judgmentAlkohol = 'Alkohol';
const judgmentPunktyKarne = 'Punkty karne';
const judgmentPrzywrocenie = 'Przywrócenie';
const judgmentWypadek = 'Wypadek';
const judgmentInstruktor = 'Instruktor';
const medicalMedycynaPracy = 'Medycyna pracy';
const medicalMedycynaPracyInstruktor = 'Medycyna pracy instruktor';
const medicalStarajacySie = 'Kierowca starający się';
const medicalStarajacySiePrzedluzenie = 'Kierowca starający się przedłużenie';
const medicalStarajacySieNieletni = 'Kierowca starający się przedłużenie nieletni 3 pieczątki';

const art82 = 'art. 82';
const art39 = 'art. 39k';

String getJudgmentArticle(String name) {
  switch (name) {
    case judgmentOgolny:
      return art82;
    case judgmentPrzywrocenie:
      return art82;
    case judgment39:
      return art39;
    case judgmentUprzywilej:
      return art82;
    case judgmentAlkohol:
      return art82;
    case judgmentPunktyKarne:
      return art82;
    case judgmentPrzedluzenie:
      return art82;
    case judgmentWypadek:
      return art82;
    case judgmentInstruktor:
      return art82;
    default:
      return '';
  }
}
