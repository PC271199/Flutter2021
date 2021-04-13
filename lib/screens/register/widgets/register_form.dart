import 'dart:convert';

import 'package:blog/screens/login/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _fullNameController = TextEditingController();
  final paddingTopForm,
      fontSizeTextField,
      fontSizeTextFormField,
      spaceBetweenFields,
      iconFormSize;
  final spaceBetweenFieldAndButton,
      widthButton,
      fontSizeButton,
      fontSizeForgotPassword,
      fontSizeSnackBar,
      errorFormMessage;

  RegisterForm(
      this.paddingTopForm,
      this.fontSizeTextField,
      this.fontSizeTextFormField,
      this.spaceBetweenFields,
      this.iconFormSize,
      this.spaceBetweenFieldAndButton,
      this.widthButton,
      this.fontSizeButton,
      this.fontSizeForgotPassword,
      this.fontSizeSnackBar,
      this.errorFormMessage);

  @override
  Widget build(BuildContext context) {
    final double widthSize = MediaQuery.of(context).size.width;
    final double heightSize = MediaQuery.of(context).size.height;
    int role = 1;
    Map<String, int> listRole = {"Viewer": 1, "Blogger": 2};
    List<String> listRoleName = ["Viewer", "Blogger"];

    final String apiUrl =
        'https://ancient-cliffs-67475.herokuapp.com/api/v1/auth/register';
    return Form(
        key: _formKey,
        child: Padding(
            padding: EdgeInsets.only(
                left: widthSize * 0.05, right: widthSize * 0.05, top: 0),
            child: Column(children: <Widget>[
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Email',
                      style: TextStyle(
                          fontSize: widthSize * fontSizeTextField,
                          fontFamily: 'Poppins',
                          color: Colors.white))),
              TextFormField(
                  controller: _emailController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter email!';
                    }
                  },
                  cursorColor: Colors.white,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 2)),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2)),
                    labelStyle: TextStyle(color: Colors.white),
                    errorStyle: TextStyle(
                        color: Colors.white,
                        fontSize: widthSize * errorFormMessage),
                    prefixIcon: Icon(
                      Icons.person,
                      size: widthSize * iconFormSize,
                      color: Colors.white,
                    ),
                  ),
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Colors.white, fontSize: fontSizeTextFormField)),
              SizedBox(height: heightSize * spaceBetweenFields),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Password',
                      style: TextStyle(
                          fontSize: widthSize * fontSizeTextField,
                          fontFamily: 'Poppins',
                          color: Colors.white))),
              TextFormField(
                  controller: _passwordController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please Enter password!';
                    }
                  },
                  cursorColor: Colors.white,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 2)),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2)),
                    labelStyle: TextStyle(color: Colors.white),
                    errorStyle: TextStyle(
                        color: Colors.white,
                        fontSize: widthSize * errorFormMessage),
                    prefixIcon: Icon(
                      Icons.lock,
                      size: widthSize * iconFormSize,
                      color: Colors.white,
                    ),
                  ),
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Colors.white, fontSize: fontSizeTextFormField)),
              SizedBox(height: heightSize * spaceBetweenFieldAndButton),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Full Name',
                      style: TextStyle(
                          fontSize: widthSize * fontSizeTextField,
                          fontFamily: 'Poppins',
                          color: Colors.white))),
              TextFormField(
                  controller: _fullNameController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter full name!';
                    }
                  },
                  cursorColor: Colors.white,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 2)),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2)),
                    labelStyle: TextStyle(color: Colors.white),
                    errorStyle: TextStyle(
                        color: Colors.white,
                        fontSize: widthSize * errorFormMessage),
                    prefixIcon: Icon(
                      Icons.person,
                      size: widthSize * iconFormSize,
                      color: Colors.white,
                    ),
                  ),
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Colors.white, fontSize: fontSizeTextFormField)),
              SizedBox(height: heightSize * spaceBetweenFieldAndButton),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Role',
                      style: TextStyle(
                          fontSize: widthSize * fontSizeTextField,
                          fontFamily: 'Poppins',
                          color: Colors.white))),
              DropDownList(),
              SizedBox(height: heightSize * spaceBetweenFieldAndButton),
              FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  padding:
                      EdgeInsets.fromLTRB(widthButton, 15, widthButton, 15),
                  color: Colors.white,
                  onPressed: () async {
                    var response = await http.post(Uri.tryParse(apiUrl),
                        headers: {"Content-Type": "application/json"},
                        body: jsonEncode({
                          "email": _emailController.text,
                          "password": _passwordController.text,
                          "fullName": _fullNameController.text,
                          "role": role
                        }));
                    var data = jsonDecode(response.body);

                    if (data["status"] == 200) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    }
                  },
                  child: Text('REGISTER',
                      style: TextStyle(
                          fontSize: widthSize * fontSizeButton,
                          fontFamily: 'Poppins',
                          color: Color.fromRGBO(41, 187, 255, 1)))),
              SizedBox(height: heightSize * 0.01),
            ])));
  }
}

class DropDownList extends StatefulWidget {
  @override
  _DropDownListState createState() => _DropDownListState();
}

class _DropDownListState extends State<DropDownList> {
  int role = 1;
  Map<String, int> listRole = {"Viewer": 1, "Blogger": 2};
  List<String> listRoleName = ["Viewer", "Blogger"];
  @override
  Widget build(BuildContext context) {
    return new DropdownButton(
        value: listRoleName[role - 1],
        items: listRoleName.map((String value) {
          return new DropdownMenuItem<String>(
            value: value,
            child: new Text(value),
          );
        }).toList(),
        onChanged: (String newValue) => {
              setState(() {
                role = listRole[newValue];
              })
            });
  }
}
