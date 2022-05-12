import 'package:enlatadosmgapp/Models/User.dart';
import 'package:enlatadosmgapp/Screens/User/Report.dart';
import 'package:enlatadosmgapp/Service/AuthService.dart';
import 'package:enlatadosmgapp/Service/StorageService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int id = 0;
  @override
  void initState() {
    _authService.getUserProfile(context)
    .then((value) => {
      _nameController.text = value["name"],
      _surnameController.text = value["surname"],
      _passwordController.text = value["password"]
    });
    super.initState();
  }

  AuthService _authService = AuthService();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _surnameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _authService.updateUser(context, id, _nameController.text, _surnameController.text, _passwordController.text)
            .then((value) => {
              print(value),
              if(value["success"] == true){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Datos de usuario actualizados.")))
              }else{
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error al actualizar los datos")))
              }
            });
          },
          child: Icon(FontAwesomeIcons.save),
          tooltip: 'Guardar datos',
        ),
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("Perfil del usuario"),
          actions: [
            IconButton(onPressed: (){
                Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => UsersReport()));
              }, icon: Icon(FontAwesomeIcons.diagramProject), tooltip: "Generar reporte de lista enlazada")
          ],
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          child: FutureBuilder(
              future: _authService.getUserProfile(context),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data != null && snapshot.data.length > 0) {
                    id = snapshot.data["id"];
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
                                      onBackgroundImageError: (e, c) => {},
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
                                        style:
                                            GoogleFonts.dmSans(fontSize: 16)),
                                    TextFormField(
                                      controller: _nameController,
                                    ),
                                    Divider(),
                                    Text("Apellido:",
                                        style:
                                            GoogleFonts.dmSans(fontSize: 16)),
                                    TextFormField(
                                      controller: _surnameController,
                                    ),
                                    Divider(),
                                    Text("Contraseña:",
                                        style:
                                            GoogleFonts.dmSans(fontSize: 16)),
                                    TextFormField(
                                      obscureText: true,
                                      controller: _passwordController,
                                    ),
                                  ],
                                ),
                              ),
                              Divider(),
                              Padding(
                                padding: EdgeInsets.all(24),
                                child: Column(
                                  
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    TextButton.icon(onPressed: (){
                                      showDialog(context: context, builder: (context){
                                        return AlertDialog(
                                          title: Text("¿Realmente deseas cerrar tu sesión?"),
                                          content: Text("Tendrás que volver a ingresat tus credenciales"),
                                          actions: [
                                            TextButton(onPressed: (){
                                              Navigator.of(context).pop();
                                            }, child: Text("Cancelar", style: GoogleFonts.dmSans(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue
                                            ))),
                                            TextButton(onPressed: () async{
                                              FlutterSecureStorage storage = FlutterSecureStorage();
                                              await storage.delete(key: "jwt");
                                              Navigator.of(context)
                                              .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
                                            }, child: Text("Si, cerrar", style: GoogleFonts.dmSans(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red
                                            )))
                                          ],
                                        );
                                      });
                                    }, icon: Icon(FontAwesomeIcons.arrowRightToBracket), label: Text("Cerrar sesión"))
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
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                    )
                  ],
                );
              }),
        ));
  }
}
