import 'package:flutter/material.dart';

import '../../widgets/company_class.dart';
import '../../widgets/experience_tile_class.dart';
import '../../widgets/faq_tiles_class.dart';
import '../../widgets/previosly_placed_contact_details_class.dart';
import '../../widgets/process_timeline_class.dart';

import '../../widgets/on_campus_company_tile.dart';
import '../../widgets/off_campus_company_tile.dart';

const companies = [
  Company(
    companyName: "Google",
    companyType: "Product",
    roleName: "Software Engineer",
    aboutTheFirm:
        "Can you bring creative human-centered ideas to life and make great things happen beyond what meets the eye? We believe in teamwork, fun, complex projects, diverse perspectives, and simple solutions. How about you? We're looking for a like-minded",
    jobDescription:
        "Can you bring creative human-centered ideas to life and make great things happen beyond what meets the eye? We believe in teamwork, fun, complex projects, diverse perspectives, and simple solutions. How about you? We're looking for a like-minded",
    skillset: ["Python", "Flutter", "Dart", "Go", "R"],
    processTimeline: ProcessTimelineClass(
      steps: [1, 2, 3, 4],
      dates: ["28/11/20", "28/11/21", "28/11/20", "28/11/20"],
      descriptions: [
        "The application is to be done from the provided URL",
        "A test is put on HackerRank platform which consists of 30 aptitude and 2 coding questions with a timeframe of 1 hour ",
        "An interiew is conducted for 1 hour which consists of technical,managerial and hr related questions",
        "Voila You got the job",
      ],
      //   [ProcessTimelineClass(step: 1, title: "Application", date: "28/11/20", description: "The application is to be done from the provided URL",),
      // ProcessTimelineClass(step: 2, title: "Online Test", date: "28/11/20", description: "A test is put on HackerRank platform which consists of 30 aptitude and 2 coding questions with a timeframe of 1 hour ",),
      // ProcessTimelineClass(step: 3, title: "Interview", date: "28/11/20", description: "An interiew is conducted for 1 hour which consists of technical,managerial and hr related questions",),
      // ProcessTimelineClass(step: 4, title: "Offer", date: "28/11/20", description: "An offer is given to the candidate",),
      // ]
      names: ["Application", "Online Test", "Interview", "Results"],
    ),
    previouslyPlacedContactDetails: [
      PreviouslyPlacedContactDetailsClass(
          name: "Name",
          batch: "batch",
          email: "email",
          phone: "phone",
          linkedin: "linkedin"),
      PreviouslyPlacedContactDetailsClass(
          name: "Name",
          batch: "batch",
          email: "email",
          phone: "phone",
          linkedin: "linkedin"),
      PreviouslyPlacedContactDetailsClass(
          name: "Name",
          batch: "batch",
          email: "email",
          phone: "phone",
          linkedin: "linkedin"),
    ],
    experienceTilesInfo: [
      ExperienceTileClass(
        experience:
            "Slate helps you see how many more days you need to work to reach your financial goal.Slate helps you see how many more days you need to work to reach your financial goal.Slate helps you see how many more days you need to work to reach your financial goal.",
        name: "Andrew Garfield",
        batch: "2018-2022",
      ),
      ExperienceTileClass(
        experience:
            "Slate helps you see how many more days you need to work to reach your financial goal.Slate helps you see how many more days you need to work to reach your financial goal.Slate helps you see how many more days you need to work to reach your financial goal.",
        name: "Andrew Garfield",
        batch: "2018-2022",
      ),
      ExperienceTileClass(
        experience:
            "Slate helps you see how many more days you need to work to reach your financial goal.Slate helps you see how many more days you need to work to reach your financial goal.Slate helps you see how many more days you need to work to reach your financial goal.",
        name: "Andrew Garfield",
        batch: "2018-2022",
      ),
      ExperienceTileClass(
        experience:
            "Slate helps you see how many more days you need to work to reach your financial goal.Slate helps you see how many more days you need to work to reach your financial goal.Slate helps you see how many more days you need to work to reach your financial goal.",
        name: "Andrew Garfield",
        batch: "2018-2022",
      ),
    ],
    faqTilesInfo: [
      FAQTilesClass(
        question: "What does the company expect from students?",
        answer:
            "Basic knowledge on mezzanine technologies like flutter, dart and firebase.",
      ),
      FAQTilesClass(
        question: "What does the company expect from student?",
        answer:
            "Basic knowledge on mezzanine technologies like flutter, dart and firebase.",
      ),
      FAQTilesClass(
        question: "What does the company expect from studen?",
        answer:
            "Basic knowledge on mezzanine technologies like flutter, dart and firebase.",
      ),
      FAQTilesClass(
        question: "What does the company expect from stud?",
        answer:
            "Basic knowledge on mezzanine technologies like flutter, dart and firebase.",
      ),
    ],
    roleType: "Full Time",
    lastDate: "28/11/2022",
    salary: "10 LPA",
    linkToApply: "www.google.com",
    driveLink: "www.google.com",
    eligibility: "CGPA -7.5 and no backlogs",
  ),
  Company(
    companyName: "Amazon",
    companyType: "Product",
    roleName: "Manager",
    aboutTheFirm:
        "Can you bring creative human-centered ideas to life and make great things happen beyond what meets the eye? We believe in teamwork, fun, complex projects, diverse perspectives, and simple solutions. How about you? We're looking for a like-minded",
    jobDescription:
        "Can you bring creative human-centered ideas to life and make great things happen beyond what meets the eye? We believe in teamwork, fun, complex projects, diverse perspectives, and simple solutions. How about you? We're looking for a like-minded",
    skillset: ["Python", "Flutter", "Dart", "Java", "C++"],
    processTimeline: ProcessTimelineClass(
      steps: [1, 2, 3, 4],
      dates: ["28/11/20", "28/11/20", "28/11/20", "28/11/20"],
      descriptions: [
        "The application is to be done from the provided URL",
        "A test is put on HackerRank platform which consists of 30 aptitude and 2 coding questions with a timeframe of 1 hour ",
        "An interiew is conducted for 1 hour which consists of technical,managerial and hr related questions",
        "Voila You got the job",
      ],
      names: ["Application", "Online Test", "Interview", "Results"],
    ),
    previouslyPlacedContactDetails: [
      PreviouslyPlacedContactDetailsClass(
          name: "Name",
          batch: "batch",
          email: "email",
          phone: "phone",
          linkedin: "linkedin"),
    ],
    experienceTilesInfo: [
      ExperienceTileClass(
        experience:
            "Slate helps you see how many more days you need to work to reach your financial goal.Slate helps you see how many more days you need to work to reach your financial goal.Slate helps you see how many more days you need to work to reach your financial goal.",
        name: "Andrew Garfield",
        batch: "2018-2022",
      ),
    ],
    faqTilesInfo: [
      FAQTilesClass(
          question: "What does the company expect from students?",
          answer:
              "Basic knowledge on mezzanine technologies like flutter, dart and firebase."),
    ],
    roleType: "Full Time",
    lastDate: "28/11/2022",
    salary: "10 LPA",
    linkToApply: "www.google.com",
    driveLink: "www.google.com",
    eligibility: "CGPA -7.5 and atmost 1 backlog",
  ),
  Company(
    companyName: "Microsoft",
    companyType: "Product",
    roleName: "Junior Developer",
    aboutTheFirm:
        "Can you bring creative human-centered ideas to life and make great things happen beyond what meets the eye? We believe in teamwork, fun, complex projects, diverse perspectives, and simple solutions. How about you? We're looking for a like-minded",
    jobDescription:
        "Can you bring creative human-centered ideas to life and make great things happen beyond what meets the eye? We believe in teamwork, fun, complex projects, diverse perspectives, and simple solutions. How about you? We're looking for a like-minded",
    skillset: ["Python", "Flutter", "Dart", "Java", "C++"],
    processTimeline: ProcessTimelineClass(
      steps: [1, 2, 3, 4],
      dates: ["28/11/20", "28/11/20", "28/11/20", "28/11/20"],
      descriptions: [
        "The application is to be done from the provided URL",
        "A test is put on HackerRank platform which consists of 30 aptitude and 2 coding questions with a timeframe of 1 hour ",
        "An interiew is conducted for 1 hour which consists of technical,managerial and hr related questions",
        "Voila You got the job",
      ],
      names: ["Application", "Online Test", "Interview", "Results"],
    ),
    previouslyPlacedContactDetails: [
      PreviouslyPlacedContactDetailsClass(
          name: "Name",
          batch: "batch",
          email: "email",
          phone: "phone",
          linkedin: "linkedin"),
    ],
    experienceTilesInfo: [
      ExperienceTileClass(
        experience:
            "Slate helps you see how many more days you need to work to reach your financial goal.Slate helps you see how many more days you need to work to reach your financial goal.Slate helps you see how many more days you need to work to reach your financial goal.",
        name: "Andrew Garfield",
        batch: "2018-2022",
      ),
    ],
    faqTilesInfo: [
      FAQTilesClass(
          question: "What does the company expect from students?",
          answer:
              "Basic knowledge on mezzanine technologies like flutter, dart and firebase."),
    ],
    roleType: "Full Time",
    lastDate: "28/11/2022",
    salary: "10 LPA",
    linkToApply: "www.google.com",
    driveLink: "www.google.com",
    eligibility: "CGPA -7.5 and no backlogs",
  ),
  Company(
    companyName: "Facebook",
    companyType: "Product",
    roleName: "Senior Developer",
    aboutTheFirm:
        "Can you bring creative human-centered ideas to life and make great things happen beyond what meets the eye? We believe in teamwork, fun, complex projects, diverse perspectives, and simple solutions. How about you? We're looking for a like-minded",
    jobDescription:
        "Can you bring creative human-centered ideas to life and make great things happen beyond what meets the eye? We believe in teamwork, fun, complex projects, diverse perspectives, and simple solutions. How about you? We're looking for a like-minded",
    skillset: ["Python", "Flutter", "Dart", "Java", "C++"],
    processTimeline: ProcessTimelineClass(
      steps: [1, 2, 3, 4],
      dates: ["28/11/20", "28/11/20", "28/11/20", "28/11/20"],
      descriptions: [
        "The application is to be done from the provided URL",
        "A test is put on HackerRank platform which consists of 30 aptitude and 2 coding questions with a timeframe of 1 hour ",
        "An interiew is conducted for 1 hour which consists of technical,managerial and hr related questions",
        "Voila You got the job",
      ],
      names: ["Application", "Online Test", "Interview", "Results"],
    ),
    previouslyPlacedContactDetails: [
      PreviouslyPlacedContactDetailsClass(
          name: "Name",
          batch: "batch",
          email: "email",
          phone: "phone",
          linkedin: "linkedin"),
    ],
    experienceTilesInfo: [
      ExperienceTileClass(
        experience:
            "Slate helps you see how many more days you need to work to reach your financial goal.Slate helps you see how many more days you need to work to reach your financial goal.Slate helps you see how many more days you need to work to reach your financial goal.",
        name: "Andrew Garfield",
        batch: "2018-2022",
      ),
    ],
    faqTilesInfo: [
      FAQTilesClass(
          question: "What does the company expect from students?",
          answer:
              "Basic knowledge on mezzanine technologies like flutter, dart and firebase."),
    ],
    roleType: "Full Time",
    lastDate: "28/11/2022",
    salary: "10 LPA",
    linkToApply: "www.google.com",
    driveLink: "www.google.com",
    eligibility: "CGPA -7.5 and no backlogs",
  ),
  Company(
    companyName: "Apple",
    companyType: "Product",
    roleName: "Full Stack Developer",
    aboutTheFirm:
        "Can you bring creative human-centered ideas to life and make great things happen beyond what meets the eye? We believe in teamwork, fun, complex projects, diverse perspectives, and simple solutions. How about you? We're looking for a like-minded",
    jobDescription:
        "Can you bring creative human-centered ideas to life and make great things happen beyond what meets the eye? We believe in teamwork, fun, complex projects, diverse perspectives, and simple solutions. How about you? We're looking for a like-minded",
    skillset: ["Python", "Flutter", "Dart", "Java", "C++"],
    processTimeline: ProcessTimelineClass(
      steps: [1, 2, 3, 4],
      dates: ["28/11/20", "28/11/20", "28/11/20", "28/11/20"],
      descriptions: [
        "The application is to be done from the provided URL",
        "A test is put on HackerRank platform which consists of 30 aptitude and 2 coding questions with a timeframe of 1 hour ",
        "An interiew is conducted for 1 hour which consists of technical,managerial and hr related questions",
        "Voila You got the job",
      ],
      names: ["Application", "Online Test", "Interview", "Results"],
    ),
    previouslyPlacedContactDetails: [
      PreviouslyPlacedContactDetailsClass(
          name: "Name",
          batch: "batch",
          email: "email",
          phone: "phone",
          linkedin: "linkedin"),
    ],
    experienceTilesInfo: [
      ExperienceTileClass(
        experience:
            "Slate helps you see how many more days you need to work to reach your financial goal.Slate helps you see how many more days you need to work to reach your financial goal.Slate helps you see how many more days you need to work to reach your financial goal.",
        name: "Andrew Garfield",
        batch: "2018-2022",
      ),
    ],
    faqTilesInfo: [
      FAQTilesClass(
          question: "What does the company expect from students?",
          answer:
              "Basic knowledge on mezzanine technologies like flutter, dart and firebase."),
    ],
    roleType: "Full Time",
    lastDate: "28/11/2022",
    salary: "10 LPA",
    linkToApply: "www.google.com",
    driveLink: "www.google.com",
    eligibility: "CGPA -7.5 and no backlogs",
  ),
  Company(
    companyName: "Uber",
    companyType: "Service",
    roleName: "Vice President",
    aboutTheFirm:
        "Can you bring creative human-centered ideas to life and make great things happen beyond what meets the eye? We believe in teamwork, fun, complex projects, diverse perspectives, and simple solutions. How about you? We're looking for a like-minded",
    jobDescription:
        "Can you bring creative human-centered ideas to life and make great things happen beyond what meets the eye? We believe in teamwork, fun, complex projects, diverse perspectives, and simple solutions. How about you? We're looking for a like-minded",
    skillset: ["Python", "Flutter", "Dart", "Java", "C++"],
    processTimeline: ProcessTimelineClass(
      steps: [1, 2, 3, 4],
      dates: ["28/11/20", "28/11/20", "28/11/20", "28/11/20"],
      descriptions: [
        "The application is to be done from the provided URL",
        "A test is put on HackerRank platform which consists of 30 aptitude and 2 coding questions with a timeframe of 1 hour ",
        "An interiew is conducted for 1 hour which consists of technical,managerial and hr related questions",
        "Voila You got the job",
      ],
      names: ["Application", "Online Test", "Interview", "Results"],
    ),
    previouslyPlacedContactDetails: [
      PreviouslyPlacedContactDetailsClass(
          name: "Name",
          batch: "batch",
          email: "email",
          phone: "phone",
          linkedin: "linkedin"),
    ],
    experienceTilesInfo: [
      ExperienceTileClass(
        experience:
            "Slate helps you see how many more days you need to work to reach your financial goal.Slate helps you see how many more days you need to work to reach your financial goal.Slate helps you see how many more days you need to work to reach your financial goal.",
        name: "Andrew Garfield",
        batch: "2018-2022",
      ),
    ],
    faqTilesInfo: [
      FAQTilesClass(
          question: "What does the company expect from students?",
          answer:
              "Basic knowledge on mezzanine technologies like flutter, dart and firebase."),
    ],
    roleType: "Full Time",
    lastDate: "28/11/2022",
    salary: "10 LPA",
    linkToApply: "www.google.com",
    driveLink: "www.google.com",
    eligibility: "CGPA -7.5 and no backlogs",
  ),
  Company(
    companyName: "Netflix",
    companyType: "Service",
    roleName: "Data Analyst",
    aboutTheFirm:
        "Can you bring creative human-centered ideas to life and make great things happen beyond what meets the eye? We believe in teamwork, fun, complex projects, diverse perspectives, and simple solutions. How about you? We're looking for a like-minded",
    jobDescription:
        "Can you bring creative human-centered ideas to life and make great things happen beyond what meets the eye? We believe in teamwork, fun, complex projects, diverse perspectives, and simple solutions. How about you? We're looking for a like-minded",
    skillset: ["Python", "Flutter", "Dart", "Java", "C++"],
    processTimeline: ProcessTimelineClass(
      steps: [1, 2, 3, 4],
      dates: ["28/11/20", "28/11/20", "28/11/20", "28/11/20"],
      descriptions: [
        "The application is to be done from the provided URL",
        "A test is put on HackerRank platform which consists of 30 aptitude and 2 coding questions with a timeframe of 1 hour ",
        "An interiew is conducted for 1 hour which consists of technical,managerial and hr related questions",
        "Voila You got the job",
      ],
      names: ["Application", "Online Test", "Interview", "Results"],
    ),
    previouslyPlacedContactDetails: [
      PreviouslyPlacedContactDetailsClass(
          name: "Name",
          batch: "batch",
          email: "email",
          phone: "phone",
          linkedin: "linkedin"),
      PreviouslyPlacedContactDetailsClass(
          name: "Name",
          batch: "batch",
          email: "email",
          phone: "phone",
          linkedin: "linkedin"),
      PreviouslyPlacedContactDetailsClass(
          name: "Name",
          batch: "batch",
          email: "email",
          phone: "phone",
          linkedin: "linkedin"),
      PreviouslyPlacedContactDetailsClass(
          name: "Name",
          batch: "batch",
          email: "email",
          phone: "phone",
          linkedin: "linkedin"),
    ],
    experienceTilesInfo: [
      ExperienceTileClass(
        experience:
            "Slate helps you see how many more days you need to work to reach your financial goal.Slate helps you see how many more days you need to work to reach your financial goal.Slate helps you see how many more days you need to work to reach your financial goal.",
        name: "Andrew Garfield",
        batch: "2018-2022",
      ),
    ],
    faqTilesInfo: [
      FAQTilesClass(
          question: "What does the company expect from students?",
          answer:
              "Basic knowledge on mezzanine technologies like flutter, dart and firebase."),
    ],
    roleType: "Full Time",
    lastDate: "28/11/2022",
    salary: "10 LPA",
    linkToApply: "www.google.com",
    driveLink: "www.google.com",
    eligibility: "CGPA -7.5 and no backlogs",
  ),
  Company(
    companyName: "Tesla",
    companyType: "Product",
    roleName: "Data Scientist",
    aboutTheFirm:
        "Can you bring creative human-centered ideas to life and make great things happen beyond what meets the eye? We believe in teamwork, fun, complex projects, diverse perspectives, and simple solutions. How about you? We're looking for a like-minded",
    jobDescription:
        "Can you bring creative human-centered ideas to life and make great things happen beyond what meets the eye? We believe in teamwork, fun, complex projects, diverse perspectives, and simple solutions. How about you? We're looking for a like-minded",
    skillset: ["Python", "Flutter", "Dart", "Java", "C++"],
    processTimeline: ProcessTimelineClass(
      steps: [1, 2, 3, 4],
      dates: ["28/11/20", "28/11/20", "28/11/20", "28/11/20"],
      descriptions: [
        "The application is to be done from the provided URL",
        "A test is put on HackerRank platform which consists of 30 aptitude and 2 coding questions with a timeframe of 1 hour ",
        "An interiew is conducted for 1 hour which consists of technical,managerial and hr related questions",
        "Voila You got the job",
      ],
      names: ["Application", "Online Test", "Interview", "Results"],
    ),
    previouslyPlacedContactDetails: [
      PreviouslyPlacedContactDetailsClass(
          name: "Name",
          batch: "batch",
          email: "email",
          phone: "phone",
          linkedin: "linkedin"),
    ],
    experienceTilesInfo: [
      ExperienceTileClass(
        experience:
            "Slate helps you see how many more days you need to work to reach your financial goal.Slate helps you see how many more days you need to work to reach your financial goal.Slate helps you see how many more days you need to work to reach your financial goal.",
        name: "Andrew Garfield",
        batch: "2018-2022",
      ),
    ],
    faqTilesInfo: [
      FAQTilesClass(
          question: "What does the company expect from students?",
          answer:
              "Basic knowledge on mezzanine technologies like flutter, dart and firebase."),
    ],
    roleType: "Full Time",
    lastDate: "28/11/2022",
    salary: "10 LPA",
    linkToApply: "www.google.com",
    driveLink: "www.google.com",
    eligibility: "CGPA -7.5 and no backlogs",
  ),
  Company(
    companyName: "JPMC",
    companyType: "Product",
    roleName: "Software Developer",
    aboutTheFirm:
        "Can you bring creative human-centered ideas to life and make great things happen beyond what meets the eye? We believe in teamwork, fun, complex projects, diverse perspectives, and simple solutions. How about you? We're looking for a like-minded",
    jobDescription:
        "Can you bring creative human-centered ideas to life and make great things happen beyond what meets the eye? We believe in teamwork, fun, complex projects, diverse perspectives, and simple solutions. How about you? We're looking for a like-minded",
    skillset: ["Python", "Flutter", "Dart", "Java", "C++"],
    processTimeline: ProcessTimelineClass(
      steps: [1, 2, 3, 4],
      dates: ["28/11/20", "28/11/20", "28/11/20", "28/11/20"],
      descriptions: [
        "The application is to be done from the provided URL",
        "A test is put on HackerRank platform which consists of 30 aptitude and 2 coding questions with a timeframe of 1 hour ",
        "An interiew is conducted for 1 hour which consists of technical,managerial and hr related questions",
        "Voila You got the job",
      ],
      names: ["Application", "Online Test", "Interview", "Results"],
    ),
    previouslyPlacedContactDetails: [
      PreviouslyPlacedContactDetailsClass(
          name: "Name",
          batch: "batch",
          email: "email",
          phone: "phone",
          linkedin: "linkedin"),
    ],
    experienceTilesInfo: [
      ExperienceTileClass(
        experience:
            "Slate helps you see how many more days you need to work to reach your financial goal.Slate helps you see how many more days you need to work to reach your financial goal.Slate helps you see how many more days you need to work to reach your financial goal.",
        name: "Andrew Garfield",
        batch: "2018-2022",
      ),
    ],
    faqTilesInfo: [
      FAQTilesClass(
          question: "What does the company expect from students?",
          answer:
              "Basic knowledge on mezzanine technologies like flutter, dart and firebase."),
    ],
    roleType: "Full Time",
    lastDate: "28/11/2022",
    salary: "10 LPA",
    linkToApply: "www.google.com",
    driveLink: "www.google.com",
    eligibility: "CGPA -7.5 and no backlogs",
  ),
  Company(
    companyName: "Deloitte",
    companyType: "Service",
    roleName: "App Developer",
    aboutTheFirm:
        "Can you bring creative human-centered ideas to life and make great things happen beyond what meets the eye? We believe in teamwork, fun, complex projects, diverse perspectives, and simple solutions. How about you? We're looking for a like-minded",
    jobDescription:
        "Can you bring creative human-centered ideas to life and make great things happen beyond what meets the eye? We believe in teamwork, fun, complex projects, diverse perspectives, and simple solutions. How about you? We're looking for a like-minded",
    skillset: ["Python", "Flutter", "Dart", "Java", "C++"],
    processTimeline: ProcessTimelineClass(
      steps: [1, 2, 3, 4],
      dates: ["28/11/20", "28/11/20", "28/11/20", "28/11/20"],
      descriptions: [
        "The application is to be done from the provided URL",
        "A test is put on HackerRank platform which consists of 30 aptitude and 2 coding questions with a timeframe of 1 hour ",
        "An interiew is conducted for 1 hour which consists of technical,managerial and hr related questions",
        "Voila You got the job",
      ],
      names: ["Application", "Online Test", "Interview", "Results"],
    ),
    previouslyPlacedContactDetails: [
      PreviouslyPlacedContactDetailsClass(
          name: "Name",
          batch: "batch",
          email: "email",
          phone: "phone",
          linkedin: "linkedin"),
    ],
    experienceTilesInfo: [
      ExperienceTileClass(
        experience:
            "Slate helps you see how many more days you need to work to reach your financial goal.Slate helps you see how many more days you need to work to reach your financial goal.Slate helps you see how many more days you need to work to reach your financial goal.",
        name: "Andrew Garfield",
        batch: "2018-2022",
      ),
    ],
    faqTilesInfo: [
      FAQTilesClass(
          question: "What does the company expect from students?",
          answer:
              "Basic knowledge on mezzanine technologies like flutter, dart and firebase."),
    ],
    roleType: "Full Time",
    lastDate: "28/11/2022",
    salary: "10 LPA",
    linkToApply: "www.google.com",
    driveLink: "www.google.com",
    eligibility: "CGPA -7.5 and no backlogs",
  ),
];

