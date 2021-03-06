import 'dart:convert' as convert;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../Models/Dealer.dart';

class DealerService {
  String url = "http://192.168.1.13:8080/";

  Future<List<Dealer>> getDealers(BuildContext context) async {
    var endpoint = '${url}/dealer/all';
    final response = await http.get(Uri.parse(endpoint), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    });
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List<Dealer> registers = [];
      for (data in data) {
        registers.add(Dealer.fromJson(data));
      }
      return registers;
    } else {
      const snackBar = SnackBar(
          content: Text("Ocurrió un error al obtener los registros."),
          elevation: 15,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return <Dealer>[];
    }
  }

  Future addDealer(String cui, String name, String surname, String phone,
      String license) async {
    var uri = url + "dealer/add";
    Map body = {
      'cui': int.parse(cui),
      'name': name,
      'surname': surname,
      'phone': phone,
      'license': license
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

  Future<String> getGraph() async {
    var endpoint = '${url}dealer/graphviz';

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

  Future<Dealer> getDealer(int id) async {
    var endpoint = '${url}dealer/${id}';
    final Response response = await http.get(
      Uri.parse(endpoint),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return Dealer.fromJson(data);
    } else {
      throw Exception(response.body);
    }
  }


  Future deleteDealer(int id) async {
    print('CUI de cliente: ${id}');
    var endpoint = '${url}dealer/delete/${id}';
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

  Future updateDealer(String cui, String name, String surname, String phone, String license) async {
    var endpoint = '${url}dealer/update/${cui}';
    Map body = {
      'cui': cui,
      'name': name,
      'surname': surname,
      'license': license,
      'phone': phone,
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
