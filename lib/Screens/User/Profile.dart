import 'package:enlatadosmgapp/Models/User.dart';
import 'package:enlatadosmgapp/Service/AuthService.dart';
import 'package:enlatadosmgapp/Service/StorageService.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(FontAwesomeIcons.save),
          tooltip: 'Guardar datos',
        ),
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("Perfil del usuario"),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          child: FutureBuilder(
              future: _authService.getUserProfile(context),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data != null && snapshot.data.length > 0) {
                    print(snapshot.data);
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Card(
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 25),
                                child: Center(
                                  child: CircleAvatar(
                                      backgroundColor: Colors.blue,
                                      backgroundImage: NetworkImage(
                                          "https://imgs.search.brave.com/W-a8jTNwC_Xtpx85doTKNJng7qhB-nTQLJFoKNo_u2A/rs:fit:1200:1200:1/g:ce/aHR0cDovL3BsdXNw/bmcuY29tL2ltZy1w/bmcvdXNlci1wbmct/aWNvbi1kb3dubG9h/ZC1pY29ucy1sb2dv/cy1lbW9qaXMtdXNl/cnMtMjI0MC5wbmc"),
                                      radius: 75),
                                ),
                              ),
                              Text("Información personal",
                                  style: GoogleFonts.dmSans(fontSize: 25)),
                              Divider(),
                              Text('ID: ${snapshot.data["id"]}',
                                  style: GoogleFonts.dmSans(fontSize: 25)),
                              Padding(
                                padding: EdgeInsets.all(24),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text("Nombre:",
                                    textAlign: TextAlign.left,
                                  style: GoogleFonts.dmSans(fontSize: 16)),
                                    TextFormField(
                                      initialValue: snapshot.data["name"],
                                    ),
                                    Divider(),
                                    Text("Apellido:",
                                  style: GoogleFonts.dmSans(fontSize: 16)),
                                  TextFormField(
                                      initialValue: snapshot.data["surname"],
                                    ),
                                    Divider(),
                                    Text("Contraseña:",
                                  style: GoogleFonts.dmSans(fontSize: 16)),
                                  TextFormField(
                                      initialValue: snapshot.data["password"],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Sin datos del usuario",
                            style: GoogleFonts.dmSans(fontSize: 28.0))
                      ],
                    );
                  }
                }
                return CircularProgressIndicator();
              }),
        ));
  }
}
