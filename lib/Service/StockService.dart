import 'dart:convert';

import 'package:enlatadosmgapp/Models/Stock.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class StockService{
  String url = "http://192.168.1.13:8080/";

  Future<List<Stock>> getStock(BuildContext context) async {
    var endpoint = '${url}/stock/all';
    final response = await http.get(Uri.parse(endpoint), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    });
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List<Stock> registers = [];
      for (data in data) {
        registers.add(Stock.fromJson(data));
      }
      return registers;
    } else {
      const snackBar = SnackBar(
          content: Text("Ocurrió un error al obtener los registros."),
          elevation: 15,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return <Stock>[];
    }
  }
}