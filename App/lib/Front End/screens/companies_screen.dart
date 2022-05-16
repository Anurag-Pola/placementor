import 'package:flutter/material.dart';

import '../widgets/company_class.dart';
import '../widgets/experience_tile_class.dart';
import '../widgets/faq_tiles_class.dart';
import '../widgets/previosly_placed_contact_details_class.dart';
import '../widgets/process_timeline_class.dart';

import '../widgets/on_campus_company_tile.dart';
import '../widgets/off_campus_company_tile.dart';
import '/companies_data.dart';
import 'companies_search_screen.dart';

List<Company> searched = [];

class CompaniesScreen extends StatefulWidget {
  const CompaniesScreen({Key? key}) : super(key: key);

  @override
  State<CompaniesScreen> createState() => _CompaniesScreenState();
}

class _CompaniesScreenState extends State<CompaniesScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).pushNamed('/companySearchPage'),
            child: Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Icon(Icons.search_rounded,
                        color: Color.fromARGB(255, 111, 111, 111)),
                  ),
                  Expanded(
                    child: Text(
                      'Search for an opportunity',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 111, 111, 111),
                      ),
                    ),
                  ),
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
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) =>
                  // myController.text.isEmpty
                  // ?
                  OnCampusCompanyTile(
                companyName: companies[index].companyName,
                roleName: companies[index].roleName,
                roleType: companies[index].roleType,
                aboutTheFirm: companies[index].aboutTheFirm,
                jobDescription: companies[index].jobDescription,
                skillset: companies[index].skillset,
                processTimeline: companies[index].processTimeline,
                previouslyPlacedContactDetails:
                    companies[index].previouslyPlacedContactDetails,
                experienceTilesInfo: companies[index].experienceTilesInfo,
                faqTilesInfo: companies[index].faqTilesInfo,
                lastDate: companies[index].lastDate,
                salary: companies[index].salary,
              ),
              // : OnCampusCompanyTile(
              //     companyName: searched[index].companyName,
              //     roleName: searched[index].roleName,
              //     roleType: searched[index].roleType,
              //     aboutTheFirm: searched[index].aboutTheFirm,
              //     jobDescription: searched[index].jobDescription,
              //     skillset: searched[index].skillset,
              //     processTimeline: searched[index].processTimeline,
              //     previouslyPlacedContactDetails:
              //         searched[index].previouslyPlacedContactDetails,
              //     experienceTilesInfo: searched[index].experienceTilesInfo,
              //     faqTilesInfo: searched[index].faqTilesInfo,
              //     lastDate: searched[index].lastDate,
              //     salary: searched[index].salary,
              //   ),
              itemCount:
                  // myController.text.isEmpty
                  // ?
                  companies.length,
              // : searched.length,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 15.0,
              vertical: 5,
            ),
            child: Text(
              "Off Campus Opportunities",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.brown,
              ),
            ),
          ),
          SizedBox(
            height: height * 0.18,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => const OffCampusCompanyTile(),
              itemCount: 6,
            ),
          ),
          const SizedBox(
            height: 80,
          )
        ],
      ),
    );
  }
}
