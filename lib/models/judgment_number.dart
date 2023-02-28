class JudgmentNumber {
  JudgmentNumber({required this.personNo, required this.month, required this.year});

  @override
  String toString() {
    return '$personNo/$month/$year';
  }

  factory JudgmentNumber.fromString(String number) {
    var numbers = number.split('/');
    return JudgmentNumber(
      personNo: numbers[0],
      month: int.parse(numbers[1]),
      year: numbers[2],
    );
  }

  final String personNo;
  final int month;
  final String year;
}
