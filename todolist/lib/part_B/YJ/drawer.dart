import 'package:flutter/material.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({Key? key}) : super(key: key);

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
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
        backgroundColor:const Color.fromARGB(255, 164, 154, 239),
      ),
       drawer: Drawer(
        child: ListView(
          //패딩 없이 꽉 채우기
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              //상단에 이미지 넣기
              
              //이미지 밑에 이름 & 이메일
              accountName: Text('Gaseul'),
              accountEmail: Text('julietmf@naver.com'),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 164, 154, 239),
                //테두리, 값을 각각 줄 수 있음. all 은 한번에 다 뜸
                
              ),
            ),

            // 리스트
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, '/mypage');
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
}