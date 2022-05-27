import 'package:flutter/material.dart';
import 'package:semi_todolist/part_A/firstPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     routes: {
      // part_A
       '/' : (context) => const FirstPage(),   //첫화면

      // part_B


      // part_C
     },
     
     initialRoute: '/',
    );
  }
}
