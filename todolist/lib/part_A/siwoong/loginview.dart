import 'dart:convert';

import 'package:flutter/material.dart';
//import 'package:http/http.dart' as http;

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  // Property
  late TextEditingController uId;
  late TextEditingController uPw;
  late String userID;
  late String userPW;

  late List data;

  @override
  void initState() {
    super.initState();
    uId = TextEditingController();
    uPw = TextEditingController();
    userID = '';
    userPW = '';

    data = [];
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("TO DO LIST"),
          toolbarHeight: 230,
          backgroundColor: const Color.fromARGB(255, 164, 154, 239),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  const Icon(
                    Icons.emoji_people_sharp,
                    size: 120,
                    color: Color.fromARGB(255, 164, 154, 239),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    controller: uId,
                    decoration: const InputDecoration(labelText: 'ID를 입력하세요.'),
                    keyboardType: TextInputType.text,
                    onChanged: (value) {},
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: uPw,
                    decoration: const InputDecoration(labelText: 'PW를 입력하세요.'),
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    onChanged: (value) {},
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromARGB(255, 164, 154, 239),
                    ),
                    onPressed: () {
                      if (uId.text.trim().isEmpty) {
                        emptyID(context);
                      } else if (uPw.text.trim().isEmpty) {
                        emptyPW(context);
                      } else {
                        setState(() {
                          userID = uId.text.trim();
                          userPW = uPw.text.trim();
                        });
                        getJSONData();
                        // data 오류
                        print(data);
                        logInCheck(context);
                      }
                    },
                    child: const Text('Log in'),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('아직 회원이 아니신가요?'),
                      TextButton(
                        onPressed: () {
                          // Navigator.pushNamed(context, '/signin');
                        },
                        child: const Text('회원가입 하기'),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('아직 회원이 아니신가요?'),
                      TextButton(
                        onPressed: () {
                          // Navigator.pushNamed(context, '/signin');
                        },
                        child: const Text('회원가입 하기'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Functions
  emptyID(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('ID를 입력하세요.'),
        duration: Duration(seconds: 1),
        backgroundColor: Colors.red,
      ),
    );
  }

  emptyPW(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('PW를 입력하세요.'),
        duration: Duration(seconds: 1),
        backgroundColor: Colors.red,
      ),
    );
  }

  Future<bool> getJSONData() async {
    // 비동기 방식 async : 동시에 실행되고
    var url = Uri.parse(
        'http://localhost:8080/flutter/todolist_semi/todolist_user_select.jsp?uId=$userID&uPw=$userPW');
    var response = await http.get(url);
    // await, build가 data를 기다림
    // get 방식
    var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
    // body 자체로는 decode하지 못한다 : bodyBytes
    List result = dataConvertedJSON['results'];
    // 행렬의 형태로 result에 저장한다. [2,4]

    setState(() {
      data = []; // 초기화 안하면 계속 누적되어서 출력된다.
      data.addAll(result);
    });
    print(data);
    return true;
  }

  logInCheck(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          if (data.isEmpty) {
            return AlertDialog(
              title: const Text(
                '로그인 실패!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: const Text('ID와 PW를 확인해주세요.'),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('OK'))
              ],
            );
          } else {
            return AlertDialog(
              title: const Text(
                '로그인 성공!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: const Text('로그인에 성공하였습니다.'),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>));
                    },
                    child: const Text('OK'))
              ],
            );
          }
        });
  }
}
