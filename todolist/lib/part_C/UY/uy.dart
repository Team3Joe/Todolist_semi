import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:todolist/part_C/UY/list_item.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  late List todolist;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    todolist = [];
    getJSONData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TO DO LIST"),
        toolbarHeight: 230,
        backgroundColor: const Color.fromARGB(255, 164, 154, 239),
      ),
      body: Center(
        child: Column(
          children: [
            ListView.builder(
                // list가 있는만큼 만들어주는애

                itemCount: todolist.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      //actionKind(context, position);
                    },
                    child: Card(
                      child: Row(
                        children: [
                          Text(todolist[index]['check']),
                          Text(todolist[index]['content']),
                        ],
                      ),
                    ),
                  );
                })
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 164, 154, 239),
        child: const Icon(Icons.add),
        onPressed: () {
          // 추가페이지이동
          Navigator.pushNamed(context, '/write');
        },
      ),
    );
  }

  Future<bool> getJSONData() async {
    todolist.clear();
    var url =
        Uri.parse("http://localhost:8080/Flutter/todolist_select_all.jsp");
    var response = await http.get(url);

    /* 내가 알아보기 쉽게 변형해주기! */
    setState(() {
      var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
      List result = dataConvertedJSON['results']; //results 키값!

      todolist.addAll(result);
      print(todolist[0]['code']);
    });

    return true;
  }
}//end
