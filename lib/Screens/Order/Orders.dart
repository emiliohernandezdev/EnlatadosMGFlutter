import 'package:enlatadosmgapp/Models/Dealer.dart';
import 'package:enlatadosmgapp/Screens/Dealer/Create.dart';
import 'package:enlatadosmgapp/Screens/Dealer/Report.dart';
import 'package:enlatadosmgapp/Screens/Dealer/Update.dart';
import 'package:enlatadosmgapp/Service/DealerService.dart';
import 'package:enlatadosmgapp/Service/OrderService.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;

import '../../Models/Order.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  OrderService _orderService = OrderService();
  List<Order> orders = <Order>[];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Order> data = [];
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/order/create')
              .then((value) => setState(() {
                    
                  }));
        },
        tooltip: 'Agregar orden',
      ),
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerbox) => [
          SliverAppBar(
            backgroundColor: Colors.red,
            expandedHeight: 260,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset("assets/latas.jpg", fit: BoxFit.cover),
            ),
            floating: true,
            elevation: 12.0,
            pinned: true,
            centerTitle: true,
            title: Text("Órdenes"),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DealersReport()));
                  },
                  icon: Icon(FontAwesomeIcons.diagramProject),
                  tooltip: "Generar reporte de cola de repartidores")
            ],
          )
        ],
        body: Column(),
      ),
    );
  }
}
