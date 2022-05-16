import 'Front End/widgets/company_class.dart';
import 'Front End/widgets/experience_tile_class.dart';
import 'Front End/widgets/faq_tiles_class.dart';
import 'Front End/widgets/previosly_placed_contact_details_class.dart';
import 'Front End/widgets/process_timeline_class.dart';

const companies = [
  Company(
    companyName: "Google",
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
  ),
  Company(
    companyName: "Amazon",
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
  ),
  Company(
    companyName: "Microsoft",
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
  ),
  Company(
    companyName: "Facebook",
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
  ),
  Company(
    companyName: "Apple",
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
  ),
  Company(
    companyName: "Uber",
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
  ),
  Company(
    companyName: "Netflix",
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
  ),
  Company(
    companyName: "Tesla",
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
  ),
  Company(
    companyName: "JPMC",
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
  ),
  Company(
    companyName: "Deloitte",
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
  ),
];
