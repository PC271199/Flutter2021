import 'dart:convert';

import 'package:blog/main.dart';
import 'package:blog/screens/MyDrawer.dart';
import 'package:blog/screens/login/login_page.dart';
import 'package:blog/screens/create/create_page.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:blog/services/postCURD.dart';

import '../MyAppBar.dart';

class PostManage extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<PostManage> {
  List<dynamic> posts = [];
  final PublishSubject subject = PublishSubject<String>();

  CrudMethods crudMethods = new CrudMethods();

  @override
  void dispose() {
    subject.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar.getAppBar(context),
        drawer: MyDrawer.getDrawer(context),
        body: ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, int index) {
              return Container(
                child: Table(
                  children: [
                    TableRow(children: [
                      TableCell(
                          child: Center(child: Text(posts[index]["_id"]))),
                      TableCell(
                          child: Center(child: Text(posts[index]["title"]))),
                      TableCell(
                          child: Center(
                              child: TextButton(
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.blue),
                        ),
                        onPressed: () {
                          deletePost(posts[index]["_id"]);
                        },
                        child: Text('Delete'),
                      ))),
                      TableCell(
                          child: Center(
                              child: TextButton(
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.blue),
                        ),
                        onPressed: () {},
                        child: Text('Edit'),
                      )))
                    ]),
                  ],
                ),
              );
            }));
  }

  void getPosts() async {
    try {
      var result = await crudMethods.getBloggerPosts();
      var postData = result["posts"];
      setState(() {
        posts = postData;
      });
      print(posts);
    } catch (e) {}
  }

  void deletePost(postId) async {
    try {
      var result = await crudMethods.deletePost(postId);
      Navigator.pushReplacement(
          context,
          // rerender page
          MaterialPageRoute(builder: (BuildContext context) => super.widget));
    } catch (e) {
      print(e);
    }
  }
}
