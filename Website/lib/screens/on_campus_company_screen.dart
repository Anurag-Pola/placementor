import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../screens/on_campus_company_form.dart';
import '../widgets/on_campus_process_timeline.dart';
import '../widgets/on_campus_experience_tiles.dart';
import '../widgets/on_campus_faq_tiles.dart';
import '../widgets/on_campus_my_expandable_card.dart';
import '../widgets/on_campus_heading.dart';
import '../widgets/on_campus_previosly_placed_contact_tiles.dart';
import '../models/company_class.dart';

final firestoreInstance = FirebaseFirestore.instance.collection('Companies');

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
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 18,
                child: Image.asset(
                  'assets/Images/google_drive.png',
                ),
              ),
              onTap: () async {
                if (company.driveLink != null) {
                  final url = company.driveLink!;
                  if (await canLaunchUrlString(url)) {
                    await launchUrlString(url);
                  }
                }
              },
            ),
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
              OnCampusHeading(
                companyName: company.companyName,
                roleName: company.roleName,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: 20,
                        ),
                        child: MyExpandableCard(
                          heading: "ABOUT THE FIRM",
                          content: company.aboutTheFirm!,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: 20,
                        ),
                        child: MyExpandableCard(
                          heading: "JOB DESCRIPTION",
                          content: company.jobDescription,
                        ),
                      ),
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
                            for (var o in company.skillset!)
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
                      Container(
                        margin: const EdgeInsets.only(
                          top: 20,
                        ),
                        child: ProcessTimeline(
                          processTimeline: company.processTimeline!,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: 20,
                        ),
                        child: PrevioslyPlacedContactTiles(
                          height: height,
                          previoslyPlacedContactDetailsList:
                              company.previouslyPlacedContacts!,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: ExperienceTiles(
                          height: height,
                          experienceTilesInfo: company.experiences!,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: FAQTiles(
                          height: height,
                          faqs: company.faqs!,
                        ),
                      ),
                      const SizedBox(height: 60),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 10,
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () async {
                  final url = company.linkToApply;
                  if (await canLaunchUrlString(url)) {
                    await launchUrlString(url);
                  }
                },
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
                      colors: [
                        Color(0xff925ffc),
                        Color(0xff3b57ff),
                      ],
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
            ),
          ),
          Positioned(
            child: Container(
              margin: const EdgeInsets.all(10),
              height: 40.0,
              width: 40.0,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x3f000000),
                    blurRadius: 4,
                    offset: Offset(0, 4),
                  ),
                ],
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color(0xff925ffc),
                    Color(0xff3b57ff),
                  ],
                ),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OnCampusCompanyForm(
                        id: company.id,
                        companyName: company.companyName,
                        companyType: company.companyType!,
                        roleName: company.roleName,
                        roleType: company.roleType!,
                        jobDescription: company.jobDescription,
                        aboutTheFirm: company.aboutTheFirm!,
                        package: company.package!,
                        linkToApply: company.linkToApply,
                        driveLink: company.driveLink!,
                        lastDate: company.lastDate!,
                        eligibility: company.eligibility!,
                        skillset: company.skillset as List<String>,
                        previouslyPlacedContacts:
                            company.previouslyPlacedContacts!,
                        experiences: company.experiences!,
                        faqs: company.faqs!,
                        processTimeline: company.processTimeline!,
                      ),
                    ),
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Icon(
                      Icons.edit_rounded,
                      color: Colors.white,
                      size: 20,
                    ), // icon
                    Text(
                      "Edit",
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                      ),
                    ), // text
                  ],
                ),
              ),
            ),
            right: 0,
            top: 0,
          ),
          Positioned(
            child: Container(
              margin: const EdgeInsets.all(10),
              height: 40.0,
              width: 40.0,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x3f000000),
                    blurRadius: 4,
                    offset: Offset(0, 4),
                  ),
                ],
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color.fromARGB(255, 252, 95, 95),
                    Color.fromARGB(255, 255, 59, 59),
                  ],
                ),
              ),
              child: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Delete"),
                      content: const Text("Are you sure you want to delete?"),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "No",
                            style: TextStyle(color: Colors.green),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            firestoreInstance.doc(company.id).delete();
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Yes",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  ).then((value) => Navigator.pop(context));
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Icon(
                      Icons.delete_rounded,
                      color: Colors.white,
                      size: 20,
                    ), // icon
                    Text(
                      "Delete",
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                      ),
                    ), // text
                  ],
                ),
              ),
            ),
            right: 0,
            top: 50,
          ),
        ],
      ),
    );
  }
}
