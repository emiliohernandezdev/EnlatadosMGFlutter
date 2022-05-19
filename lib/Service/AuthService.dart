import 'dart:convert' as convert;
import 'dart:convert';
import 'dart:io';
import 'package:enlatadosmgapp/Screens/User/Home.dart';
import 'package:enlatadosmgapp/Service/StorageService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../Models/User.dart';

class AuthService {
  String url = "http://127.0.0.1:8080/";

  Future<List<User>> getUsers(BuildContext context) async {
    var endpoint = '${url}/user/all';
    final response = await http.get(Uri.parse(endpoint), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    });
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List<User> registers = [];
      for (data in data) {
        registers.add(User.fromJson(data));
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
      return <User>[];
    }
  }

  Future getUserProfile(BuildContext context) async {
    var endpoint = '${url}/user/profile';
    final FlutterSecureStorage storage = FlutterSecureStorage();
    Map<String, String> headers = {};

    String token = "";
    await storage.read(key: "jwt").then((value) => {
          token = (value != null) ? value : "",
          headers = {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            HttpHeaders.authorizationHeader: token
          }
        });
    final response = await http.get(Uri.parse(endpoint), headers: headers);
    Map<String, dynamic> resp = jsonDecode(response.body);
    if (response.statusCode == 200) {
      if (resp["success"] == true && resp["result"] != null) {
        return resp["result"];
      }
    } else {
      print(resp);
      const snackBar = SnackBar(
          content: Text("Ocurrió un error al obtener el perfil del usuario."),
          elevation: 15,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return {};
    }
  }

  login(String id, String password, BuildContext context) async {
    Map data = {'id': id, 'password': password};

    var endpoint = '${url}/user/auth';

    var body = json.encode(data);
    final response = await http.post(Uri.parse(endpoint),
        headers: {"Content-Type": "application/json"},
        body: body,
        encoding: convert.Encoding.getByName("utf-8"));

    print(response.statusCode);
    if (response.statusCode == 200) {
      FlutterSecureStorage storage = FlutterSecureStorage();
      Map<String, dynamic> resp = jsonDecode(response.body);
      if (resp["success"] == true && resp["result"] != null) {
        print(resp);
        const snackBar = SnackBar(
            content: Text('Sesión iniciada correctamente'),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        //Navigator.of(context).pop();
        await storage.write(key: "jwt", value: resp["result"]);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => UserHome()),
            (Route<dynamic> route) => false);
      } else if (resp["result"] == null) {
        const snackBar = SnackBar(
            content: Text("Verifica tu ID y tu contraseña :("),
            elevation: 15,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } else if (response.statusCode == 401) {
      const snackBar = SnackBar(
          content: Text("Credenciales no autorizadas."),
          elevation: 15,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (response.statusCode == 404) {
      const snackBar = SnackBar(
          content: Text(
              "404. Ocurrió un error extraño, vuelve a intentarlo más tarde, por favor."),
          elevation: 15,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      const snackBar = SnackBar(
          content: Text("Error desconocido :("),
          elevation: 15,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
