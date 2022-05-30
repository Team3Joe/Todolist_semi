import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todolist/part_B/YJ/message.dart';

class DrawerPage extends StatefulWidget {
  

  const DrawerPage({Key? key}) : super(key: key);

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late String id;
  late String email;
  late String result;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    id = Message.userid;
    email = Message.useremail;
    
    
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
        toolbarHeight: 230,
        backgroundColor: const Color.fromARGB(255, 164, 154, 239),
      ),
       drawer: Drawer(
        child: ListView(
          //패딩 없이 꽉 채우기
          padding: EdgeInsets.zero,
          children: [
             UserAccountsDrawerHeader(
              //상단에 이미지 넣기
              
              //이미지 밑에 이름 & 이메일
              accountName: Text( id ),
              accountEmail: Text( email ),
              decoration: const BoxDecoration(
                color:  Color.fromARGB(255, 164, 154, 239),
                //테두리, 값을 각각 줄 수 있음. all 은 한번에 다 뜸
                
              ),
            ),

            // 리스트
            ListTile(
              onTap: () {
                setState(() {
                  Navigator.pushNamed(context, '/MyPage');
              
                });
              },
              leading: const Icon(
                Icons.home,
                color: Colors.deepPurple,
              ),
              title: const Text('My Page'),
            ),
            
          ],
        ),
      ),
    );
  }

selectAction() async {
    var url = Uri.parse(
        'http://localhost:8080/Flutter/user_query.jsp?id=$id');
    var response = await http.get(url);
    setState(() {
      var dataCovertedJSON = json.decode(utf8.decode(response.bodyBytes));
      result = dataCovertedJSON['result'];
    });
  }
 
  }