List<Company> searched = [];

class CompaniesScreen extends StatefulWidget {
  const CompaniesScreen({Key? key}) : super(key: key);

  @override
  State<CompaniesScreen> createState() => _CompaniesScreenState();
}

class _CompaniesScreenState extends State<CompaniesScreen> {
  final myController = TextEditingController();
  bool toggleValue = true;

  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    myController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Spacer(),
              Switch(
                  activeThumbImage:
                      const AssetImage('assets/Images/login_pic.png'),
                  mouseCursor: SystemMouseCursors.click,
                  value: toggleValue,
                  onChanged: (value) {
                    setState(() {
                      toggleValue = !toggleValue;
                    });
                  })
            ],
          ),
          SearchBar(
            controller: myController,
            width: width,
            onChanged: (i) {
              searched = companies
                  .where((x) =>
                      x.companyName.contains(i) |
                      x.companyName.toLowerCase().contains(i))
                  .toList();
            },
          ),
          toggleValue == true
              ? Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15.0,
                        vertical: 5,
                      ),
                      child: Text(
                        "On Campus",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height - 200,
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 400,
                                childAspectRatio: 1.4,
                                crossAxisSpacing: 20,
                                mainAxisSpacing: 20),
                        itemBuilder: (context, index) => myController
                                .text.isEmpty
                            ? MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: OnCampusCompanyTile(
                                  companyName: companies[index].companyName,
                                  companyType: companies[index].companyType,
                                  roleName: companies[index].roleName,
                                  roleType: companies[index].roleType,
                                  aboutTheFirm: companies[index].aboutTheFirm,
                                  jobDescription:
                                      companies[index].jobDescription,
                                  skillset: companies[index].skillset,
                                  processTimeline:
                                      companies[index].processTimeline,
                                  previouslyPlacedContactDetails:
                                      companies[index]
                                          .previouslyPlacedContactDetails,
                                  experienceTilesInfo:
                                      companies[index].experienceTilesInfo,
                                  faqTilesInfo: companies[index].faqTilesInfo,
                                  lastDate: companies[index].lastDate,
                                  salary: companies[index].salary,
                                  linkToApply: companies[index].linkToApply,
                                  driveLink: companies[index].driveLink,
                                  eligibility: companies[index].eligibility,
                                ),
                              )
                            : MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: OnCampusCompanyTile(
                                  companyName: searched[index].companyName,
                                  companyType: searched[index].companyType,
                                  roleName: searched[index].roleName,
                                  roleType: searched[index].roleType,
                                  aboutTheFirm: searched[index].aboutTheFirm,
                                  jobDescription:
                                      searched[index].jobDescription,
                                  skillset: searched[index].skillset,
                                  processTimeline:
                                      searched[index].processTimeline,
                                  previouslyPlacedContactDetails:
                                      searched[index]
                                          .previouslyPlacedContactDetails,
                                  experienceTilesInfo:
                                      searched[index].experienceTilesInfo,
                                  faqTilesInfo: searched[index].faqTilesInfo,
                                  lastDate: searched[index].lastDate,
                                  salary: searched[index].salary,
                                  linkToApply: searched[index].linkToApply,
                                  driveLink: searched[index].driveLink,
                                  eligibility: searched[index].eligibility,
                                ),
                              ),
                        itemCount: myController.text.isEmpty
                            ? companies.length
                            : searched.length,
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15.0,
                        vertical: 5,
                      ),
                      child: Text(
                        "Off Campus",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height - 200,
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 250,
                                childAspectRatio: 1.3,
                                crossAxisSpacing: 20,
                                mainAxisSpacing: 20),
                        itemBuilder: (context, index) =>
                            const OffCampusCompanyTile(),
                        itemCount: 6,
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final double width;
  final Function onChanged;

  const SearchBar(
      {Key? key,
      required this.controller,
      required this.width,
      required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 30,
            width: width * 0.8,
            child: Center(
              child: TextField(
                controller: controller,
                decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.search_rounded,
                      color: Color(0xffc4c4c4),
                    ),
                    contentPadding: EdgeInsets.only(bottom: 13),
                    border: InputBorder.none,
                    hintText: 'Enter a search term'),
                onChanged: (value) => onChanged(value),
              ),
            ),
          ),
          const Spacer(),
          GestureDetector(
            child: const Icon(Icons.filter_list_rounded),
            onTap: () {},
          )
        ],
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 15,
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 20,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Color(0x3f000000),
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
        color: Colors.white,
      ),
    );
  }
}
