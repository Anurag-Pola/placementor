// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/manage_users_functions.dart';

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
              child: const Text("Add Users"),
              onPressed: () async {
                QuerySnapshot metadataQuerySnapshot =
                    await metadataCollectionRef.get();
                await registerUserWithEmailPassword(
                    metadataQuerySnapshot, studentDataCollectionRef);
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text("Delete Users"),
              onPressed: () async {
                QuerySnapshot metadataQuerySnapshot =
                    await metadataCollectionRef.get();
                await deleteUserWithEmail(
                    metadataQuerySnapshot, studentDataCollectionRef);
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text("Logout"),
              onPressed: () async {
                try {
                  FirebaseAuth _auth = FirebaseAuth.instance;
                  String? _userEmail = _auth.currentUser!.email.toString();
                  await _auth.signOut();
                  print("Successfully logged out $_userEmail");
                  Navigator.of(context).pushReplacementNamed('/login-screen');
                } catch (e) {
                  print(e);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
