import 'dart:convert';

import 'package:enlatadosmgapp/Service/ClientService.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:gviz/gviz.dart';

class ClientsReport extends StatefulWidget {
  const ClientsReport({Key? key}) : super(key: key);

  @override
  State<ClientsReport> createState() => _ClientsReportState();
}

class _ClientsReportState extends State<ClientsReport> {
  final ClientService _clientService = ClientService();
  String url = "";

  @override
  void initState() {
    super.initState();
    _clientService.getGraph().then((value) => {
          setState(() {
            url =
                'https://quickchart.io/graphviz?format=png&graph=${Uri.encodeQueryComponent(value["result"])}';
          }),
          print(url)
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reporte Árbol AVL de Clientes"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text(url)],
      ),
    );
  }
}
