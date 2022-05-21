
import 'dart:convert';

import 'package:enlatadosmgapp/Models/Client.dart';
import 'package:enlatadosmgapp/Models/Dealer.dart';
import 'package:enlatadosmgapp/Models/Vehicle.dart';

class Order {
  Order(
      {required this.originDepartment,
      required this.destinationDepartment,
      required this.startDate,
      required this.client,
      required this.dealer,
      required this.vehicle,
      required this.status});

  String originDepartment;
  String destinationDepartment;
  DateTime startDate;
  ClientM client;
  Dealer dealer;
  Vehicle vehicle;
  String status;

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
        originDepartment: json["originDepartment"],
        destinationDepartment: json["destinationDepartment"],
        startDate: DateTime.parse(json["startDate"]),
        client: json["client"],
        dealer: json["dealer"],
        vehicle: json["vehicle"],
        status: json["status"]);
  }
}
