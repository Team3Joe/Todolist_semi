import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todolist/part_A/siwoong/SM/adduser.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  // Property
  late TextEditingController uId;
  late TextEditingController uPw;

  @override
  void initState() {
    super.initState();
    uId = TextEditingController();
    uPw = TextEditingController();
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
        body: Padding(
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
                  color: Colors.cyan,
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
                  onPressed: () {
                    if (uId.text.trim().isEmpty) {
                      emptyID(context);
                    } else if (uPw.text.trim().isEmpty) {
                      emptyPW(context);
                    } else if (uId.text.trim() != 'root') {
                      wrongID(context);
                    } else if (uPw.text.trim() != 'qwer1234') {
                      wrongPW(context);
                    } else {
                      logInSuccess(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      primary: const Color.fromARGB(255, 164, 154, 239)),
                  child: const Text('Log in'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Adduser()));
                        },
                        style: ElevatedButton.styleFrom(
                            primary: const Color.fromARGB(255, 164, 154, 239)),
                        child: const Text('ID / PW 찾기')),
                    SizedBox(
                      width: 50,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Adduser()));
                        },
                        style: ElevatedButton.styleFrom(
                            primary: const Color.fromARGB(255, 164, 154, 239)),
                        child: const Text('회원가입')),
                  ],
                )
              ],
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
        duration: Duration(milliseconds: 250),
        backgroundColor: Colors.red,
      ),
    );
  }

  emptyPW(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('PW를 입력하세요.'),
        duration: Duration(milliseconds: 250),
        backgroundColor: Colors.red,
      ),
    );
  }

  wrongID(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('등록된 ID를 입력하세요.'),
        duration: Duration(milliseconds: 250),
        backgroundColor: Colors.red,
      ),
    );
  }

  wrongPW(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('ID에 맞는 PW를 입력하세요.'),
        duration: Duration(milliseconds: 250),
        backgroundColor: Colors.yellow,
      ),
    );
  }

  logInSuccess(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text(
              'Welcome!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            content: const Text('Log-in complete'),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'))
            ],
          );
        });
  }
}
