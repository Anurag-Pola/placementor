import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final uid = FirebaseAuth.instance.currentUser!.uid;

String? getUserUID() {
  return uid;
}

Future<String?> getUserRollNo() {
  return FirebaseFirestore.instance
      .collection("Students")
      .doc(uid)
      .get()
      .then((doc) {
    return doc.data()!['rollNo'].toString();
  }).catchError((e) {
    print(e);
    return null;
  });
}

Future<String?> getUserName() {
  return FirebaseFirestore.instance
      .collection("Students")
      .doc(uid)
      .get()
      .then((doc) {
    return doc.data()!['name'].toString();
  }).catchError((e) {
    print(e);
    return null;
  });
}

Future<String?> getUserEmail() {
  return FirebaseFirestore.instance
      .collection("Students")
      .doc(uid)
      .get()
      .then((doc) {
    return doc.data()!['email'].toString();
  }).catchError((e) {
    print(e);
    return null;
  });
}
