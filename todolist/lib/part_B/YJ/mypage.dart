import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'message.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  //property
   //Property
  late TextEditingController idController;
  late TextEditingController pwController;
  late TextEditingController nameController;
  late TextEditingController emailController;

  late String id;
  late String pw;
  late String name;
  late String email;
  late String result;

  @override
  void initState() {
    super.initState();
    idController = TextEditingController();
    pwController = TextEditingController();
    nameController = TextEditingController();
    emailController = TextEditingController();

    idController.text = Message.userid;
    pwController.text = Message.userpw;
    nameController.text = Message.userphone;
    emailController.text = Message.useremail;

    result = '';
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Page"),
        toolbarHeight: 230,
        backgroundColor:const Color.fromARGB(255, 164, 154, 239),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 40,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Column(
                    children: const [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 43),
                        child: Text('아이디 :'),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 10, 40),
                        child: Text('비밀번호 :'),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
                        child: Text('이름 :'),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
                        child: Text('이메일 :'),
                      ),
                      
                    ],
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                      width: 180,
                      height: 60,
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            readOnly: true,
                            decoration: const InputDecoration(
                              labelText: 'ID',
                              hintText: 'id를 입력해주세요!',
                              labelStyle:
                                  TextStyle(color: Colors.deepPurpleAccent),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(
                                    width: 1, color: Colors.deepPurpleAccent),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(
                                    width: 1, color: Colors.deepPurpleAccent),
                              ),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                            ),
                            controller: idController,
                            keyboardType: TextInputType.emailAddress,
                          )),
                    ),
                    SizedBox(
                      width: 180,
                      height: 60,
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            decoration: const InputDecoration(
                              labelText: 'PW',
                              hintText: '비밀번호를 입력해주세요!',
                              labelStyle:
                                  TextStyle(color: Colors.deepPurpleAccent),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(
                                    width: 1, color: Colors.deepPurpleAccent),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(
                                    width: 1, color: Colors.deepPurpleAccent),
                              ),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                            ),
                            controller: pwController,
                            keyboardType: TextInputType.emailAddress,
                          )),
                    ),
                    SizedBox(
                      width: 180,
                      height: 60,
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            decoration: const InputDecoration(
                              labelText: 'Name',
                              hintText: '이름을 입력해주세요!',
                              labelStyle:
                                  TextStyle(color: Colors.deepPurpleAccent),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(
                                    width: 1, color: Colors.deepPurpleAccent),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(
                                    width: 1, color: Colors.deepPurpleAccent),
                              ),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                            ),
                            controller: nameController,
                            keyboardType: TextInputType.emailAddress,
                          )),
                    ),
                    SizedBox(
                      width: 180,
                      height: 60,
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              hintText: '이메일을 입력해주세요!',
                              labelStyle:
                                  TextStyle(color: Colors.deepPurpleAccent),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(
                                    width: 1, color: Colors.deepPurpleAccent),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(
                                    width: 1, color: Colors.deepPurpleAccent),
                              ),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                            ),
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                          )),
                    ),
                    
                  ],
                ),
              ],
            ),
            const SizedBox(height: 70,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    //
                  },
                  style: ElevatedButton.styleFrom(
                      primary: const Color.fromARGB(255, 164, 154, 239),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: const Text(
                    '수정',
                  ),
                ),
                const SizedBox(width: 20,),
               ElevatedButton(
                  onPressed: () {
                    //
                  },
                  style: ElevatedButton.styleFrom(
                      primary: const Color.fromARGB(255, 164, 154, 239),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: const Text(
                    '삭제',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }



//functions
  updateAction() async {
    var url = Uri.parse(
        'http://localhost:8080/Flutter/user_update.jsp?id=$id&pw=$pw&name=$name&email=$email');
    var response = await http.get(url);
    setState(() {
      var dataCovertedJSON = json.decode(utf8.decode(response.bodyBytes));
      result = dataCovertedJSON['result'];
      if (result == 'OK') {
        _showDialog(context);
      } else {
        errorSnackBar(context);
      }
    });
  }

  deleteAction() async {
    var url = Uri.parse(
        'http://localhost:8080/Flutter/user_delete.jsp?id=$id&pw=$pw&name=$name&email=$email');
    var response = await http.get(url);
    setState(() {
      var dataCovertedJSON = json.decode(utf8.decode(response.bodyBytes));
      result = dataCovertedJSON['result'];
      if (result == 'OK') {
        _showDialog(context);
      } else {
        errorSnackBar(context);
      }
    });
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
                  Navigator.pop(context);
                },
                child: const Text("OK"),
              ),
            ],
          );
        });
  }

  errorSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('문제가 발생 하였습니다.'),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      ),
    );
  }

}