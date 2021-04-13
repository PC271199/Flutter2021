import 'package:flutter/material.dart';
import 'widgets/register_form.dart';

class DesktopMode extends StatefulWidget {
  @override
  _DesktopModeState createState() => _DesktopModeState();
}

class _DesktopModeState extends State<DesktopMode> {
  @override
  Widget build(BuildContext context) {
    final double widthSize = MediaQuery.of(context).size.width;
    final double heightSize = MediaQuery.of(context).size.height;

    return Container(
        color: Color.fromRGBO(224, 245, 255, 1),
        child: Center(
            child: Container(
                height: heightSize * 0.9,
                width: widthSize * 0.7,
                child: Card(
                    elevation: 5,
                    child: Row(children: [
                      Expanded(
                          flex: 1,
                          child: Container(
                              child: Align(
                            alignment: Alignment.center,
                            child: Image.asset('images/login-image.png',
                                height: heightSize * 0.5,
                                width: widthSize * 0.5,
                                semanticLabel: 'test'),
                          ))),
                      Expanded(
                          flex: 1,
                          child: Container(
                              padding: EdgeInsets.only(top: 20),
                              color: Color.fromRGBO(41, 187, 255, 1),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset('images/logo.png',
                                        height: heightSize * 0.3,
                                        width: widthSize * 3),
                                    SizedBox(height: 5),
                                    RegisterForm(0, 0.009, 16, 0, 0.01, 0.02,
                                        75, 0.01, 0.007, 0.01, 0.006)
                                  ])))
                    ])))));
  }
}