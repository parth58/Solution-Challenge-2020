import 'package:flutter/material.dart';

Widget logo(){
  return new Hero(
    tag: "logo",
    child: new CircleAvatar(
      backgroundColor: Colors.transparent,
      radius: 110.0,
      child: Image.asset('assets/app_logo.jpeg'),
    ),
  );
}