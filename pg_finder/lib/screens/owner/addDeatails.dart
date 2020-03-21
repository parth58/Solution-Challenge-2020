import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class OwnerDetailsFormPage extends StatefulWidget {
  _OwnerDetailsFormState createState() => _OwnerDetailsFormState();
}

class _OwnerDetailsFormState extends State<OwnerDetailsFormPage> {


  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }


  int currentStep = 0;
  bool complete = false;
  String error = '';
  bool loading = false;

  // text field state
  String email = '';
  String password = '';
  String cpassword = '';
  String fname='';
  String lname='';
  String address1='';
  String address2='';
  String city='';
  String pincode='';
  String phone='';



  @override
  Widget build(BuildContext context) {



    List<Step> steps = [
      Step(
        title: const Text('Personal Details'),
        isActive: true,
        state: StepState.complete,
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
          ],
        ),
      ),
      Step(
        isActive: false,
        state: StepState.editing,
        title: const Text('Contact Details'),
        content: Column(
          children: <Widget>[
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
        isActive: false,
        state: StepState.editing,
        title: const Text('Profile Picture'),
        content: Column(
          children: <Widget>[
            Center(
              child: _image == null
                  ? Text('No image selected.')
                  : Image(image: FileImage(_image),height: 150,width: 150,),
            ),
            FloatingActionButton(
              onPressed: getImage,
              tooltip: 'Pick Image',
              child: Icon(Icons.add_a_photo),
            ),
          ],
        ),
      ),
      Step(
        isActive: false,
        state: StepState.editing,
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
              validator: (val) => password!=val? 'Password Does Not Match!' : null,
              onChanged: (val) {
                setState(() =>  cpassword= val);
              },
            ),
          ],
        ),
      ),
    ];
    goTo(int step) {
      setState(() => currentStep = step);
    }
    next() {

      currentStep + 1 != steps.length
          ? goTo(currentStep + 1)
          : setState(() => complete = true);
    }

    cancel() {
      if (currentStep > 0) {
        goTo(currentStep - 1);
      }
    }



    return new Scaffold(
        appBar: AppBar(
          title: Text('Add Details'),
        ),
        body:new Column(children: <Widget>[
          Expanded(
            child: Stepper(
              steps: steps,
              currentStep: currentStep,
              onStepContinue: next,
              onStepTapped: (step) => goTo(step),
              onStepCancel: cancel,
            ),
          ),
        ]));
  }
}
