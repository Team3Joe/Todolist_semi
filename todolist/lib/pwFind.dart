import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FindPw extends StatefulWidget {
  const FindPw({Key? key}) : super(key: key);

  @override
  State<FindPw> createState() => _FindPwState();
}

class _FindPwState extends State<FindPw> {
  // Property
  late TextEditingController find_idController;
  late TextEditingController find_emailController;
  late List pwinfo;
  late String find_id;
  late String find_email;

  @override
  void initState() {
    super.initState();
    find_idController = TextEditingController();
    find_emailController = TextEditingController();
    pwinfo = [];
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
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                '비밀번호 찾기',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
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
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 23,
                    ),
                    Flexible(
                      child: TextField(
                        controller: find_idController,
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
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      child: TextField(
                        controller: find_emailController,
                        decoration: const InputDecoration(
                          labelText: 'email 를 입력하세요',
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

                    getJSONData().then((value) => logInCheck(context, pwinfo[0]['pw']));
                 
                  },
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromARGB(255, 164, 154, 239),
                  ),
                  child: const Text('비밀번호 찾기'))
            ],
          ),
        ));
  }

  Future<bool> getJSONData() async {
    //비동기 함수 == 작업하면서 화면구성도 같이하겠다!
    //이럴땐 (주소) var를 많이 씀.
    pwinfo.clear();
    var url = Uri.parse(
        "http://localhost:8080/Flutter/todolist_pwFind.jsp?id=${find_idController.text}&email=${find_emailController.text}");
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
      pwinfo.addAll(result);
      
      //print(data[0]['code']); //flutter: S001
    });

    //print(response.body);
    return true;
  }

  _showDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('입력 결과'),
            content: const Text('입력이 완료 되었습니다.'),
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

  logInCheck(BuildContext context, String pwinfoma) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          if (pwinfo.isEmpty) {
            return AlertDialog(
              title: const Text(
                '실패!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: const Text('아이디와 이메일을 확인해주세요.'),
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
                '비빌번호!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: Text(pwinfoma),
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
