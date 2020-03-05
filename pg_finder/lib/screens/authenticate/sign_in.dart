import 'package:pg_finder/services/auth.dart';
import 'package:pg_finder/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:pg_finder/shared/logo.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({ this.toggleView });

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        elevation: 0.0,
        title: Text('Sign In'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person,color: Colors.white),
            label: Text('Register',style: new TextStyle(color: Colors.white)),
            onPressed: () => widget.toggleView(),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: new SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                logo(),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: new InputDecoration(
                      labelText: 'Email',
                      hintText: 'Email',
                      icon: new Icon(
                        Icons.mail,
                        color: Colors.grey,
                      )),
                  validator: (val) => val.isEmpty ? 'Enter an email' : null,
                  onChanged: (val) {
                    setState(() => email = val);
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: new InputDecoration(
                      labelText: 'Password',
                      hintText: 'Password',
                      icon: new Icon(
                        Icons.lock,
                        color: Colors.grey,
                      )),
                  obscureText: true,
                  validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
                  onChanged: (val) {
                    setState(() => password = val);
                  },
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                    color: Colors.blue[400],
                    child: Text(
                      'Sign In',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if(_formKey.currentState.validate()){
                        setState(() => loading = true);
                        dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                        if(result == null) {
                          setState(() {
                            loading = false;
                            error = 'Could not sign in with those credentials';
                          });
                        }
                      }
                    }
                ),
                SizedBox(height: 12.0),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}