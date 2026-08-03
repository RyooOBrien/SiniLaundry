class CountryModel {
  final String name;
  final String code;
  final String dialCode;
  final String flag;

  final String example;

  final int minLength;

  final int maxLength;

  const CountryModel({
    required this.name,
    required this.code,
    required this.dialCode,
    required this.flag,
    required this.example,
    required this.minLength,
    required this.maxLength,
  });
}