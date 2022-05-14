import 'package:enlatadosmgapp/Models/Vehicle.dart';
import 'package:enlatadosmgapp/Screens/Vehicle/Create.dart';
import 'package:enlatadosmgapp/Service/VehicleService.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Vehicles extends StatefulWidget {
  const Vehicles({Key? key}) : super(key: key);

  @override
  State<Vehicles> createState() => _VehiclesState();
}

class _VehiclesState extends State<Vehicles> {
  VehicleService vehicleService = VehicleService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Vehículos"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateVehicle()),
          );
        },
        child: Icon(Icons.add),
      ),
      body: FutureBuilder<List<Vehicle>>(
          future: vehicleService.getVehicles(context),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Card(
                  child: Text("No existen"),
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Card(
                  color: Colors.red,
                  child: Text("Error al cargar la data :("),
                ),
              );
            } else {
              return Stack(children: [
                ListView.builder(
                    itemCount: snapshot.data.length,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      List<Vehicle> data = snapshot.data;
                      return SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Card(
                            color: Colors.white,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ListTile(
                                  onLongPress: () {
                                    showModalBottomSheet(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                        ),
                                        context: context,
                                        builder: (context) {
                                          return Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              SizedBox(height: 30),
                                              Text(
                                                  "Acciones disponibles para: \n" +
                                                      data[index].licensePlate,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 25,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                              SizedBox(height: 20),
                                              TextButton.icon(
                                                style: TextButton.styleFrom(
                                                    minimumSize:
                                                        const Size.fromHeight(
                                                            50),
                                                    backgroundColor:
                                                        Colors.blue,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .zero)),
                                                onPressed: () =>
                                                    {Navigator.pop(context)},
                                                icon: Icon(
                                                  Icons.edit,
                                                  color: Colors.white,
                                                ),
                                                label: Text(
                                                  'Editar',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                              TextButton.icon(
                                                style: TextButton.styleFrom(
                                                    minimumSize:
                                                        const Size.fromHeight(
                                                            50),
                                                    backgroundColor: Colors.red,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .zero)),
                                                onPressed: () =>
                                                    {Navigator.pop(context)},
                                                icon: Icon(
                                                  Icons.delete,
                                                  color: Colors.white,
                                                ),
                                                label: Text(
                                                  'Eliminar',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                              TextButton.icon(
                                                style: TextButton.styleFrom(
                                                    minimumSize:
                                                        const Size.fromHeight(
                                                            50),
                                                    backgroundColor:
                                                        Colors.green,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .zero)),
                                                onPressed: () =>
                                                    {Navigator.pop(context)},
                                                icon: Icon(
                                                  Icons.visibility,
                                                  color: Colors.white,
                                                ),
                                                label: Text(
                                                  'Ver',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                              //Divider(),
                                              TextButton.icon(
                                                style: TextButton.styleFrom(
                                                    minimumSize:
                                                        const Size.fromHeight(
                                                            50),
                                                    backgroundColor:
                                                        Colors.white,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .zero)),
                                                onPressed: () =>
                                                    {Navigator.pop(context)},
                                                icon: Icon(
                                                  Icons.close,
                                                  color: Colors.red,
                                                ),
                                                label: Text(
                                                  'Cancelar',
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                ),
                                              ),
                                            ],
                                          );
                                        });
                                  },
                                  leading: CircleAvatar(
                                    radius: 25.0,
                                    backgroundColor:
                                        Color(int.parse(data[index].color))
                                            .withOpacity(0.3),
                                    child: Icon(FontAwesomeIcons.carSide,
                                        color: Color(
                                            int.parse(data[index].color))),
                                  ),
                                  title: Text(data[index].licensePlate,
                                      style: TextStyle(fontSize: 18)),
                                  subtitle: Text(
                                    'Marca: ' +
                                        data[index].brand +
                                        "\nModelo: " +
                                        data[index].model,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            )),
                      );
                    }),
              ]);
            }
            return CircularProgressIndicator();
          }),
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
