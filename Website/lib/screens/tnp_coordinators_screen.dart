import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:placementor_tnp/widgets/tnp_coordinators_class.dart';

import '../widgets/tnp_coordinator_tile.dart';

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

class TnPCoordinatorsScreen extends StatefulWidget {
  const TnPCoordinatorsScreen({Key? key}) : super(key: key);

  @override
  State<TnPCoordinatorsScreen> createState() => _TnPCoordinatorsScreenState();
}

class _TnPCoordinatorsScreenState extends State<TnPCoordinatorsScreen> {
  String nameSwitchedOn = "T&P";
  List<String> chips = [
    "T&P",
    "AE",
    "CE",
    "CSE",
    "ECE",
    "EIE",
    "EEE",
    "IT",
    "ME"
  ];

  AlertDialog tnpCoordinatorDialog(BuildContext context) {
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _departmentController = TextEditingController();
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _phoneController = TextEditingController();

    return AlertDialog(
      title: const Text("Add"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Add T&P Coordinator",
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
              final id = DateTime.now().millisecondsSinceEpoch.toString();
              final tnpCoordinator = TnPCoordinator.fromJson({
                'id': id,
                'name': _nameController.text,
                'department': _departmentController.text,
                'email': _emailController.text,
                'phone': _phoneController.text,
              });
              firebasefirestoreinstance.doc(id).set(tnpCoordinator);
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
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: FutureBuilder<QuerySnapshot<TnPCoordinator>>(
          future: firebasefirestoreinstance.get(),
          builder: (context, snapshot) {
            if (snapshot.hasError) return const Text('Something went wrong');
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            List<TnPCoordinator> tnpcoordinators =
                snapshot.data!.docs.map((doc) => doc.data()).toList();
            return ListView(
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
                Container(
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x3f000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                      ),
                    ],
                    color: Colors.white,
                  ),
                  height: 45,
                  child: ListView.builder(
                    itemCount: chips.length,
                    itemBuilder: (context, index) => TnPBranchChip(
                      name: chips[index],
                      radioOn: nameSwitchedOn == chips[index],
                      onTap: () {
                        setState(() {
                          nameSwitchedOn = chips[index];
                        });
                      },
                    ),
                    scrollDirection: Axis.horizontal,
                  ),
                ),
                SizedBox(
                  height: height,
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 400,
                      childAspectRatio: 1.2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                    ),
                    itemCount: nameSwitchedOn == "T&P"
                        ? tnpcoordinators.length
                        : tnpcoordinators
                            .where((element) =>
                                element.department == nameSwitchedOn)
                            .length,
                    itemBuilder: (context, index) => TnPCoordinatorTile(
                        tnpcoordinator: nameSwitchedOn == "T&P"
                            ? tnpcoordinators[index]
                            : tnpcoordinators
                                .where((element) =>
                                    element.department == nameSwitchedOn)
                                .toList()[index]),
                  ),
                )
              ],
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => tnpCoordinatorDialog(
              context,
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TnPBranchChip extends StatelessWidget {
  final String name;
  final bool radioOn;
  final Function onTap;
  const TnPBranchChip({
    required this.name,
    this.radioOn = false,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double safeAreaHeight = MediaQuery.of(context).padding.top;
    double height = MediaQuery.of(context).size.height - safeAreaHeight;
    double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () => {onTap()},
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        // width: 50,
        height: height * 0.041,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: const Color(0xFFF5F7FC),
          gradient: radioOn
              ? const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xff00a3ff), Color(0x8e3970ff)],
                )
              : const LinearGradient(
                  colors: [Color(0xFFF5F7FC), Color(0xFFF5F7FC)]),
        ),
        padding: EdgeInsets.only(
          left: min(height, width) * 0.045,
          right: min(height, width) * 0.045,
        ),
        child: Center(
          child: Text(
            name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
