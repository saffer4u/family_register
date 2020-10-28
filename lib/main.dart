import 'package:family_register/constents.dart';
import 'package:family_register/screens/about.dart';
import 'package:family_register/screens/dataEnter.dart';

import 'screens/homepage.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Family Register",
      theme: ThemeData(
        primaryColor: pcol,
      ),
      initialRoute: "/",
      routes: {
        "/": (ctx) => HomePage(),
        DataEnter.routeName: (ctx) => DataEnter(),
        AboutPage.routeName: (ctx) => AboutPage(),
      },
    );
  }
}
