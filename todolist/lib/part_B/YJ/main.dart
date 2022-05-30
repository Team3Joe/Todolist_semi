import 'package:flutter/material.dart';
import 'package:todolist/part_B/YJ/delete.dart';
import 'package:todolist/part_B/YJ/home.dart';
import 'package:todolist/part_B/YJ/update.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     routes: {
        '/home' :(context) => const Home(),
        '/update' :(context) => const Update(),
        '/delete' :(context) => const Delete(),
      },
      initialRoute: '/',
    );
  }
}

