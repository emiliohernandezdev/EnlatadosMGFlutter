import 'dart:ui';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:enlatadosmgapp/Models/Client.dart';
import 'package:enlatadosmgapp/Service/ClientService.dart';
import 'package:enlatadosmgapp/Service/DealerService.dart';
import 'package:enlatadosmgapp/Service/OrderService.dart';
import 'package:enlatadosmgapp/Service/VehicleService.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateOrder extends StatefulWidget {
  const CreateOrder({Key? key}) : super(key: key);

  @override
  State<CreateOrder> createState() => _CreateOrderState();
}

class _CreateOrderState extends State<CreateOrder> {
  TextEditingController originDepartController = TextEditingController();
  TextEditingController destDepartController = TextEditingController();
  TextEditingController startDateTimeController =
      TextEditingController(text: DateTime.now().toString());
  TextEditingController boxesController = TextEditingController();
  TextEditingController clientController = TextEditingController();
  TextEditingController vehicleController = TextEditingController();
  TextEditingController dealerController = TextEditingController();
  DealerService dealerService = DealerService();
  ClientService clientService = ClientService();
  VehicleService vehicleService = VehicleService();
  OrderService orderService = OrderService();
  List<Map<String, dynamic>> clients = [];
  List<Map<String, dynamic>> dealers = [];
  List<Map<String, dynamic>> vehicles = [];

  @override
  void initState() {
    clientService.getClients(context, "inOrder").then((value) => {
          value.forEach((element) {
            clients.add({
              'value': element.cui,
              'label': element.name + " " + element.surname
            });
          })
        });

    dealerService.getDealers(context).then((value) => {
          value.forEach((element) {
            dealers.add({
              'value': element.cui,
              'label': element.name + " " + element.surname
            });
          })
        });

    vehicleService.getVehicles(context).then((value) => {
          value.forEach((element) {
            vehicles.add({
              'value': element.licensePlate,
              'label': element.brand +
                  " " +
                  element.model +
                  " " +
                  element.year.toString()
            });
          })
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        BackgroundImage(image: 'assets/latas.jpg'),
        Scaffold(
          appBar: AppBar(
            title: Text("Agregar orden"),
            backgroundColor: Colors.transparent,
          ),
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: size.width * 0.1,
                ),
                Stack(
                  children: [
                    Center(
                      child: ClipOval(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                          child: CircleAvatar(
                            radius: size.width * 0.14,
                            backgroundColor: Colors.grey[400]!.withOpacity(
                              0.4,
                            ),
                            child: Icon(
                              FontAwesomeIcons.boxOpen,
                              color: Colors.white,
                              size: size.width * 0.1,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: size.height * 0.08,
                      left: size.width * 0.56,
                      child: Container(
                        height: size.width * 0.1,
                        width: size.width * 0.1,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: size.width * 0.1,
                ),
                Column(
                  children: [
                    TextInputField(
                      icon: FontAwesomeIcons.buildingCircleArrowRight,
                      hint: 'Depart. de origen',
                      inputType: TextInputType.text,
                      inputAction: TextInputAction.next,
                      controller: originDepartController,
                    ),
                    TextInputField(
                      icon: FontAwesomeIcons.buildingFlag,
                      hint: 'Depart. de destino',
                      inputType: TextInputType.text,
                      inputAction: TextInputAction.next,
                      controller: destDepartController,
                    ),
                    TextInputField(
                        icon: FontAwesomeIcons.boxesStacked,
                        hint: '# de cajas',
                        inputType: TextInputType.number,
                        controller: boxesController,
                        inputAction: TextInputAction.next),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Container(
                        height: size.height * 0.08,
                        width: size.width * 0.8,
                        decoration: BoxDecoration(
                          color: Colors.grey[500]!.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: DateTimePicker(
                            type: DateTimePickerType.dateTime,
                            use24HourFormat: true,
                            dateMask: 'd MMM yyyy',
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                            icon: Icon(Icons.event),
                            calendarTitle: "Seleccionar fecha",
                            cancelText: "Cancelar",
                            confirmText: "Aceptar",
                            controller: startDateTimeController,
                            fieldLabelText: "Fecha y hora",
                            dateLabelText: 'Fecha y hora de inicio',
                            timeLabelText: "Hora",
                            decoration: InputDecoration(
                                hintStyle: GoogleFonts.dmSans(
                                    color: Colors.white,
                                    decorationColor: Colors.white),
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Icon(
                                    FontAwesomeIcons.calendar,
                                    size: 28,
                                    color: Colors.white,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 5.0),
                                )),
                            onChanged: (val) => {
                              setState(() {
                                startDateTimeController.text = DateTime.parse(val).toIso8601String();
                              })
                            },
                            onSaved: (val) => {
                              setState(() {
                                startDateTimeController.text = DateTime.parse(val?? '').toIso8601String() ;
                              })
                            },
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Container(
                        height: size.height * 0.10,
                        width: size.width * 0.8,
                        decoration: BoxDecoration(
                          color: Colors.grey[500]!.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                            child: SelectFormField(
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: Icon(
                                        FontAwesomeIcons.userTie,
                                        size: 28,
                                        color: Colors.white,
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 5.0),
                                    ),
                                    hintText: "Seleccionar cliente",
                                    hintStyle: TextStyle(
                                        color: Colors.white,
                                        height: 1.5,
                                        fontSize: 22)),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 22),
                                type: SelectFormFieldType
                                    .dropdown, // or can be dialog
                                labelText: 'Seleccionar cliente',
                                items: clients,
                                controller: clientController)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Container(
                        height: size.height * 0.10,
                        width: size.width * 0.8,
                        decoration: BoxDecoration(
                          color: Colors.grey[500]!.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                            child: SelectFormField(
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: Icon(
                                        FontAwesomeIcons.car,
                                        size: 28,
                                        color: Colors.white,
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 5.0),
                                    ),
                                    hintText: "Seleccionar vehículo",
                                    hintStyle: TextStyle(
                                        color: Colors.white,
                                        height: 1.5,
                                        fontSize: 22)),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 22),
                                type: SelectFormFieldType
                                    .dropdown, // or can be dialog
                                labelText: 'Seleccionar vehículo',
                                items: vehicles,
                                controller: vehicleController)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Container(
                        height: size.height * 0.10,
                        width: size.width * 0.8,
                        decoration: BoxDecoration(
                          color: Colors.grey[500]!.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                            child: SelectFormField(
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: Icon(
                                        FontAwesomeIcons.peopleCarryBox,
                                        size: 28,
                                        color: Colors.white,
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 5.0),
                                    ),
                                    hintText: "Seleccionar repartidor",
                                    hintStyle: TextStyle(
                                        color: Colors.white,
                                        height: 1.5,
                                        fontSize: 22)),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 22),
                                type: SelectFormFieldType
                                    .dropdown, // or can be dialog
                                labelText: 'Seleccionar repartidor',
                                items: dealers,
                                controller: dealerController)),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      height: size.height * 0.08,
                      width: size.width * 0.8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.red,
                      ),
                      child: TextButton(
                        onPressed: () {
                          if (originDepartController.text.isNotEmpty &&
                              destDepartController.text.isNotEmpty &&
                              boxesController.text.isNotEmpty &&
                              startDateTimeController.text.isNotEmpty &&
                              clientController.text.isNotEmpty &&
                              vehicleController.text.isNotEmpty &&
                              dealerController.text.isNotEmpty) {
                                DateTime dtx = DateTime.parse(startDateTimeController.text);

                            orderService
                                .addOrder(
                                    originDepartController.text,
                                    destDepartController.text,
                                    dtx.toIso8601String(),
                                    vehicleController.text,
                                    clientController.text,
                                    dealerController.text,
                                    boxesController.text)
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
                                          print("error: " + value["success"]),
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(value["message"])))
                                        }
                                    });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    "Completa todos los campos de la orden")));
                          }
                        },
                        child: Text(
                          "Guardar",
                          style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                  height: 1.5)
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                )
              ],
            ),
          ),
        )
      ],
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

