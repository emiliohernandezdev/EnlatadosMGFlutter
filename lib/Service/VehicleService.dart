import 'dart:convert';

import 'package:enlatadosmgapp/Models/Vehicle.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import '../Models/Client.dart';

class VehicleService {
  String url = "http://192.168.1.13:8080/";

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
    var uri = '${url}vehicle/add';
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
      throw Exception(response.body);
    }
  }


  Future deleteVehicle(String plate) async {
    var endpoint = '${url}vehicle/delete/${plate}';
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

  Future<Vehicle> getVehicle(String lp) async {
    var endpoint = '${url}vehicle/${lp}';
    final Response response = await http.get(
      Uri.parse(endpoint),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return Vehicle.fromJson(data);
    } else {
      throw Exception(response.body);
    }
  }




  Future updateVehicle(String last, String licensePlate, String brand, String color, String year, String model) async {
    var endpoint = '${url}vehicle/update/${last}';
    Map body = {
      'licensePlate': licensePlate,
      'brand': brand,
      'color': color,
      'year': int.parse(year),
      'model': model,
    };

    final Response response = await http.patch(Uri.parse(endpoint),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: json.encode(body));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception(response.body);
    }
  }

  Future<String> getGraph() async {
    var endpoint = '${url}vehicle/graphviz';

    final Response response = await http.get(Uri.parse(endpoint), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    });
    if (response.statusCode == 200) {
      return response.body.toString();
    } else {
      throw Exception(response.body);
    }
  }
}
