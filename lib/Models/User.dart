import 'dart:convert';

class User {
  User(
      {required this.id,
      required this.name,
      required this.surname,
      required this.password});

  int id;
  String name;
  String surname;
  String password;

  factory User.fromJson(Map<String, dynamic> json) => User(
      id: json["id"],
      name: json["name"],
      surname: json["surname"],
      password: json["password"]);
  Map<String, dynamic> toJson() => {"id": id, "name": name, "surname": surname};
}
