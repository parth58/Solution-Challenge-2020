import 'package:flutter/material.dart';
import 'package:pg_finder/services/auth.dart';
import 'package:pg_finder/screens/owner/addDeatails.dart';

class HomePage extends StatefulWidget{
  State<StatefulWidget> createState(){
    return _HomePageState();
  }
}
class _HomePageState extends State<HomePage> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Home"),
      ),
      body: new Container(

      ),
      bottomNavigationBar: new BottomAppBar(
        color: Colors.blue,
        child: new Container(
          margin: const EdgeInsets.only(left: 70.0,right: 70.0),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[

              new IconButton(
                  icon: new Icon(Icons.add_box),
                  iconSize: 50,
                  color: Colors.white,
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => OwnerDetailsFormPage()),
                    );
                  }
              ),
              new IconButton(
                icon: new Icon(Icons.exit_to_app),
                iconSize: 50,
                color: Colors.white,
                onPressed:  () async {
                  await _auth.signOut();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}