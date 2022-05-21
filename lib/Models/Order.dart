
import 'dart:convert';

import 'package:enlatadosmgapp/Models/Client.dart';
import 'package:enlatadosmgapp/Models/Dealer.dart';
import 'package:enlatadosmgapp/Models/Vehicle.dart';

class Order {
  Order(
      {
        required this.number,
      required this.originDepartment,
      required this.destinationDepartment,
      required this.startDate,
      required this.boxes,
      required this.client,
      required this.dealer,
      required this.vehicle,
      required this.status});

  String number;
  String originDepartment;
  String destinationDepartment;
  DateTime startDate;
  int boxes;
  ClientM client;
  Dealer dealer;
  Vehicle vehicle;
  String status;

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      number: json["number"],
        originDepartment: json["origin"],
        destinationDepartment: json["destination"],
        startDate: DateTime.parse(json["date"]),
        boxes: json["boxes"],
        client: ClientM.fromJson(json["client"]),
        dealer: Dealer.fromJson(json["dealer"]),
        vehicle: Vehicle.fromJson(json["vehicle"]),
        status: json["status"]);
  }
}
