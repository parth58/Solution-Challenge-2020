import 'dart:math';

import 'package:pg_finder/models/owner.dart';
import 'package:pg_finder/services/auth.dart';
import 'package:pg_finder/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:pg_finder/shared/logo.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:pg_finder/services/database.dart';

//
//class Register extends StatefulWidget {
//
//  final Function toggleView;
//  Register({ this.toggleView });
//
//  @override
//  _RegisterState createState() => _RegisterState();
//}
//
//class _RegisterState extends State<Register> {
//
//  final AuthService _auth = AuthService();
//  final _formKey = GlobalKey<FormState>();
//  String error = '';
//  bool loading = false;
//
//  // text field state
//  String email = '';
//  String password = '';
//  String fname='';
//  String lname='';
//  String address1='';
//  String address2='';
//  String city='';
//  String pincode='';
//
//
//
//
//  @override
//  Widget build(BuildContext context) {
//    return loading ? Loading() : Scaffold(
//      backgroundColor: Colors.blue[100],
//      appBar: AppBar(
//        backgroundColor: Colors.blue[400],
//        elevation: 0.0,
//        title: Text('Sign Up'),
//        actions: <Widget>[
//          FlatButton.icon(
//            icon: Icon(Icons.person,color: Colors.white),
//            label: Text('Sign In',style: new TextStyle(color: Colors.white)),
//            onPressed: () => widget.toggleView(),
//          ),
//        ],
//      ),
//      body: Container(
//        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
//        child: Form(
//          key: _formKey,
//          child: new SingleChildScrollView(
//            child: Column(
//              children: <Widget>[
//                SizedBox(height: 20.0),
//                logo(),
//                SizedBox(height: 20.0),
//                TextFormField(
//                  decoration: new InputDecoration(
//                      labelText: 'Email',
//                      icon: new Icon(
//                        Icons.mail,
//                        color: Colors.grey,
//                      )),
//                  validator: (val) => val.isEmpty ? 'Enter an email' : null,
//                  onChanged: (val) {
//                    setState(() => email = val);
//                  },
//                ),
//                SizedBox(height: 20.0),
//                TextFormField(
//                  decoration: new InputDecoration(
//                      labelText: 'Password',
//                      icon: new Icon(
//                        Icons.lock,
//                        color: Colors.grey,
//                      )),
//                  obscureText: true,
//                  validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
//                  onChanged: (val) {
//                    setState(() => password = val);
//                  },
//                ),
//                SizedBox(height: 20.0),
//                RaisedButton(
//                    color: Colors.blue[400],
//                    child: Text(
//                      'Register',
//                      style: TextStyle(color: Colors.white),
//                    ),
//                    onPressed: () async {
//                      if(_formKey.currentState.validate()){
//                        setState(() => loading = true);
//                        dynamic result = await _auth.registerWithEmailAndPassword(email, password);
//                        if(result is String) {
//                          setState(() {
//                            loading = false;
//                            error =result;
//                          });
//                        }
//                      }
//                    }
//                ),
//                SizedBox(height: 12.0),
//                Text(
//                  error,
//                  style: TextStyle(color: Colors.red, fontSize: 14.0),
//                ),
//
//              ],
//            ),
//            ),
//          ),
//
//        ),
//
//    );
//  }
////
//}



class Register extends StatefulWidget {
  final Function toggleView;
  Register({ this.toggleView });
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;
  bool complete = false;
  bool showImageError=false;
  int _current;

  List<StepState> _listState;

  @override
  void initState() {
    _current = 0;
    _listState = [
      StepState.indexed,
      StepState.editing,
      StepState.complete,
    ];
    super.initState();
  }

