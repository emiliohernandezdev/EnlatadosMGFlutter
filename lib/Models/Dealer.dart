import 'dart:convert';

class Dealer {
  Dealer(
      {required this.cui,
      required this.name,
      required this.surname,
      required this.license,
      required this.phone});

  String cui;
  String name;
  String surname;
  String license;
  String phone;

  factory Dealer.fromJson(Map<String, dynamic> json) {
    return Dealer(
        cui: json["cui"],
        name: json["name"],
        surname: json["surname"],
        license: json["license"],
        phone: json["phone"]);
  }
}
