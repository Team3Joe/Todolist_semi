import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todolist/part_B/YJ/message.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Property
  late List data;

  @override
  void initState() {
    super.initState();
    data = [];
    // data 가져오기
    getJSONData(); // 함수 만들기
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('JSON Test'),
        actions: [
          IconButton(
            onPressed: () {
             
            },
            icon: const Icon(
              Icons.add,
            ),
          ),
        ],
      ),
      body: Center(
          child: data.isEmpty
              ? const Text('데이터가 없습니다.')
              : ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Message.userid = data[index]['id'];
                        Message.userpw = data[index]['pw'];
                        Message.userphone = data[index]['phone'];
                        Message.useremail = data[index]['email'];
                        Message.userbirth = data[index]['birth'];
                        Navigator.pushNamed(context, '/update')
                            .then((value) => getJSONData());
                      },
                      onLongPress: () {
                        Message.userid = data[index]['id'];
                        Message.userpw = data[index]['pw'];
                        Message.userphone = data[index]['phone'];
                        Message.useremail = data[index]['email'];
                        Message.userbirth = data[index]['birth'];
                        Navigator.pushNamed(context, '/delete')
                            .then((value) => getJSONData());
                      },
                      child: Card(
                        color: Colors.amberAccent,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Text(
                                  'ID :',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  data[index]['id'],
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                const Text(
                                  'PW :',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  data[index]['pw'],
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                const Text(
                                  'PHONE :',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  data[index]['phone'],
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                const Text(
                                  'EMAIL :',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  data[index]['email'],
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                const Text(
                                  'BIRTH :',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  data[index]['birth'],
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      ),
                    );
                  })),
    );
  }

  // Functions
  Future<bool> getJSONData() async {
    // 비동기 방식 async : 동시에 실행되고
    data.clear();
    var url =
        Uri.parse('http://localhost:8080/Flutter/user_query.jsp');
    var response = await http.get(url); // await, build가 data를 기다림

    setState(() {
      var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
      List result = dataConvertedJSON['results'];
      data.addAll(result); // list 한번에 다 넣을거야
    });

    return true;
  }
}
