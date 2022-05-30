import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

import 'package:todolist/part_C/UY/list_item.dart';

import '../../message.dart';
import '../../part_B/GS/myPage.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> 
    with SingleTickerProviderStateMixin {

  late List todolist;
  bool checkValue = false;
  bool trueyo = true;
  bool falseyo = false;
  late String result;

  late AnimationController _controller;
  late String id;
  late List data = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    todolist = [];
  _controller = AnimationController(vsync: this);
    id = Message.userid;
    getJSONData();
  }

   @override
  void dispose() {
    super.dispose();
    _controller.dispose();
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
            ? const Text(
                "데이터가 없습니다. \n 화면 우측하단의 + 버튼을 눌러 \n 당신의 ToDoList를 추가하세요.")
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
                    child: Card(
                      color: Colors.deepPurple[50],
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
                                      onChanged: (value) {
                                        setState(() {
                                          if (value == true) {
                                            todolist[index]['check'] = '0';

                                            updateCheckboxAction(index);
                                          } else {
                                            todolist[index]['check'] = '1';
                                            updateCheckboxAction(index);
                                          }
                                        });
                                      },
                                    ),
                                    todolist[index]['check'] == '0'
                                        ? Text(
                                            todolist[index]['content'],
                                            style: const TextStyle(
                                                color: Colors.grey),
                                          )
                                        : Text(
                                            todolist[index]['content'],
                                          )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ), //Lb
      ),
      drawer: Drawer(
        child: ListView(
          //패딩 없이 꽉 채우기
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              //상단에 이미지 넣기

              //이미지 밑에 이름 & 이메일
              accountName: Text('name'),
              accountEmail: Text('email@naver.com'),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 164, 154, 239),
                //테두리, 값을 각각 줄 수 있음. all 은 한번에 다 뜸
              ),
            ),

            // 리스트
            ListTile(
              onTap: () {
                setState(() {
                  getJSONDataDrawer();
                });

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((BuildContext context) => MyPage())));
              },
              leading: const Icon(
                Icons.home,
                color: Colors.deepPurple,
              ),
              title: const Text('My Page'),
            ),
          ],
        ),
      ), //Center,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 164, 154, 239),
        child: const Icon(Icons.add),
        onPressed: () {
          //WritePage로 이동
          Navigator.pushNamed(context, "/write").then((value) => getJSONData());
        },
      ),
    );
  }

  Future<bool> getJSONDataDrawer() async {
    // 비동기 방식 async : 동시에 실행되고
    var url = Uri.parse('http://localhost:8080/Flutter/user_query.jsp');
    var response = await http.get(url);
    // await, build가 data를 기다림
    // get 방식
    var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
    // body 자체로는 decode하지 못한다 : bodyBytes
    List result = dataConvertedJSON['results'];
    // 행렬의 형태로 result에 저장한다. [2,4]

    setState(() {
      data.addAll(result);
    });
    print(data);
    print(data[0]['pw']);
    return true;
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

  updateCheckboxAction(index) async {
    var url = Uri.parse(
        'http://localhost:8080/Flutter/todolist_update_checkBox.jsp?check=${todolist[index]['check']}&lCode=${todolist[index]['code']}');
    var response = await http.get(url);
    setState(() {
      var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
      result = dataConvertedJSON['result'];
    });
    if (result == 'OK') {
      _showDialog(context);
    } else {
      errorSnackBar(context);
    }
  }

  _showDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('수정 결과'),
            content: const Text('수정이 완료 되었습니다.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        });
  }

  errorSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('사용자 정보 입력에 문제가 발생 하였습니다.'),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      ),
    );
  }
}//end
