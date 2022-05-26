import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:placementor/Front%20End/models/companies_metadata_class.dart';

import '../models/company_class.dart';
import '../widgets/on_campus_company_tile.dart';
import '../widgets/off_campus_company_tile.dart';
import 'companies_search_screen.dart';

List<Company> searched = [];

class CompaniesScreen extends StatefulWidget {
  const CompaniesScreen({Key? key}) : super(key: key);

  @override
  State<CompaniesScreen> createState() => _CompaniesScreenState();
}

class _CompaniesScreenState extends State<CompaniesScreen> {
  CompaniesMetadataClass? companiesMetadata;

  Future<QuerySnapshot<Company>> _getCompaniesSetMetadata() async {
    // var companiesMetadataObj = (await _getCompaniesMetadata()).data() as Map;
    companiesMetadata = (await _getCompaniesMetadata()).data();
    return FirebaseFirestore.instance
        .collection('Companies')
        .withConverter<Company>(
          fromFirestore: (json, _) => Company.fromJson(json.data()!),
          toFirestore: (company, _) => company.toJson(),
        )
        .get();
  }

  Future<DocumentSnapshot<CompaniesMetadataClass>> _getCompaniesMetadata() {
    return FirebaseFirestore.instance
        .collection('Metadata')
        .doc('CompaniesMetadata')
        // .get();
        .withConverter<CompaniesMetadataClass>(
            fromFirestore: (json, _) =>
                CompaniesMetadataClass.fromJson(json.data()!),
            toFirestore: (companyMetadata, _) => companyMetadata.toJson())
        .get();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return FutureBuilder<QuerySnapshot<Company>>(
        future: _getCompaniesSetMetadata(),
        builder: (context, snapshot) {
          if (snapshot.hasError)
            return Text('Something went wrong ${snapshot.error}');
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          List<Company> companies =
              snapshot.data!.docs.map((doc) => doc.data()).toList();
          return Scaffold(
            backgroundColor: const Color(0xFFF7F9FC),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).pushNamed(
                      '/companySearchPage',
                      arguments: [companies, companiesMetadata]),
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
                    itemBuilder: (context, index) => OnCampusCompanyTile(
                      id: companies[index].id,
                      companyName: companies[index].companyName,
                      companyType: companies[index].companyType,
                      roleName: companies[index].roleName,
                      roleType: companies[index].roleType,
                      aboutTheFirm: companies[index].aboutTheFirm,
                      jobDescription: companies[index].jobDescription,
                      skillset: companies[index].skillset as List<String>,
                      processTimeline: companies[index].processTimeline,
                      previouslyPlacedContacts:
                          companies[index].previouslyPlacedContacts,
                      experienceTilesInfo: companies[index].experiences,
                      faqs: companies[index].faqs,
                      lastDate: companies[index].lastDate,
                      package: companies[index].package,
                      linkToApply: companies[index].linkToApply,
                      driveLink: companies[index].driveLink,
                      eligibility: companies[index].eligibility,
                      offerType: companies[index].offerType,
                    ),
                    itemCount: companies.length,
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
                    itemBuilder: (context, index) =>
                        const OffCampusCompanyTile(),
                    itemCount: 6,
                  ),
                ),
                const SizedBox(
                  height: 80,
                )
              ],
            ),
          );
        });
  }
}
