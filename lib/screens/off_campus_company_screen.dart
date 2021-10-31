import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:placementor/widgets/on_campus_heading.dart';
import 'package:placementor/widgets/on_campus_my_expandable_card.dart';

class OffCampusComapnyScreen extends StatelessWidget {
  const OffCampusComapnyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
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
        actions: [
          IconButton(
            icon: const Icon(
              Icons.insert_invitation_rounded,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ],
      ),
      backgroundColor: const Color(0xFFF5F7FC),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: const [
              OnCampusHeading(
                companyName: "Yo",
              ),
              SizedBox(height: 20),
              MyExpandableCard(
                content:
                    "Can you bring creative human-centered ideas to life and make great things happen beyond what meets the eye? We believe in teamwork, fun, complex projects, diverse perspectives, and simple solutions. How about you? We're looking for a like-minded",
                heading: "DESCRIPTION",
              )
            ],
          ),
          Positioned(
            bottom: 10,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                width: 215,
                height: 52,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x3f000000),
                      blurRadius: 4,
                      offset: Offset(0, 4),
                    ),
                  ],
                  gradient: const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Color(0xff925ffc), Color(0xff3b57ff)],
                  ),
                ),
                padding: const EdgeInsets.only(
                  left: 59,
                  right: 54,
                  top: 18,
                  bottom: 19,
                ),
                child: const Text(
                  "APPLY NOW",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
