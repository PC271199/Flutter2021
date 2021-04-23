import 'dart:convert';

import 'package:blog/main.dart';
import 'package:blog/screens/common/MyDrawer.dart';
import 'package:blog/screens/login/login_page.dart';
import 'package:blog/screens/create/create_page.dart';
import 'package:blog/utils/headerData.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rxdart/rxdart.dart';
import 'package:blog/services/postCURD.dart';

import '../common/MyAppBar.dart';

import 'package:blog/screens/posts/edit.post.dart';

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
        appBar: MyAppBar.getAppBar(context, ""),
        drawer: MyDrawer.getDrawer(context, 2),
        body: Container(
            padding: EdgeInsets.only(left: 400, right: 400, top: 20),
            child: Column(children: [
              Table(children: [
                TableRow(
                    decoration: new BoxDecoration(color: Colors.black38),
                    children: [
                      TableCell(
                          child: Center(
                              child: Text(
                        "Title",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ))),
                      TableCell(
                          child: Center(
                              child: Text(
                        "Edit",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ))),
                      TableCell(
                          child: Center(
                              child: Text(
                        "Delete",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      )))
                    ])
              ]),
              ListView.builder(
                  itemCount: posts.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, int index) {
                    return Table(children: [
                      TableRow(children: [
                        TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Container(
                                padding: EdgeInsets.only(left: 20),
                                child: Text(posts[index]["title"],
                                    style: TextStyle(fontSize: 20)))),
                        TableCell(
                            child: Center(
                                child: TextButton(
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.yellow),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        EditPost(posts[index])));
                          },
                          child: Text('Edit', style: TextStyle(fontSize: 20)),
                        ))),
                        TableCell(
                            child: Center(
                                child: TextButton(
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.red),
                          ),
                          onPressed: () {
                            deletePost(posts[index]["_id"]);
                          },
                          child: Text('Delete', style: TextStyle(fontSize: 20)),
                        )))
                      ])
                    ]);
                  })
            ])));
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
      Fluttertoast.showToast(
          msg: result["msg"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } catch (e) {
      print(e);
    }
  }
}
