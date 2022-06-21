// import 'dart:convert';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Signin extends StatefulWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  // Property
  late TextEditingController idController;
  late TextEditingController pwController;
  late TextEditingController nameController;
  late TextEditingController emailController;

  late String id;
  late String pw;
  late String name;
  late String email;
  late String result;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    idController = TextEditingController();
    pwController = TextEditingController();
    nameController = TextEditingController();
    emailController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("TO DO LIST"),
          toolbarHeight: 230,
          backgroundColor: const Color.fromARGB(255, 164, 154, 239),
        ),
        body: SingleChildScrollView(
          child: Form(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  '회원가입',
                  style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
                  child: Row(
                    children: [
                      const Text(
                        '아이디 : ',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 23,
                      ),
                      Flexible(
                        child: TextField(
                          controller: idController,
                          decoration: const InputDecoration(
                            labelText: 'ID 를 입력하세요',
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 164, 154, 239)),
                            ),
                          ),
                          keyboardType: TextInputType.text,
                          cursorColor: const Color.fromARGB(255, 164, 154, 239),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
                  child: Row(
                    children: [
                      const Text(
                        '패스워드 : ',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: TextFormField(
                          controller: pwController,
                          decoration: const InputDecoration(
                            labelText: '특수,대소문자,숫자 포함 8~15자이내로 입력',
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 164, 154, 239)),
                            ),
                          ),
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          cursorColor: const Color.fromARGB(255, 164, 154, 239),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
                  child: Row(
                    children: [
                      const Text(
                        '이름 : ',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 34,
                      ),
                      Flexible(
                        child: TextField(
                          controller: nameController,
                          decoration: const InputDecoration(
                            labelText: '성함을 입력하세요',
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 164, 154, 239)),
                            ),
                          ),
                          keyboardType: TextInputType.text,
                          cursorColor: const Color.fromARGB(255, 164, 154, 239),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
                  child: Row(
                    children: [
                      const Text(
                        'Email : ',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 18,
                      ),
                      Flexible(
                        child: TextFormField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            labelText: 'email 형식으로 입력하세요',
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 164, 154, 239)),
                            ),
                          ),
                          keyboardType: TextInputType.text,
                          cursorColor: const Color.fromARGB(255, 164, 154, 239),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                    onPressed: () {
                      id = idController.text;
                      pw = pwController.text;
                      name = nameController.text;
                      email = emailController.text;

                      _Validation();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromARGB(255, 164, 154, 239),
                    ),
                    child: const Text('회원가입하기'))
              ],
            ),
          ),
        ));
  }

  // --- Functions
  _Validation() {
    final id = idController.text;
    final pw = pwController.text;
    final name = nameController.text;
    final email = emailController.text;

    if (id.length > 4 && id.length < 15) {
      if (RegExp(r'^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$')
          .hasMatch(pw)) {
        if (name.length > 2 && name.length < 15) {
          if (RegExp(
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
              .hasMatch(email)) {
                _showDialog(context);
            // signinAction();

          } else {
            errorSnackBar_Email(context);
          }
        } else {
          errorSnackBar_name(context);
        }
      } else {
        errorSnackBar_pw(context);
      }
    } else {
      errorSnackBar_id(context);
    }
  }

  signinAction() async {
    var url = Uri.parse(
        'http://localhost:8080/Flutter/user_signin_return_flutter.jsp?id=$id&pw=$pw&name=$name&email=$email');
    var response = await http.get(url);
    setState(() {
      var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
      result = dataConvertedJSON['result'];

      if (result == 'OK') {
       _showDialog(context);
      } else {
        errorSnackBar(context);
      }
    });
  }

  _showDialog(BuildContext ctx) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text('To Do List SignIn'),
            content: const Text('회원가입하시겠습니까?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                  signinAction();
                  _showFinishDialog(context);

                },
                child: const Text('예'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();

                },
                child: const Text('아니오'),
              ),
            ],
          );
        });
  }

  _showFinishDialog(BuildContext ctx){
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text('환영합니다'),
            content: const Text('회원가입이 완료되었습니다'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                  Navigator.pushNamed(context, '/login');
                },
                child: const Text('로그인하러가기'),
              ),
            ],
          );
        });
  }



  errorSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("사용자 정보 입력에 문제가 발생 하였습니다."),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      ),
    );
  }

  errorSnackBar_id(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("\t\t\t\t아이디는 5자 ~ 15자 이상으로 입력해주세요."),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      ),
    );
  }

  errorSnackBar_pw(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content:
            Text("\t\t\t\t패스워드를 특수/대소문자/숫자 포함\n\t\t\t8자 ~ 15자 이내로 입력해주세요."),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      ),
    );
  }

  errorSnackBar_name(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("\t\t\t\t\t이름은 2자 ~ 15자 이내로 입력해주세요."),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      ),
    );
  }

  errorSnackBar_Email(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("\t\t\t\t\t잘못된 이메일 형식입니다.\n\t\t\t올바른 형식으로 입력해주세요."),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      ),
    );
  }
}
