import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todolist/part_A/siwoong/loginview.dart';
import 'package:todolist/part_C/UY/uy.dart';
import 'package:todolist/part_C/UY/write_page.dart';
import 'package:todolist/pwFind.dart';

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
        '/list': (context) => const FindPw(),
        '/write': (context) => const WritePage(),
      },
      initialRoute: '/list',
    );
  }
}
