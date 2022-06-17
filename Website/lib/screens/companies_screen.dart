import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../models/companies_metadata_class.dart';
import '../screens/on_campus_company_form.dart';
import '../models/company_class.dart';
import '../widgets/on_campus_company_tile.dart';
import '../widgets/off_campus_company_tile.dart';
import 'off_campus_company_form.dart';

List<Company> searched = [];

class CompaniesScreen extends StatefulWidget {
  const CompaniesScreen({Key? key}) : super(key: key);

  @override
  State<CompaniesScreen> createState() => _CompaniesScreenState();
}

class _CompaniesScreenState extends State<CompaniesScreen> {
  CompaniesMetadataClass? companiesMetadata;
  bool toggleValue = true;

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
        if (snapshot.hasError) return const Text('Something went wrong');
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        List<Company> companies =
            snapshot.data!.docs.map((doc) => doc.data()).toList();
        List<Company> onCampusCompanies = companies
            .where((element) => element.offerType == "On Campus")
            .toList();
        List<Company> offCampusCompanies = companies
            .where((element) => element.offerType == "Off Campus")
            .toList();

        return Scaffold(
          floatingActionButton: SpeedDial(
            icon: Icons.add,
            activeIcon: Icons.close,
            spacing: 3,
            childPadding: const EdgeInsets.all(5),
            spaceBetweenChildren: 4,
            overlayColor: Colors.black,
            overlayOpacity: 0.5,
            heroTag: 'speed-dial-hero-tag',
            elevation: 8.0,
            children: [
              SpeedDialChild(
                  child: const Icon(Icons.fort_rounded),
                  backgroundColor: Colors.deepOrange,
                  foregroundColor: Colors.white,
                  label: 'Off Campus',
                  onTap: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OffCampusCompanyForm(),
                      ),
                    );
                  }),
              SpeedDialChild(
                  child: const Icon(Icons.apartment_rounded),
                  backgroundColor: Colors.deepOrange,
                  foregroundColor: Colors.white,
                  label: 'On Campus',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OnCampusCompanyForm(),
                      ),
                    );
                  }),
            ],
          ),
          backgroundColor: const Color(0xFFF7F9FC),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Off Campus",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Switch(
                    activeColor: Colors.cyan,
                    activeTrackColor: Colors.grey,
                    inactiveThumbColor: Colors.cyan,
                    inactiveTrackColor: Colors.grey,
                    mouseCursor: SystemMouseCursors.click,
                    value: toggleValue,
                    onChanged: (value) {
                      setState(
                        () {
                          toggleValue = !toggleValue;
                        },
                      );
                    },
                  ),
                  const Text(
                    "On Campus",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => Navigator.of(context).pushNamed(
                    '/company-search-page',
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
                                    maxCrossAxisExtent: 450,
                                    childAspectRatio: 1.7,
                                    crossAxisSpacing: 20,
                                    mainAxisSpacing: 20),
                            itemBuilder: (context, index) => MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: OnCampusCompanyTile(
                                id: onCampusCompanies[index].id,
                                companyName:
                                    onCampusCompanies[index].companyName,
                                companyType:
                                    onCampusCompanies[index].companyType,
                                roleName: onCampusCompanies[index].roleName,
                                roleType: onCampusCompanies[index].roleType,
                                aboutTheFirm:
                                    onCampusCompanies[index].aboutTheFirm,
                                jobDescription:
                                    onCampusCompanies[index].jobDescription,
                                skillset: onCampusCompanies[index].skillset
                                    as List<String>,
                                processTimeline:
                                    onCampusCompanies[index].processTimeline,
                                previouslyPlacedContacts:
                                    onCampusCompanies[index]
                                        .previouslyPlacedContacts,
                                experienceTilesInfo:
                                    onCampusCompanies[index].experiences,
                                faqs: onCampusCompanies[index].faqs,
                                lastDate: onCampusCompanies[index].lastDate,
                                package: onCampusCompanies[index].package,
                                linkToApply:
                                    onCampusCompanies[index].linkToApply,
                                driveLink: onCampusCompanies[index].driveLink,
                                eligibility:
                                    onCampusCompanies[index].eligibility,
                                offerType: onCampusCompanies[index].offerType,
                              ),
                            ),
                            itemCount: onCampusCompanies.length,
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
                                OffCampusCompanyTile(
                              companyName:
                                  offCampusCompanies[index].companyName,
                              roleName: offCampusCompanies[index].roleName,
                              jobDescription:
                                  offCampusCompanies[index].jobDescription,
                              linkToApply:
                                  offCampusCompanies[index].linkToApply,
                              id: offCampusCompanies[index].id,
                            ),
                            itemCount: offCampusCompanies.length,
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        );
      },
    );
  }
}
