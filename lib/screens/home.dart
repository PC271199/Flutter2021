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
  List<Map<String, dynamic>> posts = [
    {"title":'Title',
    "content":'This is blog content\nThis is blog content\nThis is blog content\nThis is blog content',
    "like":"10",
    "comments":[
      {"user":"User A","comment":"This is a comment"},
      {"user":"User B","comment":"This is an another comment"},
      {"user":"User C","comment":"This is again an another comment"}]},
    {"title":'Title',
    "content":'This is blog content\nThis is blog content\nThis is blog contentt\nThis is blog content',
    "like":"10",
    "comments":[
      {"user":"User A","comment":"This is a comment"},
      {"user":"User B","comment":"This is an another comment"},
      {"user":"User C","comment":"This is again an another comment"}]}  
    
  ];
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
                      padding: EdgeInsets.only(left: 100, right: 100,top:10,bottom:20),
                      child: Card(
                          child: ExpansionTile(
                              title: ListTile(
                                  title:  Text(posts[index]["title"],
                                      style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold))),
                              backgroundColor: Colors.black54,
                              collapsedBackgroundColor: Colors.black45,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(top: 10, bottom: 10,left:20),
                                  child: Row( 
                                    children: <Widget>[
                                      Text(posts[index]["content"],
                                        style: TextStyle(
                                            fontSize: 20),)])),
                                Container(
                                  color: Colors.black38,
                                  child:
                                    Row(                                  
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        child:  Icon(
                                            Icons.favorite,
                                            color: Colors.pink)
                                      ),
                                      Text(posts[index]["like"])
                                    ]) 
                                ),
                                Container(
                                  child:ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: posts[index]["comments"].length,
                                    itemBuilder: (context, int i) {
                                      return Row(                                  
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.all(10),
                                            child:
                                              Text(posts[index]["comments"][i]["user"],
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold))),                                          
                                          Text(posts[index]["comments"][i]["comment"])
                                        ]) ;
                                    })
                                )
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
