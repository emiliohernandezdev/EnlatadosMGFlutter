import 'package:enlatadosmgapp/Screens/Client/Create.dart';
import 'package:enlatadosmgapp/Service/ClientService.dart';
import 'package:flutter/material.dart';

import '../../Models/Client.dart';

class Clients extends StatefulWidget {
  const Clients({Key? key}) : super(key: key);

  @override
  State<Clients> createState() => _ClientsState();
}

class _ClientsState extends State<Clients> {
  ClientService clientService = ClientService();
  String dropdownValue = "inOrder";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Clientes"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateClient()),
          );
        },
        tooltip: 'Agregar cliente',
      ),
      body: FutureBuilder<List<ClientM>>(
          future: clientService.getClients(context, "inOrder"),
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
              return RefreshIndicator(
                edgeOffset: 50,
                triggerMode: RefreshIndicatorTriggerMode.anywhere,
                child: ListView.builder(
                    itemCount: snapshot.data.length,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      List<ClientM> data = snapshot.data;
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
                                                      data[index].name +
                                                      " " +
                                                      data[index].surname,
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
                                  leading: Icon(Icons.hail, color: Colors.blue),
                                  title: Text(
                                      data[index].name +
                                          " " +
                                          data[index].surname,
                                      style: TextStyle(fontSize: 18)),
                                  subtitle: Text(
                                    'Dirección: ' +
                                        data[index].address +
                                        "\nTeléfono: " +
                                        data[index].phone,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            )),
                      );
                    }),
                onRefresh: () async {},
              );
            }
            return CircularProgressIndicator();
          }),
    );
  }
}
