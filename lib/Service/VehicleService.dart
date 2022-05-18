import 'dart:convert';

import 'package:enlatadosmgapp/Models/Vehicle.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import '../Models/Client.dart';

class VehicleService {
  String url = "http://192.168.1.9:8080/";

  Future<List<Vehicle>> getVehicles(BuildContext context) async {
    var endpoint = '${url}vehicle/all';
    print(endpoint);
    final response = await http.get(Uri.parse(endpoint), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    });
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List<Vehicle> registers = [];
      for (data in data) {
        registers.add(Vehicle.fromJson(data));
      }
      return registers;
    } else {
      print(response.statusCode);
      print(response.body);
      const snackBar = SnackBar(
          content: Text("Ocurrió un error al obtener los vehiculos."),
          elevation: 15,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return <Vehicle>[];
    }
  }

  Future addVehicle(String licensePlate, String brand, String model,
      String color, String year) async {
    var uri = url + "vehicle/add";
    Map body = {
      'licensePlate': licensePlate,
      'brand': brand,
      'model': model,
      'color': color,
      'year': int.parse(year)
    };

    final Response response = await http.post(Uri.parse(uri),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: json.encode(body));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Error bro");
    }
  }

  Future deleteVehicle(int id) async {
    var endpoint = '${url}vehicle/delete/${id}';
    print(endpoint);
    final Response resp = await http.delete(
      Uri.parse(endpoint),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
    );
    if (resp.statusCode == 200) {
      return json.decode(resp.body);
    } else {
      throw Exception(resp.body);
    }
  }
}
