import 'package:enlatadosmgapp/Screens/Auth/Login.dart';
import 'package:enlatadosmgapp/Screens/Client/Create.dart';
import 'package:enlatadosmgapp/Screens/Client/Update.dart';
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
        '/client/create': (context) => const CreateClient(),
      },
      theme: ThemeData(
          textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme),
          brightness: Brightness.light),
      darkTheme: ThemeData(
          brightness: Brightness.dark,
          textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme)),
      themeMode: ThemeMode.light,
    );
  }
}
