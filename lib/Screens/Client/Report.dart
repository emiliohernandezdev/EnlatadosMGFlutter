import 'package:enlatadosmgapp/Service/ClientService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ClientsReport extends StatefulWidget {
  const ClientsReport({Key? key}) : super(key: key);

  @override
  State<ClientsReport> createState() => _ClientsReportState();
}

class _ClientsReportState extends State<ClientsReport> {
  final ClientService _clientService = ClientService();
  String graph = "";
  @override
  void initState() {
    super.initState();
    _clientService.getGraph().then((value) => {
          setState(() {
            graph = value;
          }),
          print(value)
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reporte Árbol AVL de Clientes"),
      ),
      body: WebView(
        initialUrl:
            'https://quickchart.io/graphviz?format=png&graph=${graph}',
        javascriptMode: JavascriptMode.unrestricted,
        onPageFinished: (String c){
          print(c);
        },
      ),
    );
  }
}
