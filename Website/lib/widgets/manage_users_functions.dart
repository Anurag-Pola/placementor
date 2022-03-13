// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'custom_user.dart';
import '../firebase_options.dart';

Future<FirebaseApp?> secondaryAppGetter() async {
  try {
    return await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
      name: "SecondaryApp",
    );
  } on FirebaseException catch (e) {
    if (e.code == 'duplicate-app') {
      return Firebase.app('SecondaryApp');
    }
  } catch (e) {
    print(e);
  }
  return null;
}

Future<void> registerUserWithEmailPassword(
    QuerySnapshot<Object?> metadataQuerySnapshot) async {
  FirebaseApp? secondaryApp = await secondaryAppGetter();
  String createUsersAppScriptUrl = metadataQuerySnapshot.docs
      .firstWhere((element) => element.id == "AppScriptUrl")
      .get("createUsers")
      .toString();
  String createUsersSheetsUrl = metadataQuerySnapshot.docs
      .firstWhere((element) => element.id == "SheetsUrl")
      .get("createUsers")
      .toString();
  Uri createUsersWebAPI = Uri.parse(
      "$createUsersAppScriptUrl?CreateUsersSheetUrl=$createUsersSheetsUrl");
  final response = await http.get(
    createUsersWebAPI,
    headers: {
      "Accept": "application/json",
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Headers":
          "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
      "Access-Control-Allow-Methods": "GET"
    },
  );
  if (response.statusCode == 200) {
    print(response.body);
    final body = json.decode(response.body);
    if (body["status"] == "SUCCESS") {
      for (var eachUser in body["data"]) {
        CustomUser user = CustomUser(
            name: eachUser["name"],
            email: eachUser["email"],
            password: eachUser["password"],
            uid: null);
        print("Registering User - ${user.toString()}");
        user = await registerUser(user, secondaryApp);
        if (user.uid == null) {
          print("Cannot create user ${user.email}");
        } else {
          print(
              "Successfully created user ${user.email} with user.uid = ${user.uid}");
        }
      }
    } else {
      print("ERROR : ${body["message"]}");
    }
  } else {
    print("ERROR : ${response.statusCode}-${response.reasonPhrase}");
  }
}

Future<CustomUser> registerUser(
    CustomUser customUser, FirebaseApp? secondaryApp) async {
  try {
    FirebaseAuth _auth = FirebaseAuth.instanceFor(app: secondaryApp!);
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: customUser.email,
      password: customUser.password!,
    );
    User? user = userCredential.user;
    if (user != null) {
      user.updateDisplayName(customUser.name);
      customUser.uid = user.uid;
    }
    _auth.signOut();
  } catch (e) {
    print(e);
  }
  return customUser;
}

Future<void> deleteUserWithEmail(
    QuerySnapshot<Object?> metadataQuerySnapshot) async {
  FirebaseApp? secondaryApp = await secondaryAppGetter();
  String deleteUsersAppScriptUrl = metadataQuerySnapshot.docs
      .firstWhere((element) => element.id == "AppScriptUrl")
      .get("deleteUsers")
      .toString();
  String deleteUsersSheetsUrl = metadataQuerySnapshot.docs
      .firstWhere((element) => element.id == "SheetsUrl")
      .get("deleteUsers")
      .toString();
  Uri deleteUsersWebAPI = Uri.parse(
      "$deleteUsersAppScriptUrl?DeleteUsersSheetUrl=$deleteUsersSheetsUrl");
  final response = await http.get(
    deleteUsersWebAPI,
    headers: {
      "Accept": "application/json",
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Headers":
          "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
      "Access-Control-Allow-Methods": "GET"
    },
  );
  if (response.statusCode == 200) {
    print(response.body);
    final body = json.decode(response.body);
    if (body["status"] == "SUCCESS") {
      for (var eachUser in body["data"]) {
        CustomUser user = CustomUser(
            name: eachUser["name"],
            email: eachUser["email"],
            password: eachUser["password"],
            uid: null);
        print("Deleting User - ${user.email}");
        bool _isDeleted = await deleteUser(user, secondaryApp);
        if (_isDeleted) {
          print("Successfully deleted user ${user.email}");
        } else {
          print("Cannot delete user ${user.email}");
        }
      }
    } else {
      print("ERROR : ${body["message"]}");
    }
  } else {
    print("ERROR : ${response.statusCode}-${response.reasonPhrase}");
  }
  secondaryApp?.delete();
}

Future<bool> deleteUser(
    CustomUser customUser, FirebaseApp? secondaryApp) async {
  try {
    FirebaseAuth _auth = FirebaseAuth.instanceFor(app: secondaryApp!);
    await _auth
        .signInWithEmailAndPassword(
            email: customUser.email, password: customUser.password!)
        .then((value) async {
      await _auth.currentUser!.delete();
    });
    _auth.signOut();
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}
