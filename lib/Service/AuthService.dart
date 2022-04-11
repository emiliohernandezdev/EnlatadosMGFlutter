import 'dart:convert' as convert;
import 'dart:convert';
import 'package:enlatadosmgapp/Screens/User/Home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../Models/User.dart';

class AuthService {
  String url = "http://localhost:8080/";

  Future<List<User>> getUsers() async {
    http.Response res = await get(Uri.parse(url));

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<User> users =
          body.map((dynamic item) => User.fromJson(item)).toList();

      return users;
    } else {
      throw "No se pudieron obtener los usuarios";
    }
  }

  login(String id, String password, BuildContext context) async {
    Map data = {'id': id, 'password': password};

    url += "user/auth";

    var body = json.encode(data);
    final response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: body,
        encoding: convert.Encoding.getByName("utf-8"));

    if (response.statusCode == 200) {
      Map<String, dynamic> resp = jsonDecode(response.body);
      if (resp["success"] == true) {
        const snackBar = SnackBar(
          content: Text('Sesión iniciada correctamente'),
          behavior: SnackBarBehavior.floating,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.of(context).pop();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const UserHome()));
      } else {
        Navigator.of(context).pop();
        final alert = AlertDialog(
          title: const Text('Error al iniciar sesión'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text("Verifica tus credenciales"),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Cerrar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return alert;
            });
      }
    }
  }
}
