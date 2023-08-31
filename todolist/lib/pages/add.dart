import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  TextEditingController add_title = TextEditingController();
  TextEditingController add_detail = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ເພີ່ມລາຍການ'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            TextField(
              controller: add_title,
              decoration: InputDecoration(
                  label: Text('ຫົວຂໍ້'),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)))),
            ),
            SizedBox(
              height: 30,
            ),
            TextField(
              controller: add_detail,
              minLines: 4,
              maxLines: 8,
              decoration: InputDecoration(
                  label: Text('ລາຍລະອຽດ'),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)))),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  postTodo();
                });
                Navigator.pop(context);
                print("create finish");
              },
              child: Text('ເພີ່ມຂໍ້ມູນ'),
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                      EdgeInsets.fromLTRB(50, 20, 50, 20)),
                  textStyle: MaterialStateProperty.all(TextStyle(fontSize: 20)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)))),
            ),
          ],
        ),
      ),
    );
  }

  Future postTodo() async {
    var url = Uri.http('192.168.1.9:8000', '/api/post-todolist');
    Map<String, String> header = {"Content-type": "application/json"};
    String jsondata =
        '{"title":"${add_title.text}","detail":"${add_detail.text}"}';
    var response = await http.post(url, headers: header, body: jsondata);
    print("+++result+++");
    print(response.body);
  }
}
