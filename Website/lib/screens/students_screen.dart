import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../widgets/add_delete_admin_dialog.dart';
import '../models/custom_user.dart';
import '../widgets/add_delete_students_dialog.dart';
import '../widgets/admin_tile.dart';
import '../widgets/student_tile.dart';

const TextStyle textStyle = TextStyle(
  color: Color(0xff252b42),
  fontSize: 14,
  fontFamily: "Poppins",
  fontWeight: FontWeight.w600,
);

const InputDecoration textFormFieldDecoration = InputDecoration(
  errorStyle: TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w100,
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(5)),
    borderSide: BorderSide(
      color: Color(0xffe5e5e5),
      width: 1,
    ),
  ),
  contentPadding: EdgeInsets.all(18),
  fillColor: Color(0xfff8f8f8),
);

class StudentsScreen extends StatelessWidget {
  CollectionReference studentDataCollectionRef =
      FirebaseFirestore.instance.collection('Students');
  CollectionReference metadataCollectionRef =
      FirebaseFirestore.instance.collection('Metadata');

  StudentsScreen({Key? key}) : super(key: key);

  Future<QuerySnapshot<CustomStudentUser>> _getData() async {
    return studentDataCollectionRef
        .withConverter<CustomStudentUser>(
          fromFirestore: (snapshot, _) =>
              CustomStudentUser.fromJSON(snapshot.data()!),
          toFirestore: (coordinator, _) => coordinator.toJSON(),
        )
        .get();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.grey.shade50,
        elevation: 0,
        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: SizedBox(
            height: 40,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "Students",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: SpeedDial(
        icon: Icons.groups_rounded,
        activeIcon: Icons.close,
        spacing: 3,
        childPadding: const EdgeInsets.all(5),
        spaceBetweenChildren: 4,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        heroTag: 'speed-dial-hero-tag',
        elevation: 8.0,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.group_remove_rounded),
            backgroundColor: Colors.deepOrange,
            foregroundColor: Colors.white,
            label: 'Delete Students',
            onTap: () async {
              Map<String, dynamic> _actionResponseMap =
                  await addDeleteStudentsDailog(context, metadataCollectionRef,
                      studentDataCollectionRef, "delete");
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
          SpeedDialChild(
            child: const Icon(Icons.group_add_rounded),
            backgroundColor: Colors.deepOrange,
            foregroundColor: Colors.white,
            label: 'Add Students',
            onTap: () async {
              Map<String, dynamic> _actionResponseMap =
                  await addDeleteStudentsDailog(context, metadataCollectionRef,
                      studentDataCollectionRef, "create");
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
      body: FutureBuilder<QuerySnapshot<CustomStudentUser>>(
          future: _getData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) return Text(snapshot.error.toString());
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            List<CustomStudentUser> customStudentUsers = snapshot.data!.docs
                .map((doc) => doc.data())
                .toList()
              ..sort((a, b) => a.rollNo!.compareTo(b.rollNo!));

            return Column(
              children: [
                Expanded(
                    child: StudentGrid(
                  height: height,
                  studentUsersList: customStudentUsers,
                )),
              ],
            );
          }),
    );
  }
}

class StudentGrid extends StatefulWidget {
  const StudentGrid({
    Key? key,
    required this.height,
    required this.studentUsersList,
  }) : super(key: key);

  final double height;
  final List<CustomStudentUser> studentUsersList;

  @override
  State<StudentGrid> createState() => _StudentGridState();
}

class _StudentGridState extends State<StudentGrid> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 400,
          childAspectRatio: 1.2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        itemCount: widget.studentUsersList.length,
        itemBuilder: (context, index) =>
            StudentTile(studentUser: widget.studentUsersList[index]),
      ),
    );
  }
}
