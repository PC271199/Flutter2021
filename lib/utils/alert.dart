import 'package:flutter/material.dart';

showMyAlertDialog(BuildContext context, String title, String content) {
  // Create AlertDialog
  AlertDialog dialog = AlertDialog(
    title: Text(title),
    content: Text(content),
    actions: [
      ElevatedButton(
          child: Text("Yes"),
          onPressed: () {
            Navigator.of(context).pop("Yes, Of course!"); // Return value
          }),
    ],
  );

  // Call showDialog function to show dialog.
  Future<String> futureValue = showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialog;
      });
}
