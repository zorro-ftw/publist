import 'package:flutter/material.dart';

const kSendButtonTextStyle = TextStyle(
  color: kMainThemeColor,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const defaultTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 25.0,
  fontWeight: FontWeight.w700,
);
const fadeTextStyle = TextStyle(
  color: Colors.grey,
  fontSize: 18.0,
  fontWeight: FontWeight.w500,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.red , width: 2.0),
  ),
);

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter a value',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFFCE9F35), width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.orange, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

const kDivider = Divider(
  color: Color(0xFFBDBDBD),
  height: 10,
  thickness: 2,
  indent: 10,
  endIndent: 10,
);

const kMainThemeColor = Color(0xFFCE9F35);

const kDisabledButtonFillColor = Color(0xFF9B9B9B);
