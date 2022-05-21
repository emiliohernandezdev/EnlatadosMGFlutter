import 'package:enlatadosmgapp/Models/Dealer.dart';
import 'package:enlatadosmgapp/Screens/Dealer/Create.dart';
import 'package:enlatadosmgapp/Screens/Dealer/Report.dart';
import 'package:enlatadosmgapp/Screens/Dealer/Update.dart';
import 'package:enlatadosmgapp/Service/DealerService.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;

class Dealers extends StatefulWidget {
  const Dealers({Key? key}) : super(key: key);

  @override
  State<Dealers> createState() => _DealersState();
}

class _DealersState extends State<Dealers> {
  DealerService _dealerService = DealerService();
  List<Dealer> dealers = <Dealer>[];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  String toShortName(String nm, String sr) {
    var name = nm.split("");
    var surname = sr.split("");

    var result = name[0] + surname[0];

    return result.toString();
  }

  @override
  Widget build(BuildContext context) {
    List<Dealer> data = [];
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/dealer/create')
              .then((value) => setState(() {
                    _dealerService
                        .getDealers(context)
                        .then((value) => {data = value});
                  }));
        },
        tooltip: 'Agregar repartidor',
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
            title: Text("Repartidores"),
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
        body: FutureBuilder<List<Dealer>>(
            future: _dealerService.getDealers(context),
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
                                              "¿Seguro que deseas eliminar el repartidor?"),
                                          actions: [
                                            FlatButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text("Cancelar")),
                                            FlatButton(
                                                onPressed: () {
                                                  _dealerService
                                                      .deleteDealer(int.parse(
                                                          data[index].cui))
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
                                                                  _dealerService
                                                                      .getDealers(
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
                                          builder: (context) => UpdateDealer(
                                              id: int.parse(data[index]
                                                  .cui)))).then((value) => {
                                        setState(() {
                                          _dealerService
                                              .getDealers(context)
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
                                                              "Detalle de repartidor:",
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
                                                                  child: Text(
                                                                      toShortName(
                                                                          data[index]
                                                                              .name,
                                                                          data[index]
                                                                              .surname),
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.white)),
                                                                ),
                                                                title: Wrap(
                                                                  children: [
                                                                    Text(
                                                                        "Nombre: ",
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontSize: 19.0)),
                                                                    Text(
                                                                        data[index].name +
                                                                            " " +
                                                                            data[index]
                                                                                .surname,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                19.0))
                                                                  ],
                                                                ),
                                                                subtitle: Wrap(
                                                                  children: [
                                                                    Text(
                                                                        "Licencia tipo: ",
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontSize: 19.0)),
                                                                    Text(
                                                                        data[index]
                                                                            .license,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                19.0)),
                                                                    Text(
                                                                        "Teléfono: ",
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontSize: 19.0)),
                                                                    Text(
                                                                        data[index]
                                                                            .phone,
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
                                                  (math.Random().nextDouble() *
                                                          0xFFFFFF)
                                                      .toInt())
                                              .withOpacity(1.0),
                                          child: Text(
                                              toShortName(data[index].name,
                                                  data[index].surname),
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ),
                                        title: Text(
                                            data[index].name +
                                                " " +
                                                data[index].surname,
                                            style: TextStyle(fontSize: 18)),
                                        subtitle: Text(
                                          "Teléfono: " + data[index].phone,
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

                      _dealerService
                          .getDealers(context)
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
