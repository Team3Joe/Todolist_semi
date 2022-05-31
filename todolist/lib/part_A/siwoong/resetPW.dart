import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ResetPW extends StatefulWidget {
  const ResetPW({Key? key}) : super(key: key);

  @override
  State<ResetPW> createState() => _ResetPWState();
}

class _ResetPWState extends State<ResetPW> {
  // Property
  late TextEditingController uIdField;
  late TextEditingController uEmailField;
  late TextEditingController modifyPWField;
  late String uId;
  late String uEmail;
  late String uPw;
  late List data;

  @override
  void initState() {
    super.initState();
    uIdField = TextEditingController();
    uEmailField = TextEditingController();
    modifyPWField = TextEditingController();
    uId = '';
    uEmail = '';
    uPw = '';
    data = [];
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
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
                    Icons.find_in_page,
                    size: 50,
                    color: Color.fromARGB(255, 164, 154, 239),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    controller: uIdField,
                    decoration: const InputDecoration(labelText: 'ID를 입력하세요.'),
                    keyboardType: TextInputType.text,
                    onChanged: (value) {},
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: uEmailField,
                    decoration:
                        const InputDecoration(labelText: 'email을 입력하세요.'),
                    keyboardType: TextInputType.text,
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
                      if (uIdField.text.trim().isEmpty) {
                        emptyID(context);
                      } else if (uEmailField.text.trim().isEmpty) {
                        emptyEmail(context);
                      } else {
                        setState(() {
                          uId = uIdField.text.trim();
                          uEmail = uEmailField.text.trim();
                        });
                        getJSONData().then((value) => findPWCheck(context));
                        // data 오류
                      }
                    },
                    child: const Text('PW 찾기'),
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
                          Navigator.pushNamed(context, '/signin');
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

  emptyID(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('이름을 입력하세요.'),
        duration: Duration(seconds: 1),
        backgroundColor: Colors.red,
      ),
    );
  }

  emptyEmail(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('email을 입력하세요.'),
        duration: Duration(seconds: 1),
        backgroundColor: Colors.red,
      ),
    );
  }

  Future<bool> getJSONData() async {
    // 비동기 방식 async : 동시에 실행되고
    var url = Uri.parse(
        'http://localhost:8080/Flutter/todolist_findPW_select.jsp?uId=$uId&uEmail=$uEmail');
    var response = await http.get(url);
    // await, build가 data를 기다림
    // get 방식
    var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
    // body 자체로는 decode하지 못한다 : bodyBytes
    List result = dataConvertedJSON['results'];
    // 행렬의 형태로 result에 저장한다.

    setState(() {
      data = []; // 초기화 안하면 계속 누적되어서 출력된다.
      data.addAll(result);
      uPw = data[0]['uPw'];
    });
    return true;
  }

  findPWCheck(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        if (data.isEmpty) {
          return AlertDialog(
            title: const Text(
              'PW 찾기 실패!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            content: const Text('ID와 email을 확인해주세요.'),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    // resetPW();
                    Navigator.pop(context);
                  },
                  child: const Text('OK'))
            ],
          );
        } else {
          return AlertDialog(
            title: const Text(
              'PW 찾기 성공!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text('가입하신 ID의 PW는 $uPw입니다.'),
            // content: TextField(
            //   controller: modifyPWField,
            //   decoration: const InputDecoration(labelText: '변경하실 PW를 입력하세요.'),
            // ),
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
      },
    );
  }

  // resetPW() async{
  //   var url = Uri.parse(
  //     'http://localhost:8080/flutter/student_update_return_flutter.jsp?code=$code&name=$name&dept=$dept&phone=$phone',
  //   );
  //   var response = await http.get(url);
  //   setState(
  //     () {
  //       var dataConvertedJSON = json.decode(
  //         utf8.decode(response.bodyBytes),
  //       );
  //       result = dataConvertedJSON['result'];

  //       if (result == 'OK') {
  //         Navigator.pop(context);
  //         _showDialog(context);
  //       } else {
  //         _errorSnackBar(context);
  //       }
  //     },
  //   );
  // }
}
