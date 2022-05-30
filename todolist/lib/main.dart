import 'package:flutter/material.dart';
import 'package:todolist/part_A/siwoong/loginview.dart';
import 'package:todolist/part_C/UY/uy.dart';

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

        // part_B

        // part_C
        '/list': (context) => const ListPage(),
      },
      initialRoute: '/list',
    );
  }
}
