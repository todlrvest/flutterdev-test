import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          // This is the theme of your application.
          primarySwatch: Colors.blue,
          textTheme: getTextTheme),
      home: Container(),
    );
  }

  TextTheme get getTextTheme => const TextTheme(
        headline1: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
          fontFamily: "TT Travels",
        ),
        headline2: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 26,
          fontFamily: "TT Travels",
        ),
        headline3: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          fontFamily: "TT Travels",
        ),
        headline4: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 10,
          fontFamily: "TT Travels",
        ),
        headline5: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          fontFamily: "TT Travels",
        ),
        headline6: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontFamily: "TT Travels",
        ),
        subtitle1: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          fontFamily: "TT Travels",
        ),
        subtitle2: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 8,
          fontFamily: "TT Travels",
        ),
        bodyText2: TextStyle(
          fontSize: 30,
          fontFamily: "TT Travels",
        ),
        bodyText1: TextStyle(
          fontSize: 12,
          fontFamily: "TT Travels",
        ),
      );
}
