import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todolist/part_B/YJ/message.dart';


class Delete extends StatefulWidget {
  const Delete({Key? key}) : super(key: key);

  @override
  State<Delete> createState() => _DeleteState();
}

class _DeleteState extends State<Delete> {

  //Property
  late TextEditingController idController;
  late TextEditingController pwController;
  late TextEditingController phoneController;
  late TextEditingController emailController;
  late TextEditingController birthController;

  late String id;
  late String pw;
  late String phone;
  late String email;
  late String birth;
  late String result;

  @override
  void initState() {
    super.initState();
    idController = TextEditingController();
    pwController = TextEditingController();
    phoneController = TextEditingController();
    emailController = TextEditingController();
    birthController = TextEditingController();

    idController.text=Message.userid;
    pwController.text=Message.userpw;
    phoneController.text=Message.userphone;
    emailController.text=Message.useremail;
    birthController.text=Message.userbirth;

    result = '';
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delete for CRUD'),
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
                  readOnly: true,
                  controller: pwController,
                  decoration: const InputDecoration(
                    labelText: '비밀번호',
                  ),
                  keyboardType: TextInputType.text,
                ),
                TextField(
                  readOnly: true,
                  controller: phoneController,
                  decoration: const InputDecoration(
                    labelText: '전화번호',
                  ),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  readOnly: true,
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: '이메일',
                  ),
                  keyboardType: TextInputType.text,
                ),
                TextField(
                  readOnly: true,
                  controller: birthController,
                  decoration: const InputDecoration(
                    labelText: '생년월일',
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: () {
                    id = idController.text;
                    pw = pwController.text;
                    phone = phoneController.text;
                    email = emailController.text;
                    birth = birthController.text;
                    deleteAction();
                    
                  },
                  child: const Text("삭제"),
                ),
          ],
        ),
      ),
    );
  }

//--- functions
  deleteAction() async {
    var url = Uri.parse(
        'http://localhost:8080/Flutter/user_delete.jsp?id=$id&pw=$pw&phone=$phone&email=$email&birth=$birth');
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
            title: const Text('삭제 결과'),
            content: const Text('삭제가 완료 되었습니다.'),
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