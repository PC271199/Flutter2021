import 'dart:convert';

import 'package:blog/screens/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map<String, dynamic>> posts = [];
  final PublishSubject subject = PublishSubject<String>();

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
                        getPosts();
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
                                  title:
                                      Image.network(posts[index]["post_url"]),
                                  subtitle: Text('xss',
                                      style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold))),
                              children: [
                            Padding(
                                padding: EdgeInsets.all(12),
                                child: Text('ahihi')),
                          ]))));
            }));
  }

//posts[index]["post_body"] posts[index]["post_header"]
  String url = 'http://localhost/posts';
  Future<void> getPosts() async {
    try {
      print('get post');
      print('don1');
      var response = await http
          .get(Uri.tryParse(url), headers: {"Accept": "application/json"});
      var p = jsonDecode(response.body);
      p.forEach(addPost);
    } catch (e) {}
  }

  void addPost(item) {
    setState(() {
      posts.add(item);
    });
  }

  void login() {
    print("sdjhsjdhs");
  }
}
