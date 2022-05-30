import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todolist/part_B/YJ/message.dart';


class Update extends StatefulWidget {
  const Update({Key? key}) : super(key: key);

  @override
  State<Update> createState() => _UpdateState();
}

class _UpdateState extends State<Update> {

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

    idController.text=Message.userid;
    pwController.text=Message.userpw;
    nameController.text=Message.username;
    emailController.text=Message.useremail;

    result = '';
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To Do List'),
      ),
      body: Center(
        child: Column(
          children: [
            TextField(
                  readOnly: true,
                  controller: idController,
                  decoration: const InputDecoration(
                    labelText: 'ID',
                  ),
                  keyboardType: TextInputType.text,
                ),
                TextField(
                  controller: pwController,
                  decoration: const InputDecoration(
                    labelText: '비밀번호',
                  ),
                  keyboardType: TextInputType.text,
                ),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: '전화번호',
                  ),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: '이메일',
                  ),
                  keyboardType: TextInputType.text,
                ),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        id = idController.text;
                        pw = pwController.text;
                        name = nameController.text;
                        email = emailController.text;
                        updateAction();
                        
                        
                      },
                      child: const Text("수정"),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                  onPressed: () {
                    id = idController.text;
                        pw = pwController.text;
                        name = nameController.text;
                        email = emailController.text;
                    deleteAction();
                    
                  },
                  child: const Text("삭제"),
                ),
                  ],
                ),
                
          ],
        ),
      ),
    );
  }

//--- functions
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