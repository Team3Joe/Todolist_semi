import 'package:flutter/material.dart';
import 'package:todolist/part_A/SM/signin.dart';
import 'package:todolist/part_A/siwoong/findMain.dart';
import 'package:todolist/part_A/siwoong/loginview.dart';
import 'package:todolist/part_C/UY/modify_page.dart';
import 'package:todolist/part_C/UY/uy.dart';
import 'package:todolist/part_C/UY/write_page.dart';

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
        '/signin': (context) => const Signin(),
        '/find': (context) => const FindMain(),

        // part_B
        // 가슬님것 시작부분 까지만 제가(시웅) 해놓고 나머지는 채워주세요

        // part_C
        '/list': (context) => const ListPage(),
        '/write': (context) => const WritePage(),
        '/modify': (context) => const ModifyPage(),
      },
      initialRoute: '/login',
    );
  }
}
