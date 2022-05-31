import 'package:flutter/material.dart';
import 'package:todolist/part_A/siwoong/findID.dart';
import 'package:todolist/part_A/siwoong/resetPW.dart';

class FindMain extends StatefulWidget {
  const FindMain({Key? key}) : super(key: key);

  @override
  State<FindMain> createState() => _FindMainState();
}

class _FindMainState extends State<FindMain>
    with SingleTickerProviderStateMixin {
  // Property
  late TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FIND ID, PW"),
        toolbarHeight: 100,
        backgroundColor: const Color.fromARGB(255, 164, 154, 239),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: TabBarView(
          controller: controller,
          children: const [
            FindID(),
            ResetPW(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: const Color.fromARGB(255, 164, 154, 239),
        height: 60,
        child: TabBar(
          controller: controller,
          labelColor: Colors.white,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(
              text: 'ID 찾기',
            ),
            Tab(
              text: 'PW 찾기',
            ),
          ],
        ),
      ),
    );
  }
}
