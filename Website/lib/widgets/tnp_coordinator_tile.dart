import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'tnp_coordinators_class.dart';

CollectionReference<TnPCoordinator> firebasefirestoreinstance =
    FirebaseFirestore.instance
        .collection('TnPCoordinators')
        .withConverter<TnPCoordinator>(
          fromFirestore: (snapshot, _) =>
              TnPCoordinator.fromJson(snapshot.data()!),
          toFirestore: (coordinator, _) => coordinator.toJson(),
        );

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

class TnPCoordinatorTile extends StatefulWidget {
  final TnPCoordinator tnpcoordinator;

  const TnPCoordinatorTile({required this.tnpcoordinator, Key? key})
      : super(key: key);

  @override
  State<TnPCoordinatorTile> createState() => _TnPCoordinatorTileState();
}

class _TnPCoordinatorTileState extends State<TnPCoordinatorTile> {
  AlertDialog tnpCoordinatorDialog(
      BuildContext context, TnPCoordinator tnpcoordinator) {
    final TextEditingController _nameController =
        TextEditingController(text: tnpcoordinator.name);
    final TextEditingController _departmentController =
        TextEditingController(text: tnpcoordinator.department);
    final TextEditingController _emailController =
        TextEditingController(text: tnpcoordinator.email);
    final TextEditingController _phoneController =
        TextEditingController(text: tnpcoordinator.phone);

    return AlertDialog(
      title: const Text("Edit"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Edit T&P Coordinator",
            style: textStyle,
          ),
          TextFormField(
            decoration: textFormFieldDecoration.copyWith(hintText: "Name"),
            controller: _nameController,
          ),
          TextFormField(
            decoration:
                textFormFieldDecoration.copyWith(hintText: "Department"),
            controller: _departmentController,
          ),
          TextFormField(
            decoration: textFormFieldDecoration.copyWith(hintText: "Email"),
            controller: _emailController,
          ),
          TextFormField(
            decoration: textFormFieldDecoration.copyWith(hintText: "Phone"),
            controller: _phoneController,
          ),
        ],
      ),
      actions: [
        TextButton(
          child: const Text(
            "Add",
            style: TextStyle(
              color: Colors.green,
            ),
          ),
          onPressed: () {
            if (_nameController.text != '' &&
                _departmentController.text != '' &&
                _emailController.text != '' &&
                _phoneController.text != '') {
              final tnpCoordinator = TnPCoordinator.fromJson({
                'id': tnpcoordinator.id,
                'name': _nameController.text,
                'department': _departmentController.text,
                'email': _emailController.text,
                'phone': _phoneController.text,
              });
              firebasefirestoreinstance
                  .doc(tnpcoordinator.id)
                  .set(tnpCoordinator);
              _nameController.text = '';
              _departmentController.text = '';
              _emailController.text = '';
              _phoneController.text = '';
              Navigator.pop(context);
              setState(() {});
            }
          },
        ),
        TextButton(
          child: const Text(
            "Cancel",
            style: TextStyle(
              color: Colors.red,
            ),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }

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
            widget.tnpcoordinator.name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xff252b42),
              fontFamily: "Montserrat",
              fontWeight: FontWeight.w700,
            ),
          ),
          // const SizedBox(height: 5),
          Text(
            widget.tnpcoordinator.department,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xff252b42),
              fontFamily: "Montserrat",
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            widget.tnpcoordinator.email,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xff252b42),
              fontFamily: "Montserrat",
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            widget.tnpcoordinator.phone,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xff252b42),
              fontFamily: "Montserrat",
              fontWeight: FontWeight.w700,
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) =>
                        tnpCoordinatorDialog(context, widget.tnpcoordinator),
                  );
                },
                icon: const Icon(
                  Icons.edit_rounded,
                  color: Color(0xFF1B7AF3),
                ),
              ),
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
                          onPressed: () {
                            firebasefirestoreinstance
                                .doc(widget.tnpcoordinator.id)
                                .delete();
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
        ],
      ),
    );
  }
}
