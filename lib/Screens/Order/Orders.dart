import 'package:enlatadosmgapp/Models/Dealer.dart';
import 'package:enlatadosmgapp/Models/Vehicle.dart';
import 'package:enlatadosmgapp/Screens/Dealer/Create.dart';
import 'package:enlatadosmgapp/Screens/Dealer/Report.dart';
import 'package:enlatadosmgapp/Screens/Dealer/Update.dart';
import 'package:enlatadosmgapp/Screens/Order/Detail.dart';
import 'package:enlatadosmgapp/Screens/Order/Report.dart';
import 'package:enlatadosmgapp/Service/DealerService.dart';
import 'package:enlatadosmgapp/Service/OrderService.dart';
import 'package:enlatadosmgapp/Service/VehicleService.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;

import '../../Models/Order.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  OrderService _orderService = OrderService();
  VehicleService _vehicleService = VehicleService();
  DealerService _dealerService = DealerService();
  List<Order> orders = <Order>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Order> data = [];
    return Scaffold(
      drawer: Drawer(
          backgroundColor: Colors.white,
          child: Padding(
            padding: EdgeInsets.only(top: 35),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.red,
                  radius: 45,
                  child: Icon(
                    FontAwesomeIcons.user,
                    color: Colors.white,
                    size: 45,
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                Text("Órdenes", style: GoogleFonts.dmSans(fontSize: 25.0)),
                Divider(),
                ListTile(
                  subtitle: Text("Modificación del stock"),
                  leading: Icon(FontAwesomeIcons.boxesStacked),
                  title: Text("Gestor de stock",
                      style: GoogleFonts.dmSans(fontSize: 18)),
                  trailing: Icon(FontAwesomeIcons.arrowRight, size: 18),
                  onTap: () {
                    Navigator.pushNamed(context, '/stock/')
                        .then((value) => setState(() {
                              _orderService
                                  .getOrders(context)
                                  .then((value) => {data = value});
                            }));
                  },
                ),
                Divider(),
                Padding(
                  padding: EdgeInsets.only(top: 75),
                  child: Text("EnlatadosMG v1.0.1 - @emiliohernandezdev"),
                )
              ],
            ),
          )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/order/create')
              .then((value) => setState(() {
                    _orderService
                        .getOrders(context)
                        .then((value) => {data = value});
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
                    background:
                        Image.asset("assets/latas.jpg", fit: BoxFit.cover),
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
                                  builder: (context) => OrdersReport()));
                        },
                        icon: Icon(FontAwesomeIcons.diagramProject),
                        tooltip: "Generar reporte de lista enlazada de órdenes")
                  ],
                )
              ],
          body: FutureBuilder<List<Order>>(
              future: _orderService.getOrders(context),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data.length > 0) {
                    return RefreshIndicator(
                      edgeOffset: 50,
                      triggerMode: RefreshIndicatorTriggerMode.anywhere,
                      color: Colors.red,
                      child: ListView.builder(
                          padding: EdgeInsets.all(12),
                          itemCount: snapshot.data.length,
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            data = snapshot.data;
                            return SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Dismissible(
                                direction: DismissDirection.none,
                                key: UniqueKey(),
                                child: Card(
                                    color: Colors.white,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        ListTile(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      OrderDetail( number: data[index].number)),
                                            ).then((value) => setState(() {
                                                  _orderService
                                                      .getOrders(context)
                                                      .then((value) =>
                                                          {data = value});
                                                }));
                                          },
                                          leading: CircleAvatar(
                                            backgroundColor: Colors.red,
                                            child: Icon(FontAwesomeIcons.box,
                                                color: Colors.black),
                                          ),
                                          title: Text(data[index].number,
                                              style: TextStyle(fontSize: 15)),
                                          subtitle: Text(
                                            "Fecha: " +
                                                DateFormat("dd-MM-yyy hh:mm")
                                                    .format(
                                                        data[index].startDate),
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          trailing: Column(
                                            children: [
                                              Text(data[index].status ==
                                                      "PENDING"
                                                  ? "Pendiente"
                                                  : "Finalizada"),
                                              data[index].status == "PENDING"
                                                  ? Icon(FontAwesomeIcons.clock,
                                                      color: Colors.red)
                                                  : Icon(FontAwesomeIcons.check,
                                                      color: Colors.green)
                                            ],
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                            );
                          }),
                      onRefresh: () async {
                        const snackBar = SnackBar(
                          content: Text('Registros actualizados'),
                        );

                        _orderService
                            .getOrders(context)
                            .then((value) => setState(() {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                  data = value;
                                }))
                            .catchError((err) => {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(err))),
                                });
                      },
                    );
                  } else {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("No hay registros",
                            style: GoogleFonts.dmSans(fontSize: 28.0))
                      ],
                    );
                  }
                }
                return CircularProgressIndicator();
              })),
    );
  }
}
