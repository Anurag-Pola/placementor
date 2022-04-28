// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';

Future<String> createPollFunction(
    {List<String>? options, String? question, String? pollBy}) {
  CollectionReference newsfeedCollectionRef =
      FirebaseFirestore.instance.collection('Newsfeed');
  Map<String, dynamic> optionsMap = {};
  for (int i = 0; i < options!.length; i++) {
    optionsMap["$i"] = {
      "optionText": options[i],
      "selectedBy": [],
    };
  }
  print(optionsMap);
  return newsfeedCollectionRef.add({
    "content": question!,
    "postedBy": pollBy!,
    "type": "poll",
    "timestamp": DateTime.now().millisecondsSinceEpoch.toString(),
    "options": optionsMap,
  }).then((value) {
    print("Poll Doc ID: $value");
    return "SUCCESS";
  }).catchError((e) {
    print("Error: ${e.toString()}");
    return e.toString();
  });
}

Future<String> createPostFunction({String? postText, String? postBy}) {
  CollectionReference newsfeedCollectionRef =
      FirebaseFirestore.instance.collection('Newsfeed');
  return newsfeedCollectionRef.add({
    "content": postText!,
    "postedBy": postBy!,
    "type": "post",
    "readBy": [],
    "timestamp": DateTime.now().millisecondsSinceEpoch.toString(),
  }).then((value1) {
    print("Post Doc ID: $value1");
    return "SUCCESS";
  }).catchError((e) {
    print("Error: ${e.toString()}");
    return e.toString();
  });
}
