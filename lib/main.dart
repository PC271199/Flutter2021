import 'package:blog/screens/create/create_page.dart';
import 'package:blog/screens/login/login_page.dart';
import 'package:blog/screens/posts/post.blogger.dart';
import 'package:blog/screens/register/register_page.dart';
import 'package:flutter/material.dart';
import 'package:blog/screens/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blog app',
      theme: ThemeData.dark(),
      routes: {
        "/": (context) => Home(),
        "/login": (context) => LoginPage(),
        "/register": (context) => RegisterPage(),
        "/manage-posts": (context) => PostManage(),
        "/create-post": (context) => CreateBlog()
      },
    );
  }
}
