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
  bool checkValue = false;

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
        toolbarHeight: 200,
        backgroundColor: const Color.fromARGB(255, 164, 154, 239),
      ),
      body: Center(
          child: todolist.isEmpty
              ? const Text("데이터가 없습니다.")
              : ListView.builder(
                  itemCount: todolist.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        // Massage.code = data[index]['code'];
                        // Navigator.pushNamed(context, '/1st');

                        setState(() {
                          Navigator.pushNamed(context, '/modify')
                              .then((value) => getJSONData());
                          ListItem.code = todolist[index]['code'];
                          ListItem.content = todolist[index]['content'];
                        });
                      },
                      child: GestureDetector(
                        onLongPress: () {
                          // ListItem.code = todolist[index]['code'];
                          // ListItem.content = todolist[index]['content'];
                          // Navigator.pushNamed(context, '/modify')
                          //     .then((value) => getJSONData());
                        },
                        child: Card(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Row(
                                      children: [
                                        Checkbox(
                                          value: todolist[index]['check'] == '1'
                                              ? false
                                              : true,
                                          onChanged: (check) {
                                            setState(() {
                                              checkValue = check!;
                                            });
                                          },
                                        ),
                                        Text("content : "),
                                        Text(
                                          todolist[index]['content'],
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text("check : "),
                                          Text(
                                            todolist[index]['check'],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  })),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 164, 154, 239),
        child: const Icon(Icons.add),
        onPressed: () {
          //WritePage로 이동
          Navigator.pushNamed(context, "/write");
        },
      ),
    );
  }

  Future<bool> getJSONData() async {
    //비동기 함수 == 작업하면서 화면구성도 같이하겠다!
    //이럴땐 (주소) var를 많이 씀.
    todolist.clear();
    var url =
        Uri.parse("http://localhost:8080/Flutter/todolist_select_all.jsp");
    //http 가 위주소를 다가져옴 //await <- 빌드가 끝날때까지 일단 기다려
    var response = await http.get(url);

    /* 내가 알아보기 쉽게 변형해주기! */
    setState(() {
      //화면 구성이 바뀌니까 setState 사용!
      //body는 통째로 보여줘
      //한글해주는건 utf8.decode(response.bodyBytes)로 해야함!
      var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
      List result = dataConvertedJSON['results']; //results 키값!

      //print(result);
      //result[0]['code'] = S001 <- 리스트에 넣어준거 불러오는법

      //불러오고 수정한값을 이제 넣어주자!
      todolist.addAll(result);
      //print(data[0]['code']); //flutter: S001
    });

    //print(response.body);
    return true;
  }
}//end
