import 'package:enlatadosmgapp/Screens/Auth/Login.dart';
import 'package:enlatadosmgapp/Screens/Client/Create.dart';
import 'package:enlatadosmgapp/Screens/Dealer/Create.dart';
import 'package:enlatadosmgapp/Screens/Order/Create.dart';
import 'package:enlatadosmgapp/Screens/User/Profile.dart';
import 'package:enlatadosmgapp/Screens/Vehicle/Create.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Screens/Welcome/Welcome.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Enlatados MG',
      home: WelcomeScreen(),
      routes: {
        '/login': ((context) => const Login()),
        '/order/create': ((context) => const CreateOrder()),
        '/user/profile': ((context) => const ProfilePage()),
        '/client/create': (context) => const CreateClient(),
        '/dealer/create': ((context) => const CreateDealer()),
        '/vehicle/create': ((context) => const CreateVehicle()),
      },
      theme: ThemeData(
          primarySwatch: Colors.red,
          textTheme: GoogleFonts.dmSansTextTheme(Theme.of(context).textTheme),
          brightness: Brightness.light),
      darkTheme: ThemeData(
          brightness: Brightness.dark,
          textTheme: GoogleFonts.dmSansTextTheme(Theme.of(context).textTheme)),
      themeMode: ThemeMode.light,
    );
  }
}
