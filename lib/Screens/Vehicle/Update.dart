import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../Service/VehicleService.dart';
import 'Create.dart';
import 'Vehicles.dart';

class UpdateVehicle extends StatefulWidget {
  const UpdateVehicle({Key? key, required this.id}) : super(key: key);

  final String id;


  @override
  State<UpdateVehicle> createState() => _UpdateVehicleState();
}

class _UpdateVehicleState extends State<UpdateVehicle> {
  TextEditingController licensePlateController = TextEditingController();
  TextEditingController brandController = TextEditingController();
  TextEditingController modelController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  VehicleService vehicleService = VehicleService();

  String lastLicensePlate = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    vehicleService.getVehicle(widget.id).then((value) => {
        lastLicensePlate = value.licensePlate,
          licensePlateController.text = value.licensePlate,
          brandController.text = value.brand,
          modelController.text = value.model,
          colorController.text = value.color,
          yearController.text = value.year.toString()
        });
  }

  Color selectedColor = Colors.transparent;

  void _openDialog(String title, Widget content) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(6.0),
          title: Text(title),
          content: content,
          actions: [
            TextButton(
              child: Text('Cancelar'),
              onPressed: Navigator.of(context).pop,
            ),
            TextButton(
              child: Text('Aceptar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _openMainColorPicker() async {
    _openDialog(
      "Seleccionar color de carro:",
      MaterialColorPicker(
        selectedColor: selectedColor,
        allowShades: true,
        onColorChange: (Color color) =>
            setState(() => {selectedColor = color, print(color)}),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        BackgroundImage(image: 'assets/latas.jpg'),
        Scaffold(
          appBar: AppBar(
            title: Text("Editar veh??culo"),
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
                              FontAwesomeIcons.car,
                              color: selectedColor,
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
                      icon: FontAwesomeIcons.carRear,
                      hint: 'Placa',
                      inputType: TextInputType.text,
                      inputAction: TextInputAction.next,
                      controller: licensePlateController,
                    ),
                    TextInputField(
                      icon: FontAwesomeIcons.carRear,
                      hint: 'Marca',
                      inputType: TextInputType.text,
                      inputAction: TextInputAction.next,
                      controller: brandController,
                    ),
                    TextInputField(
                      icon: FontAwesomeIcons.carRear,
                      hint: 'Modelo',
                      inputType: TextInputType.text,
                      inputAction: TextInputAction.next,
                      controller: modelController,
                    ),
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
                            child: TextButton.icon(
                          icon: Icon(FontAwesomeIcons.palette,
                              color: Colors.white),
                          onPressed: _openMainColorPicker,
                          label: Text("Seleccionar color del veh??culo",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  height: 1.5)),
                        )),
                      ),
                    ),
                    TextInputField(
                      icon: FontAwesomeIcons.carRear,
                      hint: 'A??o',
                      inputType: TextInputType.number,
                      inputAction: TextInputAction.done,
                      controller: yearController,
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
                          if (licensePlateController.text.isNotEmpty &&
                              brandController.text.isNotEmpty &&
                              modelController.text.isNotEmpty &&
                              yearController.text.isNotEmpty) {
                            vehicleService
                                .updateVehicle(
                                    lastLicensePlate,
                                    licensePlateController.text,
                                    brandController.text,
                                    selectedColor.value.toString(),
                                    yearController.text,
                                    modelController.text
                                )
                                .then((v) => {
                                      if (v["success"] == true)
                                        {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text(v["message"]),
                                          )),
                                          Navigator.of(context).pop(),
                                        }
                                      else
                                        {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(v["message"])))
                                        }
                                    })
                                .catchError((err) => {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(err.toString())))
                                    });
                            print(selectedColor.value);
                          } else {}
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
