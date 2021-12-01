import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:placementor/widgets/on_campus_process_timeline.dart';

import '../widgets/on_campus_experience_tiles.dart';
import '../widgets/on_campus_faq_tiles.dart';
import '../widgets/on_campus_my_expandable_card.dart';
import '../widgets/on_campus_heading.dart';
import '../widgets/on_campus_previosly_placed_contact_tiles.dart';
import '../widgets/company_class.dart';

class OnCampusComapnyScreen extends StatelessWidget {
  const OnCampusComapnyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    final company = ModalRoute.of(context)!.settings.arguments as Company;
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
          GestureDetector(
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 18,
              child: Image.asset(
                'assets/images/google_drive.png',
              ),
            ),
            onTap: () {},
          ),
          const SizedBox(width: 10),
          GestureDetector(
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 18,
              child: Image.asset(
                'assets/images/calander.png',
              ),
            ),
            onTap: () {},
          ),
          const SizedBox(width: 5),
        ],
      ),
      backgroundColor: const Color(0xFFF5F7FC),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              OnCampusHeading(companyName: company.companyName),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const MyExpandableCard(
                        heading: "ABOUT THE FIRM",
                        content:
                            "Can you bring creative human-centered ideas to life and make great things happen beyond what meets the eye? We believe in teamwork, fun, complex projects, diverse perspectives, and simple solutions. How about you? We're looking for a like-minded",
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const MyExpandableCard(
                        heading: "JOB DESCRIPTION",
                        content:
                            "Can you bring creative human-centered ideas to life and make great things happen beyond what meets the eye? We believe in teamwork, fun, complex projects, diverse perspectives, and simple solutions. How about you? We're looking for a like-minded",
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        color: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            const Opacity(
                              opacity: 0.75,
                              child: Text(
                                "SKILLSET REQUIRED",
                                style: TextStyle(
                                  color: Color(0xff18191e),
                                  fontSize: 13,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.75,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            for (var o in [
                              "Python",
                              "Flutter",
                              "Firebase",
                              "Spring Boot"
                            ])
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const Text("• "),
                                  Expanded(
                                    child: Text(o),
                                  )
                                ],
                              ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ProcessTimeline(),
                      const SizedBox(height: 20),
                      PrevioslyPlacedContactTiles(
                        height: height,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ExperienceTiles(
                        height: height,
                      ),
                      const SizedBox(height: 20),
                      FAQTiles(height: height),
                      const SizedBox(height: 60),
                    ],
                  ),
                ),
              ),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                child: const Center(
                  child: Text(
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
            ),
          )
        ],
      ),
    );
  }
}
