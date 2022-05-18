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
        child: Icon(FontAwesomeIcons.pen),
        tooltip: 'Editar perfil',
      ),
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerbox) => [
          SliverAppBar(
              backgroundColor: Colors.red,
              expandedHeight: 150,
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  background:
                      Image.asset("assets/latas.jpg", fit: BoxFit.cover)),
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
                if (snapshot.data != null && snapshot.data.length > 0) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Perfil"),
                      CircleAvatar(
                        backgroundColor: Colors.blue,
                        child: Text("EH"),
                        radius: 75,
                      )
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
      ),
    );
  }
}
