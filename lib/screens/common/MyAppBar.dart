import "package:flutter/material.dart";

class MyAppBar {
  static String userName;
  static getAppBar(BuildContext context, String userNameIn) {
    if (userName == null) {
      userName = userNameIn;
    }
    return AppBar(
        backgroundColor: Colors.pink,
        title: InkWell(
            child: new Text("Home"),
            onTap: () => {Navigator.pushNamed(context, "/")}),
        elevation: 0.0,
        actions: [
          Padding(
              padding: EdgeInsets.all(20),
              // ignore: deprecated_member_use
              child: userName != null
                  ? new Text("Welcome, " + userName + "!")
                  : FlatButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/login");
                      },
                      child: Text("Login"))),
        ]);
  }
}
