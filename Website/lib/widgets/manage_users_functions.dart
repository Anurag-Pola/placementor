import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'custom_user.dart';
import '../firebase_options.dart';

Future<Map<String, dynamic>> secondaryAppGetter() async {
  Map<String, dynamic> _response = {"status": "SUCCESS", "body": ""};
  try {
    FirebaseApp _app = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
      name: "SecondaryApp",
    );
    _response["body"] = _app;
  } on FirebaseException catch (e) {
    if (e.code == 'duplicate-app') {
      _response["body"] = Firebase.app('SecondaryApp');
    } else {
      rethrow;
    }
  } catch (e) {
    _response["status"] = "ERROR";
    _response["body"] = e;
  }
  return _response;
}

Future<Map<String, dynamic>> deleteSecondaryAppInstance() async {
  Map<String, dynamic> _response = {"status": "SUCCESS", "body": ""};
  try {
    await Firebase.app('SecondaryApp').delete();
  } on FirebaseException catch (e) {
    if (e.code == 'app-not-found') {
      _response["status"] = "ERROR";
      _response["body"] = e.code;
    } else {
      rethrow;
    }
  } catch (e) {
    _response["status"] = "ERROR";
    _response["body"] = e;
  }
  return _response;
}

Future<Map<String, dynamic>> registerStudentWithEmailPassword(
    QuerySnapshot<Object?> metadataQuerySnapshot,
    CollectionReference studentDataCollectionRef) async {
  Map<String, dynamic> _response = {"status": "SUCCESS", "body": []};
  try {
    Map<String, dynamic> _secondaryAppResponse = await secondaryAppGetter();
    if (_secondaryAppResponse["status"] == "ERROR") {
      throw (_secondaryAppResponse["body"]);
    }
    FirebaseApp secondaryApp = _secondaryAppResponse["body"];
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

    if (response.statusCode != 200) {
      throw ("${response.statusCode} - ${response.body}");
    }
    final body = json.decode(response.body);
    if (body["status"] != "SUCCESS") {
      throw ("${body["status"]} - $body");
    }
    for (var eachUser in body["data"]) {
      CustomStudentUser user = CustomStudentUser(
          name: eachUser["name"],
          email: eachUser["email"],
          password: eachUser["password"],
          rollNo: eachUser["id"],
          uid: null);
      Map<String, dynamic> _responsePerUser = {
        "status": "SUCCESS",
        "body": "",
        "user": user
      };
      try {
        Map<String, dynamic> _resgisterUser =
            await registerStudent(user, secondaryApp);
        if (_resgisterUser["status"] == "ERROR") {
          throw (_resgisterUser["body"]);
        }
        user = _resgisterUser["body"];
        Map<String, dynamic> _studentCreateDB =
            await addStudentToDB(studentDataCollectionRef, student: user);
        if (_studentCreateDB["status"] == "ERROR") {
          throw (_studentCreateDB["body"]);
        }
      } catch (e) {
        _responsePerUser["status"] = "ERROR";
        _responsePerUser["body"] = e;
      }
      _response["body"].add(_responsePerUser);
    }
  } catch (e) {
    _response["status"] = "ERROR";
    _response["body"] = e;
  }
  return _response;
}

Future<Map<String, dynamic>> registerStudent(
    CustomStudentUser customUser, FirebaseApp? secondaryApp) async {
  Map<String, dynamic> _response = {"status": "SUCCESS", "body": ""};
  try {
    FirebaseAuth _auth = FirebaseAuth.instanceFor(app: secondaryApp!);
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: customUser.email,
      password: customUser.password!,
    );
    User? user = userCredential.user;
    if (user == null) {
      throw ("Cannot create user (returns null)");
    }

    user.updateDisplayName(customUser.name);
    customUser.uid = user.uid;

    _auth.signOut();
    _response["body"] = customUser;
  } catch (e) {
    _response["status"] = "ERROR";
    _response["body"] = e;
  }
  return _response;
}

