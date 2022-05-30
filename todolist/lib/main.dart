import 'package:flutter/material.dart';
import 'package:todolist/part_A/siwoong/loginview.dart';
import 'package:todolist/part_B/YJ/drawer.dart';
import 'package:todolist/part_B/YJ/mypage.dart';

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
        '/drawer': (context) => const DrawerPage(),
        '/MyPage':(context) => const MyPage(),
        // part_C
      },
      initialRoute: '/drawer',
    );
  }
}