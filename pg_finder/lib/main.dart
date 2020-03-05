import 'package:pg_finder/screens/wrapper.dart';
import 'package:pg_finder/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pg_finder/models/user.dart';


void main() => runApp(PGfinderApp());

class PGfinderApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}