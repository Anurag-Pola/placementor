// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../widgets/add_delete_students_dialog.dart';

class ManageUsers extends StatefulWidget {
  const ManageUsers({Key? key}) : super(key: key);

  @override
  _ManageUsersState createState() => _ManageUsersState();
}

class _ManageUsersState extends State<ManageUsers> {
  CollectionReference metadataCollectionRef =
      FirebaseFirestore.instance.collection('Metadata');
  CollectionReference studentDataCollectionRef =
      FirebaseFirestore.instance.collection('Students');
  CollectionReference adminDataCollectionRef =
      FirebaseFirestore.instance.collection('Admins');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Users'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text("Add Students"),
              onPressed: () async {
                Map<String, dynamic> _actionResponseMap =
                    await addDeleteStudentsDailog(
                        context,
                        metadataCollectionRef,
                        studentDataCollectionRef,
                        "create");
                print(_actionResponseMap);
                if (_actionResponseMap["status"] == "SUCCESS") {
                  await showActionSummaryDialog(
                      context, _actionResponseMap["body"]);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                          "${_actionResponseMap["status"]} : ${_actionResponseMap["body"]}")));
                }
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text("Delete Students"),
              onPressed: () async {
                Map<String, dynamic> _actionResponseMap =
                    await addDeleteStudentsDailog(
                        context,
                        metadataCollectionRef,
                        studentDataCollectionRef,
                        "delete");
                print(_actionResponseMap);
                if (_actionResponseMap["status"] == "SUCCESS") {
                  await showActionSummaryDialog(
                      context, _actionResponseMap["body"]);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                          "${_actionResponseMap["status"]} : ${_actionResponseMap["body"]}")));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
