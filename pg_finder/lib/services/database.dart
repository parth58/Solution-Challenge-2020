import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{
  final String uid;

  DatabaseService({this.uid});

  final CollectionReference users= Firestore.instance.collection("owners");

  Future addOwnerData(fname,lname,email,phone,add1,add2,city,pincode,imageUrl)async{
    return await users.document(uid).setData({
      'firstName': fname,
      'lastName': lname,
      'email':email,
      'phone': phone,
      'address1': add1,
      'address2': add2,
      'city': city,
      'pinCode': pincode,
      'imageUrl':imageUrl,
    });
  }
}