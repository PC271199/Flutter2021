import 'dart:convert';

import 'package:blog/screens/login/login_page.dart';
import 'package:blog/screens/create/create_page.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import 'package:blog/services/postCURD.dart';

String url = 'https://ancient-cliffs-67475.herokuapp.com/api/v1/posts';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
        appBar: AppBar(
            backgroundColor: Colors.pink,
            title: Text("Home"),
            elevation: 0.0,
            actions: [
              Padding(
                  padding: EdgeInsets.all(8.0),
                  // ignore: deprecated_member_use
                  child: FlatButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      },
                      child: Text("Login"))),
              Padding(
                  padding: EdgeInsets.all(8.0),
                  // ignore: deprecated_member_use
                  child: FlatButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreateBlog()));
                      },
                      child: Text("Create posts"))),
              Padding(
                  padding: EdgeInsets.all(8.0),
                  // ignore: deprecated_member_use
                  child:
                      // ignore: deprecated_member_use
                      FlatButton(onPressed: () {}, child: Text("Edit posts"))),
              Padding(
                  padding: EdgeInsets.all(8.0),
                  // ignore: deprecated_member_use
                  child:
                      // ignore: deprecated_member_use
                      FlatButton(onPressed: () {}, child: Text("Delete post"))),
            ]),
        drawer: Drawer(
            child: Scaffold(
                appBar: AppBar(
                    elevation: 0.0,
                    title: Text("My blog"),
                    backgroundColor: Colors.pink),
                body: Column(children: <Widget>[
                  ListTile(title: Text("Dashboard")),
                  ListTile(title: Text("Manage users")),
                  ListTile(title: Text("Manage posts")),
                  ListTile(title: Text("Log out")),
                ]))),
        body: ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, int index) {
              return Container(
                  width: 400,
                  alignment: Alignment.center,
                  child: Padding(
                      padding: EdgeInsets.only(left: 100, right: 100),
                      child: Card(
                          child: ExpansionTile(
                              title: ListTile(
                                  subtitle: Text(posts[index]["title"],
                                      style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold))),
                              children: [
                            Padding(
                                padding: EdgeInsets.all(12),
                                child: Text(posts[index]["content"])),
                          ]))));
            }));
  }

  void getPosts() async {
    try {
      var result = await crudMethods.getPosts();
      var postData = result["posts"];
      setState(() {
        posts = postData;
      });
    } catch (e) {
      // print(e);
    }
  }
}