class TextInputField extends StatelessWidget {
  const TextInputField(
      {Key? key,
      required this.icon,
      required this.hint,
      this.inputType,
      this.inputAction,
      this.controller,
      this.minLines})
      : super(key: key);

  final IconData icon;
  final String hint;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final TextEditingController? controller;
  final int? minLines;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        height: size.height * 0.08,
        width: size.width * 0.8,
        decoration: BoxDecoration(
          color: Colors.grey[500]!.withOpacity(0.5),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: TextField(
            minLines: minLines,
            maxLines: 10,
            controller: controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Icon(
                  icon,
                  size: 28,
                  color: Colors.white,
                ),
              ),
              hintText: hint,
              hintStyle:
                  TextStyle(fontSize: 22, color: Colors.white, height: 1.5),
            ),
            style: TextStyle(fontSize: 22, color: Colors.white, height: 1.5),
            keyboardType: inputType,
            textInputAction: inputAction,
          ),
        ),
      ),
    );
  }
}

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    Key? key,
    required this.buttonName,
  }) : super(key: key);

  final String buttonName;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.08,
      width: size.width * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.blue,
      ),
      child: TextButton(
        onPressed: () {},
        child: Text(
          buttonName,
          style: TextStyle(fontSize: 22, color: Colors.white, height: 1.5)
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({
    Key? key,
    required this.image,
  }) : super(key: key);

  final String image;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (rect) => LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.center,
        colors: [Colors.black, Colors.transparent],
      ).createShader(rect),
      blendMode: BlendMode.darken,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
          ),
        ),
      ),
    );
  }
}
