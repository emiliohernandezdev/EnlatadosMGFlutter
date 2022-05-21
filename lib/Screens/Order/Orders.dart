import 'package:enlatadosmgapp/Models/Dealer.dart';
import 'package:enlatadosmgapp/Models/Vehicle.dart';
import 'package:enlatadosmgapp/Screens/Dealer/Create.dart';
import 'package:enlatadosmgapp/Screens/Dealer/Report.dart';
import 'package:enlatadosmgapp/Screens/Dealer/Update.dart';
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
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext bc) =>
                                                        AlertDialog(
                                                          contentPadding:
                                                              EdgeInsets.zero,
                                                          title: Center(
                                                            child: Text(
                                                                "Orden " +
                                                                    data[index]
                                                                        .number,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        22.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600)),
                                                          ),
                                                          content: Card(
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: <
                                                                  Widget>[
                                                                Divider(),
                                                                ListTile(
                                                                  leading:
                                                                      CircleAvatar(
                                                                    radius:
                                                                        35.0,
                                                                    backgroundColor: Color((math.Random().nextDouble() *
                                                                                0xFFFFFF)
                                                                            .toInt())
                                                                        .withOpacity(
                                                                            1.0),
                                                                    child: Icon(
                                                                        FontAwesomeIcons
                                                                            .boxOpen),
                                                                  ),
                                                                  title: Wrap(
                                                                    children: [
                                                                      Text(
                                                                          "Cliente: ",
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 19.0)),
                                                                      Text(
                                                                          data[index].client.name +
                                                                              " " +
                                                                              data[index].client.surname,
                                                                          style: TextStyle(fontSize: 19.0))
                                                                    ],
                                                                  ),
                                                                  subtitle:
                                                                      Wrap(
                                                                    children: [
                                                                      Text(
                                                                          "Vehículo: ",
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 19.0)),
                                                                      Text(
                                                                          data[index].vehicle.brand +
                                                                              " " +
                                                                              data[index].vehicle.model +
                                                                              " " +
                                                                              "(" +
                                                                              data[index].vehicle.licensePlate +
                                                                              ")",
                                                                          style: TextStyle(fontSize: 19.0)),
                                                                      Text(
                                                                          "Repartidor: ",
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 19.0)),
                                                                      Text(
                                                                          data[index].dealer.name +
                                                                              " " +
                                                                              data[index].dealer.surname,
                                                                          style: TextStyle(fontSize: 19.0)),
                                                                    ],
                                                                  ),
                                                                  isThreeLine:
                                                                      true,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          actions: [
                                                            data[index].status ==
                                                                    "PENDING"
                                                                ? MaterialButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                      _orderService
                                                                          .updateStatus(data[index]
                                                                              .number)
                                                                          .then((value) =>
                                                                              {
                                                                                if (value["success"] == true)
                                                                                  {
                                                                                    print(value["result"]),
                                                                                    _vehicleService.addVehicle(data[index].vehicle.licensePlate, data[index].vehicle.brand, data[index].vehicle.model, data[index].vehicle.color, data[index].vehicle.year.toString()),
                                                                                    _dealerService.addDealer(data[index].dealer.cui, data[index].dealer.name, data[index].dealer.surname, data[index].dealer.phone, data[index].dealer.license),
                                                                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                                      content: Text(value["message"]),
                                                                                    )),
                                                                                    setState(() {
                                                                                      _orderService.getOrders(context).then((value) => {
                                                                                            data = value
                                                                                          });
                                                                                    })
                                                                                  }
                                                                                else
                                                                                  {
                                                                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                                      content: Text(value["message"]),
                                                                                    ))
                                                                                  }
                                                                              });
                                                                    },
                                                                    child: Text(
                                                                        "Dar por finalizada",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                17.0)),
                                                                  )
                                                                : Text(
                                                                    "Orden ya finalizada."),
                                                            MaterialButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Text(
                                                                  "Cerrar",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          17.0)),
                                                            )
                                                          ],
                                                        ));
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
