import 'dart:convert';

class ClientM {
  ClientM(
      {required this.cui,
      required this.name,
      required this.surname,
      required this.phone,
      required this.address});

  String cui;
  String name;
  String surname;
  String phone;
  String address;

  factory ClientM.fromJson(Map<String, dynamic> json) {
    return ClientM(
        cui: json["cui"],
        name: json["name"],
        surname: json["surname"],
        phone: json["phone"],
        address: json["address"]);
  }
}
