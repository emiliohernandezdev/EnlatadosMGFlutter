import 'package:enlatadosmgapp/Service/AuthService.dart';
import 'package:flutter/material.dart';

import '../../Models/User.dart';

class Reports extends StatefulWidget {
  const Reports({Key? key}) : super(key: key);

  @override
  State<Reports> createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  AuthService _authService = AuthService();

  String usersLinkedList = "";

  Future<List<User>> getUsers() async {
    return _authService.getUsers(context);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("Reportes"),
        ),
        body: Column(
          children: [
            Card(
              child: Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            "https://ericknavarro.io/2019/04/26/08-Graficar-arboles-AVL-con-Graphviz-y-Java/03.jpeg"))),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text('Lista enlazada de usuarios',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w500)),
                ),
              ),
              margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0),
            ),
          ],
        ));
  }
}
