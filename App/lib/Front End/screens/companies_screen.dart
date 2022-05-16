import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/company_class.dart';
import '../widgets/on_campus_company_tile.dart';
import '../widgets/off_campus_company_tile.dart';

List<Company> searched = [];

class CompaniesScreen extends StatefulWidget {
  const CompaniesScreen({Key? key}) : super(key: key);

  @override
  State<CompaniesScreen> createState() => _CompaniesScreenState();
}

class _CompaniesScreenState extends State<CompaniesScreen> {
  final myController = TextEditingController();

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

    return FutureBuilder<QuerySnapshot<Company>>(
        future: FirebaseFirestore.instance
            .collection('Companies')
            .withConverter<Company>(
              fromFirestore: (snapshot, _) =>
                  Company.fromJson(snapshot.data()!),
              toFirestore: (company, _) => company.toJson(),
            )
            .get(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return const Text('Something went wrong');
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
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) => myController.text.isEmpty
                        ? OnCampusCompanyTile(
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
                          )
                        : OnCampusCompanyTile(
                            id: searched[index].id,
                            companyName: searched[index].companyName,
                            companyType: searched[index].companyType,
                            roleName: searched[index].roleName,
                            roleType: searched[index].roleType,
                            aboutTheFirm: searched[index].aboutTheFirm,
                            jobDescription: searched[index].jobDescription,
                            skillset: searched[index].skillset as List<String>,
                            processTimeline: searched[index].processTimeline,
                            previouslyPlacedContacts:
                                searched[index].previouslyPlacedContacts,
                            experienceTilesInfo: searched[index].experiences,
                            faqs: searched[index].faqs,
                            lastDate: searched[index].lastDate,
                            package: searched[index].package,
                            linkToApply: searched[index].linkToApply,
                            driveLink: searched[index].driveLink,
                            eligibility: searched[index].eligibility,
                            offerType: searched[index].offerType,
                          ),
                    itemCount: myController.text.isEmpty
                        ? companies.length
                        : searched.length,
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
