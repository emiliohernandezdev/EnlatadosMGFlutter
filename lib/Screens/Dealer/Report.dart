import 'package:enlatadosmgapp/Service/DealerService.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DealersReport extends StatefulWidget {
  const DealersReport({Key? key}) : super(key: key);

  @override
  State<DealersReport> createState() => _DealersReportState();
}

class _DealersReportState extends State<DealersReport> {
  final DealerService _dealerService = DealerService();

  @override
  Widget build(BuildContext context) {
    String format = "png";

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Repartidores"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FutureBuilder<String>(
            future: _dealerService.getGraph(),
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
                      Text("Reporte de cola de repartidores", style: GoogleFonts.dmSans(fontSize: 25, color: Colors.black)),
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
