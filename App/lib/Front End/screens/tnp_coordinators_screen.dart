import 'dart:math';

import 'package:flutter/material.dart';

import '../widgets/tnp_card.dart';

class TnPCoordinatorsScreen extends StatefulWidget {
  const TnPCoordinatorsScreen({Key? key}) : super(key: key);

  @override
  _TnPCoordinatorsScreenState createState() => _TnPCoordinatorsScreenState();
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
  @override
  Widget build(BuildContext context) {
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
        body: Column(
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
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 230,
                ),
                itemCount: 11,
                itemBuilder: (context, index) => const TnPCard(),
              ),
            )
          ],
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
