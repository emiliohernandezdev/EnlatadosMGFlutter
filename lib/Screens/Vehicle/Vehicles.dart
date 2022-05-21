import 'package:enlatadosmgapp/Models/Vehicle.dart';
import 'package:enlatadosmgapp/Screens/Vehicle/Create.dart';
import 'package:enlatadosmgapp/Screens/Vehicle/Report.dart';
import 'package:enlatadosmgapp/Screens/Vehicle/Update.dart';
import 'package:enlatadosmgapp/Service/VehicleService.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;

class Vehicles extends StatefulWidget {
  const Vehicles({Key? key}) : super(key: key);

  @override
  State<Vehicles> createState() => _VehiclesState();
}

class _VehiclesState extends State<Vehicles> {
  VehicleService vehicleService = VehicleService();
  @override
  Widget build(BuildContext context) {
    List<Vehicle> data = [];
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/vehicle/create')
              .then((value) => setState(() {}));
        },
        tooltip: 'Agregar vehículo',
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
            title: Text("Vehículos"),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VehiclesReport()));
                  },
                  icon: Icon(FontAwesomeIcons.diagramProject),
                  tooltip: "Generar reporte de cola de vehículos")
            ],
          )
        ],
        body: FutureBuilder<List<Vehicle>>(
            future: vehicleService.getVehicles(context),
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
                              key: UniqueKey(),
                              background: Container(
                                  color: Colors.blue,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  alignment: Alignment.centerRight,
                                  child: Row(
                                    children: [
                                      const Icon(FontAwesomeIcons.pencil,
                                          color: Colors.white),
                                      SizedBox(width: 8.0),
                                      Text("Editar",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 19.0))
                                    ],
                                  )),
                              secondaryBackground: Container(
                                  color: Colors.red,
                                  alignment: Alignment.centerRight,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      const Icon(FontAwesomeIcons.trash,
                                          color: Colors.white),
                                      SizedBox(width: 8.0),
                                      Text("Eliminar",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 19.0))
                                    ],
                                  )),
                              confirmDismiss: (direction) async {
                                if (direction == DismissDirection.endToStart) {
                                  await showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          content: Text(
                                              "¿Seguro que deseas eliminar el vehículo?"),
                                          actions: [
                                            FlatButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text("Cancelar")),
                                            FlatButton(
                                                onPressed: () {
                                                  vehicleService
                                                      .deleteVehicle(
                                                          data[index]
                                                              .licensePlate.toString())
                                                      .then((value) => {
                                                            if (value[
                                                                    "success"] ==
                                                                true)
                                                              {
                                                                data.removeAt(
                                                                    index),
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                        SnackBar(
                                                                  content: Text(
                                                                      value[
                                                                          "message"]),
                                                                )),
                                                                Navigator.of(
                                                                        context)
                                                                    .pop(),
                                                                setState(() {
                                                                  vehicleService
                                                                      .getVehicles(
                                                                          context)
                                                                      .then(
                                                                          (value) =>
                                                                              {
                                                                                data = value
                                                                              });
                                                                })
                                                              }
                                                            else
                                                              {
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(SnackBar(
                                                                        content:
                                                                            Text(value["message"])))
                                                              }
                                                          })
                                                      .catchError((err) =>
                                                          {print(err)});
                                                },
                                                child: Text("Eliminar",
                                                    style: TextStyle(
                                                        color: Colors.red)))
                                          ],
                                        );
                                      });
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => UpdateVehicle(
                                              id: data[index]
                                                  .licensePlate.toString()))).then((value) => {
                                        setState(() {
                                          vehicleService
                                              .getVehicles(context)
                                              .then((res) => {data = res});
                                        })
                                      });
                                }
                              },
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
                                                              "Detalle del vehículo:",
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
                                                            children: <Widget>[
                                                              Divider(),
                                                              ListTile(
                                                                leading:
                                                                    CircleAvatar(
                                                                  radius: 35.0,
                                                                  backgroundColor: Color((math.Random().nextDouble() *
                                                                              0xFFFFFF)
                                                                          .toInt())
                                                                      .withOpacity(
                                                                          1.0),
                                                                  child: Icon(
                                                                      FontAwesomeIcons
                                                                          .car,
                                                                      color: Color(
                                                                          int.parse(
                                                                              data[index].color))),
                                                                ),
                                                                title: Wrap(
                                                                  children: [
                                                                    Text(
                                                                        "Placa: ",
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontSize: 19.0)),
                                                                    Text(
                                                                        data[index]
                                                                            .licensePlate,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                19.0))
                                                                  ],
                                                                ),
                                                                subtitle: Wrap(
                                                                  children: [
                                                                    Text(
                                                                        "Marca: ",
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontSize: 19.0)),
                                                                    Text(
                                                                        data[index]
                                                                            .brand,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                19.0)),
                                                                    Text(
                                                                        "Modelo: ",
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontSize: 19.0)),
                                                                    Text(
                                                                        data[index]
                                                                            .model,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                19.0)),
                                                                  ],
                                                                ),
                                                                isThreeLine:
                                                                    true,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        actions: [
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
                                          backgroundColor: Color(
                                              (int.parse(data[index].color))),
                                          child: Icon(FontAwesomeIcons.car,
                                              color: Colors.black),
                                        ),
                                        title: Text(data[index].licensePlate,
                                            style: TextStyle(fontSize: 18)),
                                        subtitle: Text(
                                          "Marca: " + data[index].brand,
                                          style: TextStyle(fontSize: 16),
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

                      vehicleService
                          .getVehicles(context)
                          .then((value) => setState(() {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                                data = value;
                              }))
                          .catchError((err) => {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(content: Text(err))),
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
            }),
      ),
    );
  }
}

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({
    Key? key,
    required this.image,
  }) : super(key: key);

  final String image;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (rect) => LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.center,
        colors: [Colors.black, Colors.transparent],
      ).createShader(rect),
      blendMode: BlendMode.darken,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
          ),
        ),
      ),
    );
  }
}
