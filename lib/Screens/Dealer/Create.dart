import 'dart:ui';

import 'package:enlatadosmgapp/Service/ClientService.dart';
import 'package:enlatadosmgapp/Service/DealerService.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
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
  TextEditingController phoneController = TextEditingController();
  TextEditingController licenseController = TextEditingController();
  DealerService dealerService = DealerService();
  var _key = new GlobalKey<ScaffoldState>();

  final List<Map<String, dynamic>> _licenses = [
    {
      'value': 'A',
      'label': 'Licencia tipo A',
    },
    {'value': 'B', 'label': 'Licencia tipo B'},
    {'value': 'C', 'label': 'Licencia tipo C'},
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        BackgroundImage(image: 'assets/latas.jpg'),
        Scaffold(
          appBar: AppBar(
            title: Text("Agregar repartidor"),
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
                              FontAwesomeIcons.truckFast,
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
                      icon: FontAwesomeIcons.idCard,
                      hint: 'CUI',
                      inputType: TextInputType.number,
                      inputAction: TextInputAction.next,
                      controller: cuiController,
                    ),
                    TextInputField(
                      icon: FontAwesomeIcons.user,
                      hint: 'Nombre',
                      inputType: TextInputType.text,
                      inputAction: TextInputAction.next,
                      controller: nameController,
                    ),
                    TextInputField(
                      icon: FontAwesomeIcons.user,
                      hint: 'Apellido',
                      inputType: TextInputType.text,
                      inputAction: TextInputAction.next,
                      controller: surnameController,
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
                            child: SelectFormField(
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: Icon(
                                        FontAwesomeIcons.idCard,
                                        size: 28,
                                        color: Colors.white,
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 5.0),
                                    ),
                                    hintText: "Tipo de licencia",
                                    hintStyle: TextStyle(
                                        color: Colors.white,
                                        height: 1.5,
                                        fontSize: 22)),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 22),
                                type: SelectFormFieldType
                                    .dropdown, // or can be dialog
                                labelText: 'Seleccionar tipo de licencia',
                                items: _licenses,
                                controller: licenseController)),
                      ),
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
                          child: IntlPhoneField(
                            controller: phoneController,
                            dropdownTextStyle:
                                TextStyle(color: Colors.white, fontSize: 22),
                            searchText: "Buscar país",
                            style: TextStyle(color: Colors.white, fontSize: 22),
                            initialCountryCode: 'GT',
                            invalidNumberMessage: "Número de teléfono inválido",
                            disableLengthCheck: true,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "1234-5678",
                              hintStyle: TextStyle(
                                  color: Colors.white,
                                  height: 1.5,
                                  fontSize: 22),
                            ),
                            textInputAction: TextInputAction.next,
                            dropdownIconPosition: IconPosition.leading,
                            keyboardType: TextInputType.phone,
                          ),
                        ),
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
