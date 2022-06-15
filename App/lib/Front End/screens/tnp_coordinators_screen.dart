import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/tnp_coordinators_class.dart';
import '../widgets/tnp_coordinator_tile.dart';

CollectionReference<TnPCoordinator> firebasefirestoreinstance =
    FirebaseFirestore.instance
        .collection('TnPCoordinators')
        .withConverter<TnPCoordinator>(
          fromFirestore: (snapshot, _) =>
              TnPCoordinator.fromJSON(snapshot.data()!),
          toFirestore: (coordinator, _) => coordinator.toJson(),
        );

class TnPCoordinatorsScreen extends StatelessWidget {
  CollectionReference metadataCollectionRef =
      FirebaseFirestore.instance.collection('Metadata');
  CollectionReference adminDataCollectionRef =
      FirebaseFirestore.instance.collection('Admins');
  String nameSwitchedOn = "T&P";
  List chips = [];

  TnPCoordinatorsScreen({Key? key}) : super(key: key);

  Future<QuerySnapshot<TnPCoordinator>> _getData() async {
    chips = (((await metadataCollectionRef.doc('CollegeMetadata').get()).data()
        as Map<String, dynamic>?)!['department']);
    chips.sort();
    chips.insert(0, 'T&P');
    return adminDataCollectionRef
        .withConverter<TnPCoordinator>(
          fromFirestore: (snapshot, _) =>
              TnPCoordinator.fromJSON(snapshot.data()!),
          toFirestore: (coordinator, _) => coordinator.toJson(),
        )
        .get();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F7FC),
        appBar: AppBar(
          backgroundColor: const Color(0xFFF5F7FC),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: FutureBuilder<QuerySnapshot<TnPCoordinator>>(
          future: _getData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) return const Text('Something went wrong');
            if (snapshot.hasData) {
              List<TnPCoordinator> tnpcoordinators =
                  snapshot.data!.docs.map((doc) => doc.data()).toList();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: SizedBox(
                      height: 50,
                      child: Text(
                        "T&P Coordinators",
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
                  Expanded(
                    child: TnpChipsBarAndGrid(
                        chips: chips,
                        height: height,
                        customAdminUsers: tnpcoordinators,
                        nameSwitchedOn: nameSwitchedOn),
                  ),
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}

class TnpChipsBarAndGrid extends StatefulWidget {
  final List? chips;
  String? nameSwitchedOn;
  final List<TnPCoordinator> customAdminUsers;
  final double height;

  TnpChipsBarAndGrid({
    required this.chips,
    required this.height,
    this.nameSwitchedOn,
    required this.customAdminUsers,
    Key? key,
  }) : super(key: key);
  @override
  State<TnpChipsBarAndGrid> createState() => _TnpChipsBarAndGridState();
}

class _TnpChipsBarAndGridState extends State<TnpChipsBarAndGrid> {
  List<TnPCoordinator> selectedAdminUsers = [];
  void onChipTap(String chipValue) {
    widget.nameSwitchedOn = chipValue;
    selectedAdminUsers = widget.nameSwitchedOn == "T&P"
        ? widget.customAdminUsers
        : widget.customAdminUsers
            .where((element) => element.department == widget.nameSwitchedOn)
            .toList();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.nameSwitchedOn == "T&P") {
      selectedAdminUsers = widget.customAdminUsers;
    }
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
            itemBuilder: (context, index) => TnPBranchChip(
              name: widget.chips![index],
              radioOn: widget.nameSwitchedOn == widget.chips![index],
              onTap: () {
                setState(() {
                  onChipTap(widget.chips![index]);
                });
              },
            ),
            scrollDirection: Axis.horizontal,
          ),
        ),
        TnpGrid(selectedAdminUsers: selectedAdminUsers, height: widget.height),
      ],
    );
  }
}

class TnpGrid extends StatefulWidget {
  const TnpGrid({
    Key? key,
    required this.selectedAdminUsers,
    required this.height,
  }) : super(key: key);

  final List<TnPCoordinator> selectedAdminUsers;
  final double height;

  @override
  State<TnpGrid> createState() => _TnpGridState();
}

class _TnpGridState extends State<TnpGrid> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 230,
        ),
        itemCount: widget.selectedAdminUsers.length,
        itemBuilder: (context, index) => TnPCoordinatorTile(
          tnpcoordinator: widget.selectedAdminUsers[index],
        ),
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
