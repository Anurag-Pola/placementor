import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../widgets/add_delete_admin_dialog.dart';
import '../models/custom_user.dart';
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

class StudentScreen extends StatelessWidget {
  CollectionReference studentDataCollectionRef =
      FirebaseFirestore.instance.collection('Students');

  StudentScreen({Key? key}) : super(key: key);

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
      body: FutureBuilder<QuerySnapshot<CustomStudentUser>>(
          future: _getData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) return Text(snapshot.error.toString());
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            List<CustomStudentUser> customStudentUsers =
                snapshot.data!.docs.map((doc) => doc.data()).toList();

            return Column(
              children: [
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    "TNP Coordinators",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: StudentGrid(
            height: height,
            studentUsersList: customStudentUsers,
)
                ),
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
        itemBuilder: (context, index) => StudentTile(
            studentUser: widget.studentUsersList[index]),
      ),
    );
  }
}

