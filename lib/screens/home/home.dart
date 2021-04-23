import 'package:blog/screens/common/MyDrawer.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:rxdart/rxdart.dart';
import 'package:blog/services/postCURD.dart';
import 'package:blog/utils/headerData.dart';
import '../common/MyAppBar.dart';

class Home extends StatefulWidget {
  Home();
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<dynamic> posts = [];
  String comment;
  int role;
  String userId, token;
  Color color;
  final PublishSubject subject = PublishSubject<String>();
  CrudMethods crudMethods = new CrudMethods();
  String userName;
  @override
  void dispose() {
    subject.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    getRoleAndUserId();
    getPosts();
  }

  @override
  Widget build(BuildContext context) {
    HeaderData.getUserName().then((value) {
      userName = value;
    });
    return Scaffold(
        appBar: MyAppBar.getAppBar(context, userName),
        drawer: MyDrawer.getDrawer(context, role),
        body: SingleChildScrollView(
            padding: EdgeInsets.only(top: 50),
            child: Column(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.only(left: 0),
                    child: FlatButton(
                      shape: CircleBorder(
                          side: BorderSide(
                              width: 2,
                              color: Colors.black54,
                              style: BorderStyle.solid)),
                      padding: EdgeInsets.fromLTRB(35, 35, 35, 35),
                      onPressed: () =>
                          {Navigator.pushNamed(context, "/create-post")},
                      child: Column(
                        children: [
                          Icon(
                            Icons.create_sharp,
                            color: Color.fromRGBO(41, 187, 255, 1),
                          ),
                          Text("New post",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Poppins',
                                  color: Color.fromRGBO(41, 187, 255, 1)))
                        ],
                      ),
                    )),
                Container(
                    child: ListView.builder(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: posts.length,
                        itemBuilder: (context, int index) {
                          return Container(
                              width: 400,
                              alignment: Alignment.center,
                              child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 100,
                                      right: 100,
                                      top: 10,
                                      bottom: 20),
                                  child: Card(
                                      child: ExpansionTile(
                                          title: ListTile(
                                              title: Text(posts[index]["title"],
                                                  style: TextStyle(
                                                      fontSize: 28,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              subtitle: Text(
                                                  posts[index]["nameAuthor"],
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.white54,
                                                      fontStyle:
                                                          FontStyle.italic))),
                                          backgroundColor: Colors.black54,
                                          collapsedBackgroundColor:
                                              Colors.black45,
                                          children: [
                                        Container(
                                            padding: EdgeInsets.only(
                                                top: 10, bottom: 10, left: 20),
                                            child: Row(children: <Widget>[
                                              Flexible(
                                                  child: Text(
                                                posts[index]["content"],
                                                style: TextStyle(fontSize: 20),
                                              ))
                                            ])),
                                        Container(
                                            color: Colors.black38,
                                            child: Row(children: <Widget>[
                                              Container(
                                                padding: EdgeInsets.all(10),
                                                child: TextButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        if (this.token !=
                                                            null) {
                                                          this.checkLike(
                                                                  posts[index]
                                                                      ["likes"])
                                                              ? this.deleteLike(
                                                                  posts[index]
                                                                      ["likes"],
                                                                  userId)
                                                              : this
                                                                  .posts[index]
                                                                      ["likes"]
                                                                  .add({
                                                                  "userId":
                                                                      userId
                                                                });
                                                        } else {
                                                          Fluttertoast.showToast(
                                                              msg:
                                                                  "Please login to like post!",
                                                              toastLength: Toast
                                                                  .LENGTH_SHORT,
                                                              gravity:
                                                                  ToastGravity
                                                                      .CENTER,
                                                              timeInSecForIosWeb:
                                                                  2,
                                                              backgroundColor:
                                                                  Colors.red,
                                                              textColor:
                                                                  Colors.white,
                                                              fontSize: 16.0);
                                                        }
                                                      });
                                                      crudMethods.likePost(
                                                          posts[index]["_id"]);
                                                    },
                                                    child: Icon(Icons.favorite,
                                                        color: this.checkLike(
                                                                posts[index]
                                                                    ["likes"])
                                                            ? Colors.pink
                                                            : Color(
                                                                0xFFFFFFFF))),
                                              ),
                                              Text(posts[index]["likes"]
                                                  .length
                                                  .toString())
                                            ])),
                                        Container(
                                            child: ListView.builder(
                                                scrollDirection: Axis.vertical,
                                                shrinkWrap: true,
                                                itemCount: posts[index]
                                                        ["comments"]
                                                    .length,
                                                itemBuilder: (context, int i) {
                                                  return Row(children: <Widget>[
                                                    Container(
                                                        padding:
                                                            EdgeInsets.all(10),
                                                        child: Text(
                                                            posts[index]
                                                                    ["comments"]
                                                                [i]["fullName"],
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold))),
                                                    Text(posts[index]
                                                            ["comments"][i]
                                                        ["content"])
                                                  ]);
                                                })),
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 16),
                                          child: Column(
                                            children: <Widget>[
                                              TextField(
                                                decoration: InputDecoration(
                                                    hintText: "Comment"),
                                                onChanged: (val) {
                                                  comment = val;
                                                },
                                              ),
                                              TextButton(
                                                style: ButtonStyle(
                                                  foregroundColor:
                                                      MaterialStateProperty.all<
                                                          Color>(Colors.blue),
                                                ),
                                                onPressed: () {
                                                  crudMethods.postComment(
                                                      posts[index]["_id"],
                                                      comment);
                                                  getPosts();
                                                  Navigator.pushReplacement(
                                                      context,
                                                      // rerender page
                                                      MaterialPageRoute(
                                                          builder: (BuildContext
                                                                  context) =>
                                                              super.widget));
                                                },
                                                child: Text('Send'),
                                              )
                                            ],
                                          ),
                                        )
                                      ]))));
                        }))
              ],
            )));
  }

  void getPosts() async {
    try {
      var result = await crudMethods.getPosts();
      var postData = result["posts"];
      setState(() {
        posts = postData;
      });
    } catch (e) {}
  }

  void getRoleAndUserId() async {
    var currentRole = await HeaderData.getRole();
    String id = await HeaderData.getUserId();
    String tk = await HeaderData.getToken();
    setState(() {
      role = currentRole;
      userId = id;
      token = tk;
    });
  }

  bool checkLike(likes) {
    for (var i = 0; i < likes.length; i++) {
      if (likes[i]["userId"] == this.userId) {
        return true;
      }
    }
    return false;
  }

  bool deleteLike(likes, userId) {
    for (var i = 0; i < likes.length; i++) {
      if (likes[i]["userId"] == userId) {
        likes.removeAt(i);
        return true;
      }
    }
  }
}
