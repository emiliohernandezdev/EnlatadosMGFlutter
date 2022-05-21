import 'dart:convert' as convert;
import 'dart:convert';
import 'package:enlatadosmgapp/Models/Order.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../Models/Dealer.dart';

class OrderService {
  String url = "http://192.168.1.13:8080/";

  Future<List<Order>> getOrders(BuildContext context) async {
    var endpoint = '${url}/order/all';
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
          content: Text("Ocurrió un error al obtener los registros."),
          elevation: 15,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return <Order>[];
    }
  }

  Future addOrder(String odpt, String ddpt, String date, String vehi,
      String client, String dealer, String box) async {
    var uri = '${url}order/add';
    print(uri);
    Map body = {
      'origin': odpt,
      'destination': ddpt,
      'date': date,
      'status': "PENDING",
      'vehicle': vehi,
      'client': client,
      'dealer': dealer,
      "boxes": box
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

  Future<String> getGraph() async {
    var endpoint = '${url}order/graphviz';

    final Response response = await http.get(Uri.parse(endpoint), headers: {
      'Content-Type': 'application/json;charset=UTF-8',
      'Accept': 'application/json',
      'Charset': 'utf-8'
    });
    if (response.statusCode == 200) {
      return response.body.toString();
    } else {
      throw Exception(response.body);
    }
  }


  Future updateStatus(String number) async {
    var id = number.split("#-")[1].toString();
    var endpoint = '${url}order/update/${id}';
    Map body = {
      'status': "FINISHED",
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
}
