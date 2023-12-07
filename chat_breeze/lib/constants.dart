import 'package:flutter/material.dart';

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  filled: true,
  fillColor: Color(0xFFffe8d6),
  contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
  hintText: 'Message',
  border:
      OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(32.0))),
);

const kMessageContainerDecoration = BoxDecoration(
    // color: Colors.grey,
    //
    // border: Border(
    //   top: BorderSide(color: Colors.grey, width: 2.0),
    // ),
    );

const kTextFieldDecaration = InputDecoration(
  hintText: 'Enter your value',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
