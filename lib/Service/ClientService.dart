import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import '../Models/Client.dart';

class ClientService {
  String url = "http://192.168.0.8:8080/";

  Future<List<ClientM>> getClients(BuildContext context, String? order) async {
    var endpoint = '${url}client/all?order=${order}';
    print(endpoint);
    final response = await http.get(Uri.parse(endpoint), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    });
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List<ClientM> registers = [];
      for (data in data) {
        registers.add(ClientM.fromJson(data));
      }
      return registers;
    } else {
      print(response.statusCode);
      print(response.body);
      const snackBar = SnackBar(
          content: Text("Ocurrió un error al obtener los registros."),
          elevation: 15,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return <ClientM>[];
    }
  }

  Future addClient(String cui, String name, String surname, String phone,
      String address) async {
    var uri = url + "client/add";
    Map body = {
      'cui': int.parse(cui),
      'name': name,
      'surname': surname,
      'phone': phone,
      'address': address
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
