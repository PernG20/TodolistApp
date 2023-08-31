import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;

class UpdatePage extends StatefulWidget {
  // const UpdatePage({super.key});

  final v1, v2, v3;
  UpdatePage(this.v1, this.v2, this.v3);

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  var _v1, _v2, _v3;
  TextEditingController add_title = TextEditingController();
  TextEditingController add_detail = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _v1 = widget.v1; // id
    _v2 = widget.v2; // title
    _v3 = widget.v3; // detail
    add_title.text = _v2;
    add_detail.text = _v3;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ເເກ້ໄຂລາຍການ'),
        actions: [
          IconButton(
              onPressed: () {
                deleteTodo();
                print('Delete ID = ${_v1}');
                Navigator.pop(context, 'delete');
              },
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ))
        ],
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
                      borderRadius: BorderRadius.circular(15))),
            ),
            SizedBox(
              height: 30,
            ),
            //field detail
            TextField(
              controller: add_detail,
              minLines: 4,
              maxLines: 8,
              decoration: InputDecoration(
                  label: Text('ລາຍລະອຽດ'),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)))),
            ),
            SizedBox(height: 30),
            //button update
            ElevatedButton(
              onPressed: () {
                updateTodo();
                final snackBar = SnackBar(content: Text("ເເກ້ໄຂລາຍການສຳເລັດ"));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              child: Text('ເເກ້ໄຂ'),
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

  // funtion update
  Future updateTodo() async {
    var url = Uri.http('192.168.1.9:8000', '/api/update-todolist/${_v1}');
    Map<String, String> header = {'Content-type': 'application/json'};
    String jsondata =
        '{"title":"${add_title.text}","detail":"${add_detail.text}"}';
    var response = await http.put(url, headers: header, body: jsondata);
    print('===result===');
    print(response.body);
  }

  //funtion delete
  Future deleteTodo() async {
    var url = Uri.http('192.168.1.9:8000', '/api/delete-todolist/${_v1}');
    Map<String, String> header = {"Content-type": "application/json"};
    var response = await http.delete(url, headers: header);
    print('---result---');
    print("Delete finish");
    print(response.body);
  }
}
