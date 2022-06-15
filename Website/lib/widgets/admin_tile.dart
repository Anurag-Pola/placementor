import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:placementor_tnp/widgets/manage_users_functions.dart';

import '../models/custom_user.dart';

FirebaseAuth auth = FirebaseAuth.instance;

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

class AdminTile extends StatefulWidget {
  final CustomAdminUser adminUser;
  final CollectionReference adminDataCollectionRef;

  const AdminTile(
      {required this.adminUser, required this.adminDataCollectionRef, Key? key})
      : super(key: key);

  @override
  State<AdminTile> createState() => _AdminTileState();
}

class _AdminTileState extends State<AdminTile> {
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
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset(
                'assets/images/tnp_coordinators_image.png',
                scale: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            widget.adminUser.name!,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xff252b42),
              fontFamily: "Montserrat",
              fontWeight: FontWeight.w700,
            ),
          ),
          // const SizedBox(height: 5),
          Text(
            widget.adminUser.department!,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xff252b42),
              fontFamily: "Montserrat",
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            widget.adminUser.email!,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xff252b42),
              fontFamily: "Montserrat",
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            widget.adminUser.phone!,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xff252b42),
              fontFamily: "Montserrat",
              fontWeight: FontWeight.w700,
            ),
          ),
          if (widget.adminUser.uid != auth.currentUser!.uid)
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Delete"),
                    content: const Text(
                        "Are you sure you want to delete this T&P Coordinator?"),
                    actions: [
                      TextButton(
                        child: const Text(
                          "Delete",
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                        onPressed: () async {
                          Map<String, dynamic> _deleteActionResponseMap =
                              await deleteAdminWithEmail(
                                  widget.adminDataCollectionRef,
                                  widget.adminUser);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(_deleteActionResponseMap[
                                          "status"] ==
                                      "ERROR"
                                  ? _deleteActionResponseMap["body"]
                                  : "Successfully deleted admin ${_deleteActionResponseMap['body'].name} with uid ${_deleteActionResponseMap['body'].uid}")));

                          Navigator.pop(context);
                          setState(() {});
                        },
                      ),
                      TextButton(
                        child: const Text(
                          "Cancel",
                          style: TextStyle(
                            color: Colors.green,
                          ),
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(
                Icons.delete_rounded,
                color: Color(0xFFF44336),
              ),
            ),
        ],
      ),
    );
  }
}
