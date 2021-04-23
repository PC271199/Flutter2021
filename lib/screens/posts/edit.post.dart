import 'dart:io';
import 'package:blog/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:blog/services/postCURD.dart';
import 'package:fluttertoast/fluttertoast.dart';

// ignore: must_be_immutable
class EditPost extends StatefulWidget {
  String postId;
  @override
  EditPost(this.postId);
  _EditPostState createState() => _EditPostState(this.postId);
}

class _EditPostState extends State<EditPost> {
  String authorName, title, content, postId;
  dynamic post = {};
  _EditPostState(this.postId);

  File selectedImage;
  bool _isLoading = false;

  CrudMethods crudMethods = new CrudMethods();

  @override
  void initState() {
    super.initState();
    getPost();
  }

  upadtePost() async {
    Map<String, String> blogMap = {"title": title, "content": content};
    var result = await crudMethods.updatePost(postId, blogMap);

    Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    Fluttertoast.showToast(
        msg: result["msg"],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Flutter",
              style: TextStyle(fontSize: 22),
            ),
            Text(
              "Blog",
              style: TextStyle(fontSize: 22, color: Colors.blue),
            )
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              upadtePost();
            },
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.file_upload)),
          )
        ],
      ),
      body: _isLoading
          ? Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            )
          : Container(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                      onTap: () {},
                      child: selectedImage != null
                          ? Container(
                              margin: EdgeInsets.symmetric(horizontal: 16),
                              height: 170,
                              width: MediaQuery.of(context).size.width,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: Image.file(
                                  selectedImage,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : Container(
                              margin: EdgeInsets.symmetric(horizontal: 16),
                              height: 170,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6)),
                              width: MediaQuery.of(context).size.width,
                              child: Icon(
                                Icons.add_a_photo,
                                color: Colors.black45,
                              ),
                            )),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: <Widget>[
                        TextField(
                          decoration: InputDecoration(hintText: "Title"),
                          onChanged: (val) {
                            title = val;
                          },
                        ),
                        TextFormField(
                          minLines: 6,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          initialValue: post["content"],
                          // decoration: InputDecoration(hintText: "Content"),
                          onChanged: (val) {
                            content = val;
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }

  void getPost() async {
    try {
      var result = await crudMethods.getPost(postId);
      var postData = result["post"];
      setState(() {
        post = postData;
      });
      print(post);
    } catch (e) {}
  }
}
