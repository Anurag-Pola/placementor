import 'package:flutter/material.dart';

import '../models/custom_user.dart';

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

class StudentTile extends StatefulWidget {
  final CustomStudentUser studentUser;

  const StudentTile({required this.studentUser, Key? key}) : super(key: key);

  @override
  State<StudentTile> createState() => _StudentTileState();
}

class _StudentTileState extends State<StudentTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        boxShadow: const [
          BoxShadow(
            color: Color(0x3f000000),
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10, bottom: 5),
            height: 100,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Image.asset(
              'assets/images/student_user.png',
              scale: 1.5,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            widget.studentUser.name!,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xff252b42),
              fontFamily: "Montserrat",
              fontWeight: FontWeight.w700,
            ),
          ),
          // const SizedBox(height: 5),

          Text(
            widget.studentUser.email,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xff252b42),
              fontFamily: "Montserrat",
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            widget.studentUser.rollNo!,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xff252b42),
              fontFamily: "Montserrat",
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
