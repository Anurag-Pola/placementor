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
    print("Tried secondary app getter");
    return await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
      name: "SecondaryApp",
    );
  } on FirebaseException catch (e) {
    if (e.code == 'duplicate-app') {
      print("Failed with duplicate app error");
      return Firebase.app('SecondaryApp');
    } else {
      rethrow;
    }
  } catch (e) {
    print("Failed with error : $e");
  }
  return null;
}

Future<void> deleteSecondaryAppInstance() async {
  try {
    print("Tried secondary app deletion");
    await Firebase.app('SecondaryApp').delete();
  } on FirebaseException catch (e) {
    if (e.code == 'app-not-found') {
      print("Failed with app not found error");
    } else {
      rethrow;
    }
  } catch (e) {
    print("Failed with error : $e");
  }
}

Future<void> registerUserWithEmailPassword(
    QuerySnapshot<Object?> metadataQuerySnapshot,
    CollectionReference studentDataCollectionRef) async {
  FirebaseApp? secondaryApp = await secondaryAppGetter();
  if (secondaryApp == null) {
    print("Failed to get secondary app");
    return;
  }
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
  print(createUsersWebAPI);
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
  print("Response status: ${response.statusCode}");
  print(response.toString());

  if (response.statusCode == 200) {
    print(response.body);
    final body = json.decode(response.body);
    if (body["status"] == "SUCCESS") {
      for (var eachUser in body["data"]) {
        CustomUser user = CustomUser(
            name: eachUser["name"],
            email: eachUser["email"],
            password: eachUser["password"],
            rollNo: eachUser["id"],
            uid: null);
        print("Registering User - ${user.toString()}");
        user = await registerUser(user, secondaryApp);
        if (user.uid == null) {
          print("Cannot create user ${user.email}");
        } else {
          String studentCreateDBStatus = await addStudentToDB(
              studentDataCollectionRef,
              name: user.name!,
              email: user.email,
              uid: user.uid!,
              rollNo: user.rollNo!);
          print(studentCreateDBStatus);
          if (studentCreateDBStatus == "SUCCESS") {
            print(
                "Successfully created user ${user.email} with user.uid = ${user.uid}");
          } else {
            print(
                "ERROR : Cannot create user ${user.email} with user.uid = ${user.uid} in DB");
          }
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

Future<String> addStudentToDB(
  CollectionReference studentDataCollectionRef, {
  required String name,
  required String email,
  required String uid,
  required String rollNo,
}) {
  return studentDataCollectionRef.doc(uid).set({
    "name": name,
    "email": email,
    "uid": uid,
    "rollNo": rollNo,
  }).then((value) {
    print("Student $rollNo created successfully on Database.");
    return "SUCCESS";
  }).catchError((e) {
    print("ERROR : $e");
    return "ERROR : $e";
  });
}

Future<String> deleteStudentFromDB(
  CollectionReference studentDataCollectionRef, {
  required String uid,
}) {
  return studentDataCollectionRef.doc(uid).delete().then((value) {
    print("Student $uid deleted successfully on Database.");
    return "SUCCESS";
  }).catchError((e) {
    print("ERROR : $e");
    return "ERROR : $e";
  });
}

Future<void> deleteUserWithEmail(QuerySnapshot<Object?> metadataQuerySnapshot,
    CollectionReference studentDataCollectionRef) async {
  FirebaseApp? secondaryApp = await secondaryAppGetter();
  if (secondaryApp == null) {
    print("Failed to get secondary app");
    return;
  }
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
            rollNo: eachUser["id"],
            uid: null);
        print("Deleting User - ${user.email}");
        var _afterDeleteResponse = await deleteUser(user, secondaryApp);
        if (_afterDeleteResponse["isDeleted"] == true) {
          user = _afterDeleteResponse["user"];
          String studentDeleteDBStatus = await deleteStudentFromDB(
              studentDataCollectionRef,
              uid: user.uid!);
          print(studentDeleteDBStatus);
          if (studentDeleteDBStatus == "SUCCESS") {
            print("Successfully deleted user ${user.email}");
          } else {
            print("ERROR : Cannot delete user ${user.email} from DB");
          }
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
}

Future<Map<String, dynamic>> deleteUser(
    CustomUser customUser, FirebaseApp? secondaryApp) async {
  try {
    FirebaseAuth _auth = FirebaseAuth.instanceFor(app: secondaryApp!);
    await _auth
        .signInWithEmailAndPassword(
            email: customUser.email, password: customUser.password!)
        .then((value) async {
      customUser.uid = value.user!.uid;
      await _auth.currentUser!.delete();
    });
    _auth.signOut();
    return {"isDeleted": true, "user": customUser};
  } catch (e) {
    print(e);
    return {"isDeleted": false, "user": customUser, "error": e};
  }
}
