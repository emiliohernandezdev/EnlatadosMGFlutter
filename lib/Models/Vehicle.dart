import 'dart:convert';

class Vehicle {
  Vehicle(
      {required this.licensePlate,
      required this.brand,
      required this.model,
      required this.color,
      required this.year});

  String licensePlate;
  String brand;
  String model;
  String color;
  int year;

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
        licensePlate: json["licensePlate"],
        brand: json["brand"],
        model: json["model"],
        color: json["color"],
        year: json["year"]);
  }
}
