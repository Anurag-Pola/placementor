import 'package:flutter/material.dart';

class StatusCard extends StatefulWidget {
  final bool isOpen;
  const StatusCard({required this.isOpen, Key? key}) : super(key: key);
  @override
  _StatusCardState createState() => _StatusCardState();
}

class _StatusCardState extends State<StatusCard> {
  @override
  Widget build(BuildContext context) {
    return ExpansionPanel(
      canTapOnHeader: true,
      headerBuilder: (context, isOpen) {
        return const ListTile(
          title: Text(
            "What does the company expect from students?",
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      },
      body: const ListTile(
        title: Text(
          "Basic knowledge on mezzanine technologies like flutter, dart and firebase.",
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      isExpanded: widget.isOpen,
    ) as Widget;
  }
}
