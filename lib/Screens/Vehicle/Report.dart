

import 'package:enlatadosmgapp/Service/VehicleService.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VehiclesReport extends StatefulWidget {
  const VehiclesReport({Key? key}) : super(key: key);

  @override
  State<VehiclesReport> createState() => _VehiclesReportState();
}

class _VehiclesReportState extends State<VehiclesReport> {
  final _vehicleService = VehicleService();
  @override
  Widget build(BuildContext context) {
    String format = "png";

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Vehículos"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FutureBuilder<String>(
            future: _vehicleService.getGraph(),
            builder: (
              BuildContext context,
              AsyncSnapshot<String> snapshot,
            ) {
              print(snapshot.connectionState);
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Text('Error al cargar el reporte.',
                      style:
                          GoogleFonts.dmSans(fontSize: 25, color: Colors.red));
                } else if (snapshot.hasData) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Reporte de cola de vehículos", style: GoogleFonts.dmSans(fontSize: 25, color: Colors.black), textAlign: TextAlign.center),
                      SizedBox(
                        height: 25,
                      ),
                      Center(
                          child: Image.network(
                              'https://quickchart.io/graphviz?format=${format}&graph=${snapshot.data}'))
                    ],
                  );
                } else {
                  return Text('El reporte no retornó data.',
                      style:
                          GoogleFonts.dmSans(fontSize: 25, color: Colors.red));
                }
              } else {
                return Text('State: ${snapshot.connectionState}');
              }
            },
          )
        ],
      ),
    );
  }
}