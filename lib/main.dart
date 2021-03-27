import 'package:buyit/screens/addProfuct.dart';
import 'package:buyit/screens/adminHome.dart';
import 'package:buyit/screens/edit_product.dart';
import 'package:buyit/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:buyit/screens/login_screen.dart';
import 'package:buyit/screens/signup_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: 'LoginScreen',
        routes: {
          'LoginScreen': (context) => LoginScreen(),
          'SignupScreen': (context) => Signup(),
          'adminHome': (context) => AdminHome(),
          'home': (context) => Home(),
          'addProduct': (context) => AddProduct(),
          'editProduct': (context) => EditProduct(),
        },
        title: 'Flutter Demo',
        home: Scaffold());
  }
}
