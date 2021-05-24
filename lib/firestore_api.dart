// import 'package:cloud_firestore/cloud_firestore.dart';
// class FirestoreApi {
//
//   FirebaseFirestore firestore;
//
//   init() {
//     firestore = FirebaseFirestore.instance;
//   }
//
//   Future<DocumentReference> addData(Map<String, dynamic> data) async {
//     init();
//     DocumentReference ref = await firestore.collection('numbers').add(data);
//     return ref;
//   }
//
//   // Future<List<Map<String, dynamic>>> readAllData() async {
//   //   init();
//   //   String userId = (await services.Authentication.anonymousLoginOrGetUser()).userId;
//   //   QuerySnapshot snapshot = await firestore.collection('translations').where('userId', isEqualTo: userId).get();
//   //   List<Map<String, dynamic>> translations = snapshot.docs.map((e) => e.data()).toList();
//   //   return translations;
//   //
//   // }
//
// }

import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreApi {

  FirebaseFirestore firestore;

  init() {
    firestore = FirebaseFirestore.instance;
  }

  Future<DocumentReference> addData(Map<String, dynamic> data) async {
    init();
    DocumentReference ref = await firestore.collection('randomNumbers').add(data);
    return ref;
  }

  Future<List<Object>> readAllData() async {
    init();
    QuerySnapshot snapshot = await firestore.collection('randomNumbers').get();
    List<Object> randomNumbers = snapshot.docs.map((e) => e.data()).toList();
    return randomNumbers;

  }


}