import 'package:enlatadosmgapp/Screens/Dealer/Update.dart';
import 'package:enlatadosmgapp/Service/DealerService.dart';
import 'package:enlatadosmgapp/Service/OrderService.dart';
import 'package:enlatadosmgapp/Service/VehicleService.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Models/Order.dart';

class OrderDetail extends StatefulWidget {
  const OrderDetail({Key? key, required this.number}) : super(key: key);
  final String number;

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  final OrderService _orderService = OrderService();
  final VehicleService _vehicleService = VehicleService();
  final DealerService _dealerService = DealerService();
  String orderNumber = "";

  @override
  void initState() {
    _orderService
        .getOrder(widget.number)
        .then((value) => {print(value), orderNumber = value.number});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.grey),
        ),
        backgroundColor: Colors.white,
        body: FutureBuilder<Order>(
          future: _orderService.getOrder(widget.number),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data != null) {
                return SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Orden ${snapshot.data!.number}',
                            style: GoogleFonts.dmSans(
                                fontWeight: FontWeight.bold, fontSize: 22)),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 15),
                          height: 1,
                          color: Colors.grey,
                        ),
                        Card(
                          margin: EdgeInsets.fromLTRB(12, 5, 12, 5),
                          elevation: 4,
                          color: Colors.indigo,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16),
                            child: Row(
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Text("Fecha",
                                        style: GoogleFonts.dmSans(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white)),
                                    SizedBox(height: 4),
                                    Text(
                                        snapshot.data!.startDate
                                            .toString()
                                            .toString(),
                                        style: GoogleFonts.dmSans(
                                            color: Colors.white70)),
                                  ],
                                ),
                                Spacer(),
                                CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 24,
                                    child: Icon(
                                      FontAwesomeIcons.calendar,
                                      color: Colors.black,
                                    )),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          margin: EdgeInsets.fromLTRB(12, 5, 12, 5),
                          elevation: 4,
                          color: snapshot.data!.status == "PENDING"
                              ? Colors.red
                              : Colors.green,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16),
                            child: Row(
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Text("Estado",
                                        style: GoogleFonts.dmSans(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white)),
                                    SizedBox(height: 4),
                                    Text(
                                        snapshot.data!.status == "PENDING"
                                            ? "Pendiente"
                                            : "Completada",
                                        style: GoogleFonts.dmSans(
                                            color: Colors.white70)),
                                  ],
                                ),
                                Spacer(),
                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 24,
                                  child: snapshot.data!.status == "PENDING"
                                      ? Icon(FontAwesomeIcons.clock,
                                          color: Colors.red)
                                      : Icon(FontAwesomeIcons.check,
                                          color: Colors.green),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          margin: EdgeInsets.fromLTRB(12, 5, 12, 5),
                          elevation: 4,
                          color: Colors.teal,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16),
                            child: Row(
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Text("Departamento de origen",
                                        style: GoogleFonts.dmSans(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white)),
                                    SizedBox(height: 4),
                                    Text(snapshot.data!.originDepartment,
                                        style: GoogleFonts.dmSans(
                                            color: Colors.white70)),
                                  ],
                                ),
                                Spacer(),
                                CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 24,
                                    child: Icon(
                                        FontAwesomeIcons
                                            .buildingCircleArrowRight,
                                        color: Colors.black)),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          margin: EdgeInsets.fromLTRB(12, 5, 12, 5),
                          elevation: 4,
                          color: Colors.teal,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16),
                            child: Row(
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Text("Departamento de destino",
                                        style: GoogleFonts.dmSans(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white)),
                                    SizedBox(height: 4),
                                    Text(snapshot.data!.destinationDepartment,
                                        style: GoogleFonts.dmSans(
                                            color: Colors.white70)),
                                  ],
                                ),
                                Spacer(),
                                CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 24,
                                    child: Icon(FontAwesomeIcons.buildingFlag,
                                        color: Colors.black)),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          margin: EdgeInsets.fromLTRB(12, 5, 12, 5),
                          elevation: 4,
                          color: Colors.amber[600],
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16),
                            child: Row(
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Text("Cliente",
                                        style: GoogleFonts.dmSans(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white)),
                                    SizedBox(height: 4),
                                    Text(
                                        "Nombre: " +
                                            snapshot.data!.client.name +
                                            " " +
                                            snapshot.data!.client.surname,
                                        style: GoogleFonts.dmSans(
                                            color: Colors.white70)),
                                    Text(
                                        "Teléfono: " +
                                            snapshot.data!.client.phone,
                                        style: GoogleFonts.dmSans(
                                            color: Colors.white70)),
                                  ],
                                ),
                                Spacer(),
                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 24,
                                  child: Icon(FontAwesomeIcons.userTie,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          margin: EdgeInsets.fromLTRB(12, 5, 12, 5),
                          elevation: 4,
                          color: Color.fromRGBO(64, 75, 96, .9),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16),
                            child: Row(
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Text("Repartidor",
                                        style: GoogleFonts.dmSans(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white)),
                                    SizedBox(height: 4),
                                    Text(
                                        "Nombre: " +
                                            snapshot.data!.dealer.name +
                                            " " +
                                            snapshot.data!.dealer.surname,
                                        style: GoogleFonts.dmSans(
                                            color: Colors.white70)),
                                    Text(
                                        "Teléfono: " +
                                            snapshot.data!.dealer.phone,
                                        style: GoogleFonts.dmSans(
                                            color: Colors.white70)),
                                  ],
                                ),
                                Spacer(),
                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 24,
                                  child: Icon(FontAwesomeIcons.peopleCarryBox,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          margin: EdgeInsets.fromLTRB(12, 5, 12, 5),
                          elevation: 4,
                          color: Colors.blue[500],
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16),
                            child: Row(
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Text("Vehículo",
                                        style: GoogleFonts.dmSans(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white)),
                                    SizedBox(height: 4),
                                    Text(
                                        "Placa: " +
                                            snapshot.data!.vehicle.licensePlate,
                                        style: GoogleFonts.dmSans(
                                            color: Colors.white70)),
                                    Text(
                                        "Marca: " +
                                            snapshot.data!.vehicle.brand,
                                        style: GoogleFonts.dmSans(
                                            color: Colors.white70)),
                                    Text(
                                        "Modelo: " +
                                            snapshot.data!.vehicle.model,
                                        style: GoogleFonts.dmSans(
                                            color: Colors.white70)),
                                  ],
                                ),
                                Spacer(),
                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 24,
                                  child: Icon(FontAwesomeIcons.car,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                        snapshot.data!.status == "PENDING"
                            ? Center(
                              child: TextButton.icon(onPressed: (){
                                var dealer = snapshot.data!.dealer;
                                var vehicle = snapshot.data!.vehicle;
                                _orderService.updateStatus(widget.number)
                                .then((value) => {
                                  if(value["success"] == true){
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("La orden se completó!"))),
                                    
                                    _dealerService.addDealer(dealer.cui, dealer.name, dealer.surname, dealer.phone, dealer.license)
                                    .then((dealer) => {
                                      print(dealer),
                                      if(value["success"] == true){
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("El repartidor ahora está disponible")))
                                      }
                                    }),
                                    _vehicleService.addVehicle(vehicle.licensePlate, vehicle.brand, vehicle.model, vehicle.color, vehicle.year.toString())
                                    .then((vehicle) => {
                                      print(vehicle),
                                      if(value["success"] == true){
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("El vehículo fue puesto a disposición")))
                                      }
                                    }),
                                    setState((){

                                    }),
                                  }else{
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("La orden no se pudo completar."))),
                                  }
                                });
                                
                              }, 
                              icon: Icon(FontAwesomeIcons.check, color: Colors.green,), 
                              label: Text("Completar orden", style: GoogleFonts.dmSans(
                                fontSize: 18, color: Colors.green))),
                            )
                            : Center(
                              child: Text("Orden ya finalizada", style: GoogleFonts.dmSans(
                                fontSize: 18, fontWeight: FontWeight.bold)))
                      ],
                    ),
                  ),
                );
              } else {
                return Center(
                  child: Card(
                    elevation: 15,
                    child: Column(
                      children: [
                        Text("La orden no existe :(",
                            style: GoogleFonts.dmSans(
                                fontSize: 25, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                );
              }
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
        ));
  }
}
