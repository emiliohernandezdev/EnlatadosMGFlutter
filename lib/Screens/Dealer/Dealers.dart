import 'package:enlatadosmgapp/Models/Dealer.dart';
import 'package:enlatadosmgapp/Screens/Dealer/Create.dart';
import 'package:enlatadosmgapp/Service/DealerService.dart';
import 'package:flutter/material.dart';

class Dealers extends StatefulWidget {
  const Dealers({Key? key}) : super(key: key);

  @override
  State<Dealers> createState() => _DealersState();
}

class _DealersState extends State<Dealers> {
  DealerService _dealerService = DealerService();
  List<Dealer> dealers = <Dealer>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Repartidores"),
          backgroundColor: Colors.black,
          actions: [
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                setState(() {
                  _dealerService.getDealers(context);
                });
              },
              tooltip: 'Actualizar',
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CreateDealer()),
            );
          },
          child: Icon(Icons.add),
          tooltip: 'Agregar repartidor',
        ),
        body: FutureBuilder<List<Dealer>>(
            future: _dealerService.getDealers(context),
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
                        List<Dealer> data = snapshot.data;
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
                                                      backgroundColor:
                                                          Colors.red,
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
                                    leading:
                                        Icon(Icons.person, color: Colors.blue),
                                    title: Text(
                                        data[index].name +
                                            " " +
                                            data[index].surname,
                                        style: TextStyle(fontSize: 18)),
                                    subtitle: Text(
                                      'Licencia tipo: ' +
                                          data[index].license +
                                          ". Teléfono: " +
                                          data[index].phone,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      TextButton(
                                        child: Text('Ocupado',
                                            style: TextStyle(fontSize: 16)),
                                        onPressed: () {/* ... */},
                                      ),
                                      SizedBox(width: 8),
                                    ],
                                  ),
                                ],
                              )),
                        );
                      }),
                  onRefresh: () async {},
                );
              }
              return CircularProgressIndicator();
            }));
  }
}
