import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../widgets/add_delete_admin_dialog.dart';
import '../widgets/custom_user.dart';
import '../widgets/admin_tile.dart';

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

class AdminScreen extends StatelessWidget {
  CollectionReference metadataCollectionRef =
      FirebaseFirestore.instance.collection('Metadata');
  CollectionReference adminDataCollectionRef =
      FirebaseFirestore.instance.collection('Admins');
  String nameSwitchedOn = "CSE";
  List chips = [];

  Future<QuerySnapshot<CustomAdminUser>> _getData() async {
    print(chips);
    // print(['T&P'] +
    //     (((await metadataCollectionRef.doc('CollegeMetadata').get()).data()
    //         as Map<String, dynamic>?).['department']));
    // chips = ['T&P'] +
    chips = (((await metadataCollectionRef.doc('CollegeMetadata').get()).data()
        as Map<String, dynamic>?)!['department']);
    chips!.insert(0, 'T&P');
    print(chips);
    return adminDataCollectionRef
        .withConverter<CustomAdminUser>(
          fromFirestore: (snapshot, _) =>
              CustomAdminUser.fromJSON(snapshot.data()!),
          toFirestore: (coordinator, _) => coordinator.toJson(),
        )
        .get();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: FutureBuilder<QuerySnapshot<CustomAdminUser>>(
          future: _getData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) return Text(snapshot.error.toString());
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            List<CustomAdminUser> customAdminUsers =
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
                  child: AdminBranchChipsBar(
                    adminDataCollectionRef: adminDataCollectionRef,
                    customAdminUsers: customAdminUsers,
                    height: height,
                    chips: chips,
                    nameSwitchedOn: nameSwitchedOn,
                  ),
                ),
              ],
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Map<String, dynamic> _actionResponseMap = await addAdminDialog(
              context, metadataCollectionRef, adminDataCollectionRef);
          print(_actionResponseMap);
          await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _actionResponseMap["status"],
                        style: const TextStyle(color: Colors.red),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.close_rounded),
                        color: Colors.red,
                        iconSize: 20,
                        padding: const EdgeInsets.all(0),
                        splashRadius: 15,
                      ),
                    ],
                  ),
                  content: Text(_actionResponseMap["status"] == "ERROR"
                      ? _actionResponseMap["body"]
                      : "Successfully created admin ${_actionResponseMap['body'].name} with uid ${_actionResponseMap['body'].uid}"));
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class AdminGrid extends StatefulWidget {
  const AdminGrid({
    Key? key,
    required this.height,
    required this.selectedAdminUsers,
    required this.adminDataCollectionRef,
  }) : super(key: key);

  final double height;
  final List<CustomAdminUser> selectedAdminUsers;
  final CollectionReference<Object?> adminDataCollectionRef;

  @override
  State<AdminGrid> createState() => _AdminGridState();
}

class _AdminGridState extends State<AdminGrid> {
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
        itemCount: widget.selectedAdminUsers.length,
        itemBuilder: (context, index) => AdminTile(
            adminDataCollectionRef: widget.adminDataCollectionRef,
            adminUser: widget.selectedAdminUsers[index]),
      ),
    );
  }
}

class AdminChip extends StatelessWidget {
  final String name;
  final bool radioOn;
  final Function onTap;
  const AdminChip({
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

class AdminBranchChipsBar extends StatefulWidget {
  final List? chips;
  String? nameSwitchedOn;
  final List<CustomAdminUser> customAdminUsers;
  final CollectionReference adminDataCollectionRef;
  final double height;
  AdminBranchChipsBar({
    required this.chips,
    this.nameSwitchedOn,
    required this.customAdminUsers,
    required this.adminDataCollectionRef,
    required this.height,
    Key? key,
  }) : super(key: key);

  @override
  State<AdminBranchChipsBar> createState() => _AdminBranchChipsBarState();
}

class _AdminBranchChipsBarState extends State<AdminBranchChipsBar> {
  List<CustomAdminUser> selectedAdminUsers = [];
  void onChipTap(String chipValue) {
    widget.nameSwitchedOn = chipValue;
    selectedAdminUsers = widget.nameSwitchedOn == "T&P"
        ? widget.customAdminUsers
        : widget.customAdminUsers
            .where((element) => element.department == widget.nameSwitchedOn)
            .toList();
    print(selectedAdminUsers);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
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
            itemCount: widget.chips!.length,
            itemBuilder: (context, index) => AdminChip(
              name: widget.chips![index],
              radioOn: widget.nameSwitchedOn == widget.chips![index],
              onTap: () {
                setState(() {
                  // widget.nameSwitchedOn = widget.chips![index];
                  onChipTap(widget.chips![index]);
                });
              },
            ),
            scrollDirection: Axis.horizontal,
          ),
        ),
        AdminGrid(
            height: widget.height,
            selectedAdminUsers: selectedAdminUsers,
            adminDataCollectionRef: widget.adminDataCollectionRef)
      ],
    );
  }
}