  List<Step> _createSteps(BuildContext context) {
    List<Step> _steps = <Step>[
      Step(
        title: const Text('Personal Details'),
        isActive: true,
        state: _current == 0 ? _listState[1]
        : _current > 0 ? _listState[2] : _listState[0],
        content: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                  labelText: 'First Name',
                  icon: new Icon(
                    Icons.person,
                    color: Colors.grey,
                  )
              ),
              validator: (val) => val.isEmpty ? 'Enter your First Name' : null,
              onChanged: (val) {
                setState(() => fname = val);
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                  labelText: 'Last Name',
                  icon: new Icon(
                    Icons.person,
                    color: Colors.grey,
                  )
              ),
              validator: (val) => val.isEmpty ? 'Enter your Last Name' : null,
              onChanged: (val) {
                setState(() => lname = val);
              },
            ),
          ],
        ),
      ),
      Step(
        isActive:true,
        state: _current == 1
            ? _listState[1]
            : _current > 1 ? _listState[2] : _listState[0],
        title: const Text('Contact Details'),
        content: Column(
          children: <Widget>[
            TextFormField(
              decoration: new InputDecoration(
                  labelText: 'Email',
                  icon: new Icon(
                    Icons.mail,
                    color: Colors.grey,
                  )),
              validator: (val) => val.isEmpty ? 'Enter an email' : null,
              onChanged: (val) {
                setState(() => email = val);
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                  labelText: 'Address1',
                  icon: new Icon(
                    Icons.home,
                    color: Colors.grey,
                  )
              ),
              validator: (val) => val.isEmpty ? 'Enter your Address1' : null,
              onChanged: (val) {
                setState(() => address1 = val);
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                  labelText: 'Address2',
                  icon: new Icon(
                    Icons.home,
                    color: Colors.grey,
                  )
              ),
              validator: (val) => val.isEmpty ? 'Enter your Address2' : null,
              onChanged: (val) {
                setState(() => address2 = val);
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                  labelText: 'City',
                  icon: new Icon(
                    Icons.location_city,
                    color: Colors.grey,
                  )
              ),
              validator: (val) => val.isEmpty ? 'Enter City' : null,
              onChanged: (val) {
                setState(() => city = val);
              },
            ),
            TextFormField(
              decoration: new InputDecoration(
                  labelText: "Pin Code",
                  icon: new Icon(
                    Icons.code,
                    color: Colors.grey,
                  )

              ),
              keyboardType: TextInputType.number,
              maxLength: 6,
              validator: (val) => val.isEmpty || val.length<6 ? 'Enter valid Pin Code' : null,
              onChanged: (val) {
                setState(() => pincode = val);
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                  labelText: 'Phone No.',
                  icon: new Icon(
                    Icons.phone,
                    color: Colors.grey,
                  )
              ),
              keyboardType: TextInputType.phone,
              maxLength:10 ,
              validator: (val) => val.isEmpty ? 'Enter your Phone No' : null,
              onChanged: (val) {
                setState(() =>  phone= val);
              },
            ),
          ],
        ),
      ),
      Step(
        isActive: true,
        state: _current == 2
            ? _listState[1]
            : _current > 2 ? _listState[2] : _listState[0],
        title: const Text('Profile Picture'),
        content: Column(
          children: <Widget>[
            Center(
              child: _image == null
                  ? Text('No image selected.')
                  : Image(image: FileImage(_image),height:200,width:200,fit:BoxFit.fill),
            ),
            SizedBox(height: 10,),
            FloatingActionButton(
              onPressed: getImage,
              tooltip: 'Pick Image',
              child: Icon(Icons.add_a_photo),
            ),
            SizedBox(height: 10,),
            Visibility(
              child: Text(
                'Please select Profile Picture',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              visible: showImageError,
            ),
          ],
        ),
      ),
      Step(
        isActive:true,
        state: _current == 3
            ? _listState[1]
            : _current > 3 ? _listState[2] : _listState[0],
        title: const Text('Set Password'),
        content: Column(
          children: <Widget>[
            TextFormField(
              decoration: new InputDecoration(
                  labelText: 'Password',
                  icon: new Icon(
                    Icons.lock,
                    color: Colors.grey,
                  )),
              obscureText: true,
              validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
              onChanged: (val) {
                setState(() =>  password= val);
              },
            ), TextFormField(
              decoration: new InputDecoration(
                  labelText: 'Confirm Password',
                  icon: new Icon(
                    Icons.lock,
                    color: Colors.grey,
                  )),
              obscureText: true,
              validator: (val) => val.isEmpty || password!=val? 'Password Does Not Match!' : null,
              onChanged: (val) {
                setState(() =>  cpassword= val);
              },
            ),
          ],
        ),
      ),
    ];
    return _steps;
  }
  // text field state
  String email = '';
  String password = '';
  String fname='';
  String lname='';
  String address1='';
  String address2='';
  String city='';
  String pincode='';
  String phone='';
  String cpassword = '';
  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
      showImageError = false;
    });
  }


  @override
  Widget build(BuildContext context) {

    List<Step> _stepList=_createSteps(context);
    Future<String> uploadImage(BuildContext context,String uid) async{
      String fileName=uid+"-"+basename(_image.path);
      StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(fileName);
      StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    }

    void _submit() async{
      setState(() => loading = true);
      if(_formKey.currentState.validate()){
        setState(() => loading = true);
        if(_image != null) {
          _formKey.currentState.save();
//          dynamic result = await _auth.registerWithEmailAndPassword(email, password);

           _auth.registerWithEmailAndPassword(email, password).then((result) async{
             if(result is String) {
               setState(() {
                 loading = false;
                 error =result;
               });
             }else{

               await uploadImage(context,result.uid).then((imageUrl){
                 DatabaseService().addOwnerData(fname,lname,email,phone,address1,address2,city,pincode,imageUrl).then((value){
                   loading = false;
                   print(value);
                 });
               });

             }
           });

        }
      }
      if(_image == null) {
        setState((){
          showImageError = true;
          loading=false;
        });
      }
    }

    return loading?Loading(): Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        elevation: 0.0,
        title: Text('Sign Up'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person,color: Colors.white),
            label: Text('Sign In',style: new TextStyle(color: Colors.white)),
            onPressed: () => widget.toggleView(),
          ),
        ],
      ),

    body:new Column(children: <Widget>[
          Expanded(
            child: Form(
       key: _formKey,
         child:Stepper(
              controlsBuilder:
                  (BuildContext context, {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
                return Padding(
                  padding: EdgeInsets.all(24),
                  child: Row(
                    children: <Widget>[
                      FlatButton(
                        color: Colors.blue,
                        onPressed: onStepContinue,
                        child: _current==3 ?Text('Submit',style: TextStyle(color: Colors.white),):Text('Next',style: TextStyle(color: Colors.white),),

                      ),
                      Padding(padding: EdgeInsets.only(right: 8),),
                      FlatButton(
                        color: Colors.blue,
                        onPressed:_current ==0 ? null :onStepCancel  ,
                        child: const Text('Back',style: TextStyle(color: Colors.white),),
                        disabledColor: Colors.blue[100],
                      ),
                    ],
                  )
                );
              },
              type: StepperType.vertical,
              steps:_stepList,
              currentStep: _current,

              onStepContinue: () {
                setState(() {
                  if (_current < _stepList.length - 1) {
                    _current++;
                  } else {
                    _submit();
                  }
                  //_setStep(context);
                });
              },
              onStepCancel: () {
                setState(() {
                  if (_current > 0) {
                    _current--;
                  } else {
                    _current = 0;
                  }
                  //_setStep(context);
                });
              },
              onStepTapped: (int i) {
                setState(() {
                  _current = i;
                });
              },

            ),

          ),
          ),
           SizedBox(height: 12.0),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                ),
        ]
        )
    );
  }



}
