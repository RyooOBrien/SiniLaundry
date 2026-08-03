import '../models/country_model.dart';

const countries = [
  CountryModel(
    name: "Indonesia",
    code: "ID",
    dialCode: "+62",
    flag: "🇮🇩",

    example: "81234567890",
    minLength: 9,
    maxLength: 13,
  ),
  CountryModel(
    name: "Malaysia",
    code: "MY",
    dialCode: "+60",
    flag: "🇲🇾",

    example: "123456789",
    minLength: 9,
    maxLength: 10,
  ),
  CountryModel(
    name: "Singapore",
    code: "SG",
    dialCode: "+65",
    flag: "🇸🇬",

    example: "81234567",
    minLength: 8,
    maxLength: 8,
  ),
  CountryModel(
    name: "United States",
    code: "US",
    dialCode: "+1",
    flag: "🇺🇸",

    example: "2015550123",
    minLength: 10,
    maxLength: 10,
  ),
  CountryModel(
    name: "United Kingdom",
    code: "GB",
    dialCode: "+44",
    flag: "🇬🇧",

    example: "7912345678",
    minLength: 10,
    maxLength: 10,
  ),

  CountryModel(
    name: "Japan",
    code: "JP",
    dialCode: "+81",
    flag: "🇯🇵",

    example: "9012345678",
    minLength: 10,
    maxLength: 10,
),
];