Future<Map<String, dynamic>> addStudentToDB(
  CollectionReference studentDataCollectionRef, {
  required CustomStudentUser student,
}) {
  Map<String, dynamic> _response = {"status": "SUCCESS", "body": ""};
  return studentDataCollectionRef.doc(student.uid!).set({
    "name": student.name!,
    "email": student.email,
    "uid": student.uid!,
    "rollNo": student.rollNo!,
  }).then((value) {
    return _response;
  }).catchError((e) {
    _response["status"] = "ERROR";
    _response["body"] = e;
    return _response;
  });
}

Future<Map<String, dynamic>> deleteStudentWithEmail(
    QuerySnapshot<Object?> metadataQuerySnapshot,
    CollectionReference studentDataCollectionRef) async {
  Map<String, dynamic> _response = {"status": "SUCCESS", "body": []};
  try {
    Map<String, dynamic> _secondaryAppResponse = await secondaryAppGetter();
    if (_secondaryAppResponse["status"] == "ERROR") {
      throw (_secondaryAppResponse["body"]);
    }
    FirebaseApp secondaryApp = _secondaryAppResponse["body"];
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
    if (response.statusCode != 200) {
      throw ("${response.statusCode} - ${response.body}");
    }
    final body = json.decode(response.body);
    if (body["status"] != "SUCCESS") {
      throw ("${body["status"]} - $body");
    }
    for (var eachUser in body["data"]) {
      CustomStudentUser user = CustomStudentUser(
          name: eachUser["name"],
          email: eachUser["email"],
          password: eachUser["password"],
          rollNo: eachUser["id"],
          uid: null);
      Map<String, dynamic> _responsePerUser = {
        "status": "SUCCESS",
        "body": "",
        "user": user
      };
      try {
        var _afterDeleteResponse = await deleteStudent(user, secondaryApp);
        if (_afterDeleteResponse["status"] == "ERROR") {
          throw (_afterDeleteResponse["body"]);
        }
        user = _afterDeleteResponse["body"];
        Map<String, dynamic> studentDeleteDBMap =
            await deleteUserFromDB(studentDataCollectionRef, uid: user.uid!);
        if (studentDeleteDBMap["status"] == "ERROR") {
          throw (studentDeleteDBMap["body"]);
        }
      } catch (e) {
        _responsePerUser["status"] = "ERROR";
        _responsePerUser["body"] = e;
      }
      _response["body"].add(_responsePerUser);
    }
  } catch (e) {
    _response["status"] = "ERROR";
    _response["body"] = e;
  }
  return _response;
}

Future<Map<String, dynamic>> deleteStudent(
    CustomStudentUser customUser, FirebaseApp? secondaryApp) async {
  Map<String, dynamic> _response = {"status": "SUCCESS", "body": ""};
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
    _response["body"] = customUser;
  } catch (e) {
    _response["status"] = "ERROR";
    _response["body"] = e;
  }
  return _response;
}

Future<Map<String, dynamic>> deleteUserFromDB(
  CollectionReference usersDataCollectionRef, {
  required String uid,
}) {
  Map<String, dynamic> _response = {"status": "SUCCESS", "body": ""};
  return usersDataCollectionRef.doc(uid).delete().then((value) {
    return _response;
  }).catchError((e) {
    _response["status"] = "ERROR";
    _response["body"] = e;
    return _response;
  });
}

