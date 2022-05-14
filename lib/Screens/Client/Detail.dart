import 'package:flutter/material.dart';

class ClientDetail extends StatefulWidget {
  const ClientDetail({Key? key}) : super(key: key);

  @override
  State<ClientDetail> createState() => _ClientDetailState();
}

class _ClientDetailState extends State<ClientDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerbox) => [
                SliverAppBar(
                  backgroundColor: Colors.red,
                  expandedHeight: 260,
                  flexibleSpace: FlexibleSpaceBar(
                    background:
                        Image.asset("assets/latas.jpg", fit: BoxFit.cover),
                  ),
                  floating: true,
                  elevation: 12.0,
                  pinned: true,
                  centerTitle: true,
                  title: Text("Clientes"),
                )
              ],
          body: Center()),
    );
  }
}
