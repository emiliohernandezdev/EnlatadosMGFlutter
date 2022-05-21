import 'dart:convert';

import 'package:enlatadosmgapp/Models/Order.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;


class OrderService {
  String url = "http://192.168.1.13:8080/";

  Future<List<Order>> getOrders(BuildContext context) async {
    var endpoint = '${url}order/all';
    print(endpoint);
    final response = await http.get(Uri.parse(endpoint), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    });
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List<Order> registers = [];
      for (data in data) {
        registers.add(Order.fromJson(data));
      }
      return registers;
    } else {
      const snackBar = SnackBar(
          content: Text("Ocurrió un error al obtener los vehiculos."),
          elevation: 15,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return <Order>[];
    }
  }

  Future addOrder(String licensePlate, String brand, String model,
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


}
