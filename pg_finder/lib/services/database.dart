import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{
  final CollectionReference flats= Firestore.instance.collection("flats");
}