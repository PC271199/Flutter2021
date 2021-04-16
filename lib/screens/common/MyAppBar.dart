import "package:flutter/material.dart";


class MyAppBar {
  static getAppBar(BuildContext context) {
    return AppBar(
        backgroundColor: Colors.pink,
        title: InkWell(
            child: new Text("Home"),
            onTap: () => {Navigator.pushNamed(context, "/")}),
        elevation: 0.0,
        actions: [
          Padding(
              padding: EdgeInsets.all(8.0),
              // ignore: deprecated_member_use
              child: FlatButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/login");
                  },
                  child: Text("Login"))),
        ]);
  }
}
