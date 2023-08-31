import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todolist/pages/add.dart';
import 'package:todolist/pages/update_todolist.dart';

// import 'package:todolist/pages/add.dart';
// import 'package:todolist/pages/update_todolist.dart';
class Todolist extends StatefulWidget {
  const Todolist({super.key});

  @override
  State<Todolist> createState() => _TodolistState();
}

class _TodolistState extends State<Todolist> {
  List todolistitems = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTodolist();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddPage())).then((value) {
            getTodolist();
            final snackBar = SnackBar(
              content: const Text('ເພີ່ມລາຍການສຳເລັດ'),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          });
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text('All Todolist'),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  getTodolist();
                });
                print("i love you");
              },
              icon: Icon(Icons.refresh))
        ],
      ),
      body: todolistCreate(),
    );
  }

  Widget todolistCreate() {
    return ListView.builder(
        itemCount: todolistitems.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text('${todolistitems[index]['title']}'),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: ((context) => UpdatePage(
                  todolistitems[index]['id'], 
                  todolistitems[index]['title'], 
                  todolistitems[index]['detail'], 
                  )))).then((value) {
                    getTodolist();
                    setState(() {
                      print("${value}");
                      if(value == "delete"){
                        final snackBar = SnackBar(content: const Text('ລົບລາຍການສຳເລັດ'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    });
                  });
                  
              },
            ),
          );
        });
  }

  Future<void> getTodolist() async {
    var url = Uri.http('192.168.1.9:8000','/api/all-todolist');
    var response = await http.get(url);
    var result = utf8.decode(response.bodyBytes);
    print(result);
    setState(() {
      todolistitems = json.decode(result);
    });
  }
}
