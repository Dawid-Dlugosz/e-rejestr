const medicalRegister = 0;
const psychologicalRegister = 1;
const psychologistCard = 2;
const newJudgment = 3;

String pageTitle(int pageIndex) {
  switch (pageIndex) {
    case medicalRegister:
      return 'Rejestr lekarski';
    case psychologicalRegister:
      return 'Rejest psychologiczny';
    case psychologistCard:
      return 'Karta Badania psychologicznego';
    case newJudgment:
      return 'Nowe orzeczenie';
    default:
      return '';
  }
}
