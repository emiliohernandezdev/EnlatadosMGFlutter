

import 'package:enlatadosmgapp/Service/AuthService.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UsersReport extends StatefulWidget {
  const UsersReport({Key? key}) : super(key: key);

  @override
  State<UsersReport> createState() => _UsersReportState();
}

class _UsersReportState extends State<UsersReport> {
  final _userService = AuthService();
  @override
  Widget build(BuildContext context) {
    String format = "png";

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Usuarios"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FutureBuilder<String>(
            future: _userService.getGraph(),
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
                      Text("Reporte de lista enlazada de usuarios", style: GoogleFonts.dmSans(fontSize: 25, color: Colors.black), textAlign: TextAlign.center),
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