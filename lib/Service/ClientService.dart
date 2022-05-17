import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import '../Models/Client.dart';

class ClientService {
  String url = "http://192.168.1.8:8080/";

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
    var endpoint = '${url}client/add';
    Map body = {
      'cui': int.parse(cui),
      'name': name,
      'surname': surname,
      'phone': phone,
      'address': address
    };
    print(endpoint);

    final Response response = await http.post(Uri.parse(endpoint),
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
    var endpoint = '${url}client/graphviz';

    final Response response = await http.get(Uri.parse(endpoint), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    });
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception(response.body);
    }
  }

  Future updateClient(String cui, String name, String surname, String phone,
      String address) async {
    var endpoint = '${url}client/update/${int.parse(cui)}';
    Map body = {
      'name': name,
      'surname': surname,
      'phone': phone,
      'address': address
    };

    final Response response = await http.post(Uri.parse(endpoint),
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

  Future<ClientM> getClient(int id) async {
    var endpoint = '${url}client/${id}';
    final Response response = await http.get(
      Uri.parse(endpoint),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return ClientM.fromJson(data);
    } else {
      throw Exception(response.body);
    }
  }

  Future deleteClient(int id) async {
    print('CUI de cliente: ${id}');
    var endpoint = '${url}client/delete/${id}';
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
