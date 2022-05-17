import 'package:enlatadosmgapp/Models/User.dart';
import 'package:enlatadosmgapp/Service/AuthService.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(FontAwesomeIcons.pen),
        tooltip: 'Editar perfil',
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
              title: Text("Perfil de usuario"))
        ],
        body: FutureBuilder(
            future: _authService.getUserProfile(context),
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
                                              "¿Seguro que deseas eliminar el cliente?"),
                                          actions: [
                                            FlatButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text("Cancelar")),
                                            FlatButton(
                                                onPressed: () {},
                                                child: Text("Eliminar",
                                                    style: TextStyle(
                                                        color: Colors.red)))
                                          ],
                                        );
                                      });
                                } else {}
                              },
                              child: Column(),
                            ),
                          );
                        }),
                    onRefresh: () async {
                      const snackBar = SnackBar(
                        content: Text('Registros actualizados'),
                      );
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
