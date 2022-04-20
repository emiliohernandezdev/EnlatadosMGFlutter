import 'dart:convert';

import 'package:enlatadosmgapp/Service/ClientService.dart';
import 'package:enlatadosmgapp/Service/DealerService.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:select_form_field/select_form_field.dart';

class CreateDealer extends StatefulWidget {
  const CreateDealer({Key? key}) : super(key: key);

  @override
  State<CreateDealer> createState() => _CreateDealerState();
}

class _CreateDealerState extends State<CreateDealer> {
  TextEditingController cuiController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController licenseController = TextEditingController(text: "A");
  TextEditingController phoneController = TextEditingController();
  DealerService dealerService = DealerService();
  final List<Map<String, dynamic>> _licenses = [
    {
      'value': 'A',
      'label': 'Licencia tipo A',
    },
    {
      'value': 'B',
      'label': 'Licencia tipo B',
    },
    {
      'value': 'C',
      'label': 'Licencia tipo C',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Agregar repartidor"),
        backgroundColor: Colors.black,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        "Ingresa los datos del repartidor:",
                        style: TextStyle(fontSize: 25, color: Colors.grey[700]),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: <Widget>[
                        makeInput(
                            label: "CUI",
                            keyboardType: TextInputType.number,
                            controller: cuiController),
                        makeInput(label: "Nombre", controller: nameController),
                        makeInput(
                            label: "Apellido", controller: surnameController),
                        IntlPhoneField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          invalidNumberMessage: 'Teléfono no válido',
                          initialCountryCode: 'GT',
                          decoration: InputDecoration(
                            labelText: 'Número de teléfono',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(),
                            ),
                          ),
                        ),
                        SelectFormField(
                          decoration: InputDecoration(
                            labelText: 'Tipo de licencia',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(),
                            ),
                          ),
                          type:
                              SelectFormFieldType.dropdown, // or can be dialog
                          icon: Icon(Icons.credit_card_rounded),
                          labelText: 'Seleccionar tipo de licencia',
                          items: _licenses,
                          controller: licenseController,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Container(
                      padding: EdgeInsets.only(top: 3, left: 3),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border(
                            bottom: BorderSide(color: Colors.black),
                            top: BorderSide(color: Colors.black),
                            left: BorderSide(color: Colors.black),
                            right: BorderSide(color: Colors.black),
                          )),
                      child: MaterialButton(
                        minWidth: double.infinity,
                        height: 60,
                        onPressed: () {
                          if (cuiController.text.isNotEmpty &&
                              nameController.text.isNotEmpty &&
                              surnameController.text.isNotEmpty &&
                              phoneController.text.isNotEmpty &&
                              licenseController.text.isNotEmpty) {
                            dealerService
                                .addDealer(
                                    cuiController.text,
                                    nameController.text,
                                    surnameController.text,
                                    phoneController.text,
                                    licenseController.text)
                                .then((value) => {
                                      if (value["success"] == true)
                                        {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text(value["message"]),
                                          )),
                                          Navigator.of(context).pop(),
                                        }
                                      else
                                        {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content:
                                                      Text(value["message"])))
                                        }
                                    });
                          } else {
                            const snackBar = SnackBar(
                                content: Text(
                                    'Completa toda la información del repartidor.'),
                                elevation: 15,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        },
                        color: Colors.red,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        child: Text(
                          "Guardar",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget makeInput(
    {label,
    obscureText = false,
    keyboardType = TextInputType.name,
    controller}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        label,
        style: TextStyle(
            fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
      ),
      SizedBox(
        height: 5,
      ),
      TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black))),
      ),
      SizedBox(
        height: 30,
      ),
    ],
  );
}
