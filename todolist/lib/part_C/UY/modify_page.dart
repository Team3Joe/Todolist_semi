import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todolist/part_C/UY/list_item.dart';

class ModifyPage extends StatefulWidget {
  const ModifyPage({Key? key}) : super(key: key);

  @override
  State<ModifyPage> createState() => _ModifyPageState();
}

class _ModifyPageState extends State<ModifyPage> {
  late TextEditingController modify;
  late String result;
  late String content;
  late String code;
  @override
  void initState() {
    super.initState();
    modify = TextEditingController();
    result = "";
    modify.text = ListItem.content;
    code = ListItem.code;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Modify To Do List"),
        toolbarHeight: 230,
        backgroundColor: const Color.fromARGB(255, 164, 154, 239),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: TextField(
                controller: modify,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(labelText: "할일을 적어주세요"),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        content = modify.text;
                        code = ListItem.code;
                      });
                      updateAction();
                      print(content);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 142, 87, 236),
                    ),
                    child: const Text('수정', style: TextStyle(fontSize: 15)),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      code = ListItem.code;
                    });
                    deleteAction();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 142, 87, 236),
                  ),
                  child: const Text('삭제', style: TextStyle(fontSize: 15)),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 164, 154, 239),
        child: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pushNamed(context, '/list');
        },
      ),
    );
  }

  updateAction() async {
    var url = Uri.parse(
        'http://localhost:8080/Flutter/todolist_update_content.jsp?lContent=$content&lCode=$code');
    var response = await http.get(url);
    var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
    setState(() {
      result = dataConvertedJSON['result'];
    });
    print(result);
    if (result == 'OK') {
      _showDialog(context);
    } else {
      errorSnackBar(context);
    }
  }

  deleteAction() async {
    var url = Uri.parse(
        'http://localhost:8080/Flutter/todolist_delete.jsp?lCode=$code');
    var response = await http.get(url);
    var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
    setState(() {
      result = dataConvertedJSON['result'];
    });
    print(result);
    if (result == 'OK') {
      _showDialogDelete(context);
    } else {
      errorSnackBar(context);
    }
  }

  _showDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text('입력 결과'),
            content: const Text('입력이 완료 되었습니다.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(ctx).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        });
  }

  _showDialogDelete(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text('삭제결과'),
            content: const Text('삭제가 완료 되었습니다.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(ctx).pop();
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
}
