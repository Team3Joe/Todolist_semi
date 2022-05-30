import 'package:flutter/material.dart';
import 'package:todolist/part_A/siwoong/loginview.dart';

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
        '/login': (context) => const LoginView(),

        // part_B b

        // part_C
      },
      initialRoute: '/login',
    );
  }
}
