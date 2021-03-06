import 'package:flutter/material.dart';
import 'dart:io' show Platform;
class CustomTextField extends StatelessWidget {

  final TextEditingController? controller;
  final IconData? data;
  final String? hintText;
  bool isObsecure = true;

  CustomTextField({this.controller,this.data,this.hintText,required this.isObsecure});

  @override
  Widget build(BuildContext context) {

    double _screenWidth = MediaQuery
    .of(context)
    .size
    .width,
    _screenHeight = MediaQuery
           .of(context)
           .size
           .height;

    return Container(
      width:Platform.isAndroid || Platform.isIOS ? _screenWidth :  _screenWidth * 0.5,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.all(10.0),
      child: TextFormField(
        controller: controller,
        obscureText:isObsecure,
        cursorColor:Theme.of(context).primaryColor,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(
            data,
            color: Colors.cyan,
          ),
          focusColor: Theme.of(context).primaryColor,
          hintText: hintText,
        ),
      ),
    );
  }
}
