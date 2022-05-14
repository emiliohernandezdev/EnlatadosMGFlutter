import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../Service/ClientService.dart';

class UpdateClient extends StatefulWidget {
  const UpdateClient({Key? key, required this.id}) : super(key: key);

  final int id;

  @override
  State<UpdateClient> createState() => _UpdateClientState();
}

class _UpdateClientState extends State<UpdateClient> {
  TextEditingController cuiController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  ClientService clientService = ClientService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    clientService.getClient(widget.id).then((value) => {
          cuiController.text = value.cui,
          nameController.text = value.name,
          surnameController.text = value.surname,
          phoneController.text = value.phone,
          addressController.text = value.address
        });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        BackgroundImage(image: 'assets/latas.jpg'),
        Scaffold(
          appBar: AppBar(
            title: Text("Modificar datos de cliente"),
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
                              FontAwesomeIcons.userTie,
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
                      enabled: false,
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
                    TextAreaField(
                      icon: FontAwesomeIcons.mapLocationDot,
                      hint: 'Dirección',
                      inputAction: TextInputAction.newline,
                      inputType: TextInputType.multiline,
                      minLines: 1,
                      maxLines: 5,
                      controller: addressController,
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
                              addressController.text.isNotEmpty) {
                            clientService
                                .addClient(
                                    cuiController.text,
                                    nameController.text,
                                    surnameController.text,
                                    phoneController.text,
                                    addressController.text)
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
                                    'Completa toda la información del cliente.'),
                                elevation: 15,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        },
                        child: Text(
                          "Actualizar",
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

class TextAreaField extends StatelessWidget {
  const TextAreaField(
      {Key? key,
      required this.icon,
      required this.hint,
      this.inputType,
      this.inputAction,
      this.controller,
      this.minLines,
      this.maxLines})
      : super(key: key);

  final IconData icon;
  final String hint;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final TextEditingController? controller;
  final int? minLines;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        width: size.width * 0.8,
        decoration: BoxDecoration(
          color: Colors.grey[500]!.withOpacity(0.5),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
            child: Container(
          child: new ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 300.0),
            child: TextField(
              minLines: minLines,
              maxLines: maxLines,
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
        )),
      ),
    );
  }
}

class TextInputField extends StatelessWidget {
  const TextInputField(
      {Key? key,
      required this.icon,
      required this.hint,
      this.inputType,
      this.inputAction,
      this.controller,
      this.minLines,
      this.enabled})
      : super(key: key);

  final IconData icon;
  final String hint;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final TextEditingController? controller;
  final int? minLines;
  final bool? enabled;

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
            enabled: enabled,
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
