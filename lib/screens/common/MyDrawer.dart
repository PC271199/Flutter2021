import "package:flutter/material.dart";

class MyDrawer {
  static getDrawer(BuildContext context , role) {
    if(role == 0) {
        return Drawer(
          child: Scaffold(
              appBar: AppBar(
                  elevation: 0.0,
                  title: Text("My blog"),
                  backgroundColor: Colors.pink),
              body: Column(children: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/manage-posts");
                    },
                    child: ListTile(title: Text("Manage posts"))),
                TextButton(
                    onPressed: () {},
                    child: ListTile(title: Text("Manage users"))),
                TextButton(
                    onPressed: () {}, child: ListTile(title: Text("Log out"))),
              ])));
    }
     else if(role ==2 ){
       return Drawer(
        child: Scaffold(
            appBar: AppBar(
                elevation: 0.0,
                title: Text("My blog"),
                backgroundColor: Colors.pink),
            body: Column(children: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/manage-posts");
                  },
                  child: ListTile(title: Text("Manage posts"))),
              TextButton(
                  onPressed: () {}, child: ListTile(title: Text("Log out"))),
            ])));
    }
    else {
      return Drawer(
        child: Scaffold(
            appBar: AppBar(
                elevation: 0.0,
                title: Text("My blog"),
                backgroundColor: Colors.pink),
            body: Column(children: <Widget>[
              TextButton(
                  onPressed: () {}, child: ListTile(title: Text("Log out"))),
            ])));
    }
  }
  
  
}
