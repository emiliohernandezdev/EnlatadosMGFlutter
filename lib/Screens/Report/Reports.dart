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
      backgroundColor: Colors.black,
      body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerbox) => [
                SliverAppBar(
                  backgroundColor: Colors.red,
                  expandedHeight: 180,
                  flexibleSpace: FlexibleSpaceBar(
                    background:
                        Image.asset("assets/latas.jpg", fit: BoxFit.cover),
                  ),
                  floating: true,
                  elevation: 12.0,
                  pinned: true,
                  centerTitle: true,
                  title: Text("Reportería", style: TextStyle(fontSize: 25.0)),
                  titleSpacing: NavigationToolbar.kMiddleSpacing,
                )
              ],
          body: GridView.count(
            physics: ScrollPhysics(),
            shrinkWrap: true,
            primary: false,
            padding: const EdgeInsets.all(20),
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            children: <Widget>[
              Card(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      image: DecorationImage(
                          fit: BoxFit.fitHeight,
                          image: AssetImage('assets/client.png'))),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text('Árbol AVL de \nClientes'),
                  ),
                ),
              ),
              Card(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/users.png'))),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text('Lista enlazada\nde Usuarios'),
                  ),
                ),
              ),
              Card(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/products.png'))),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text('Pila\nde cajas de productos'),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