Future<Map<String, dynamic>> registerAdminWithEmailPassword(
    CollectionReference adminDataCollectionRef,
    CustomAdminUser adminUser) async {
  Map<String, dynamic> _response = {"status": "SUCCESS", "body": []};
  try {
    Map<String, dynamic> _secondaryAppResponse = await secondaryAppGetter();
    if (_secondaryAppResponse["status"] == "ERROR") {
      throw (_secondaryAppResponse["body"]);
    }
    FirebaseApp secondaryApp = _secondaryAppResponse["body"];

    Map<String, dynamic> _resgisterUser =
        await registerAdmin(adminUser, secondaryApp);
    if (_resgisterUser["status"] == "ERROR") {
      throw (_resgisterUser["body"]);
    }
    adminUser = _resgisterUser["body"];
    Map<String, dynamic> _adminCreateDB =
        await addAdminToDB(adminDataCollectionRef, admin: adminUser);
    if (_adminCreateDB["status"] == "ERROR") {
      throw (_adminCreateDB["body"]);
    }
    _response["body"] = adminUser;
  } catch (e) {
    _response["status"] = "ERROR";
    _response["body"] = e;
  }
  return _response;
}

Future<Map<String, dynamic>> registerAdmin(
    CustomAdminUser adminUser, FirebaseApp? secondaryApp) async {
  Map<String, dynamic> _response = {"status": "SUCCESS", "body": ""};
  try {
    FirebaseAuth _auth = FirebaseAuth.instanceFor(app: secondaryApp!);
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: adminUser.email!,
      password: adminUser.password!,
    );
    User? user = userCredential.user;
    if (user == null) {
      throw ("Cannot create user (returns null)");
    }
    user.updateDisplayName(adminUser.name);
    adminUser.uid = user.uid;
    _auth.signOut();
    _response["body"] = adminUser;
  } catch (e) {
    _response["status"] = "ERROR";
    _response["body"] = e;
  }
  return _response;
}

Future<Map<String, dynamic>> addAdminToDB(
  CollectionReference adminDataCollectionRef, {
  required CustomAdminUser admin,
}) {
  Map<String, dynamic> _response = {"status": "SUCCESS", "body": ""};
  return adminDataCollectionRef
      .doc(admin.uid!)
      .set(admin.toJson())
      .then((value) {
    return _response;
  }).catchError((e) {
    _response["status"] = "ERROR";
    _response["body"] = e;
    return _response;
  });
}

Future<Map<String, dynamic>> deleteAdminWithEmail(
    CollectionReference adminDataCollectionRef,
    CustomAdminUser adminUser) async {
  Map<String, dynamic> _response = {"status": "SUCCESS", "body": []};
  try {
    Map<String, dynamic> _secondaryAppResponse = await secondaryAppGetter();
    if (_secondaryAppResponse["status"] == "ERROR") {
      throw (_secondaryAppResponse["body"]);
    }
    FirebaseApp secondaryApp = _secondaryAppResponse["body"];
    var _afterDeleteResponse = await deleteAdmin(adminUser, secondaryApp);
    if (_afterDeleteResponse["status"] == "ERROR") {
      throw (_afterDeleteResponse["body"]);
    }
    adminUser = _afterDeleteResponse["body"];
    Map<String, dynamic> adminDeleteDBMap =
        await deleteUserFromDB(adminDataCollectionRef, uid: adminUser.uid!);
    if (adminDeleteDBMap["status"] == "ERROR") {
      throw (adminDeleteDBMap["body"]);
    }
    _response["body"] = adminUser;
  } catch (e) {
    _response["status"] = "ERROR";
    _response["body"] = e;
  }
  return _response;
}

Future<Map<String, dynamic>> deleteAdmin(
    CustomAdminUser adminUser, FirebaseApp? secondaryApp) async {
  Map<String, dynamic> _response = {"status": "SUCCESS", "body": ""};
  try {
    FirebaseAuth _auth = FirebaseAuth.instanceFor(app: secondaryApp!);
    await _auth
        .signInWithEmailAndPassword(
            email: adminUser.email!, password: adminUser.password!)
        .then((value) async {
      adminUser.uid = value.user!.uid;
      await _auth.currentUser!.delete();
    });
    _auth.signOut();
    _response["body"] = adminUser;
  } catch (e) {
    _response["status"] = "ERROR";
    _response["body"] = e;
  }
  return _response;
}
