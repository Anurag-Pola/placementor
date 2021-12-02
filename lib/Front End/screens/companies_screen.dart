import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../widgets/on_campus_company_tile.dart';
import '../widgets/off_campus_company_tile.dart';

final companies = [
  "Google",
  "Amazon",
  "JPMC",
  "Deloitte",
  "Apple",
  "Flipkart",
  "Uber",
  "Zomato",
  "Flutter",
];
final recentSearches = [
  "Google",
  "FLutter",
  "JPMC",
];

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

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SearchBar(
            controller: myController,
            width: width,
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) => OnCampusCompanyTile(
                companyName: myController.text.isEmpty
                    ? companies[index]
                    : companies
                        .where((i) =>
                            i.contains(myController.text) |
                            i.toLowerCase().contains(myController.text))
                        .toList()[index],
              ),
              itemCount: myController.text.isEmpty
                  ? companies.length
                  : companies
                      .where((i) =>
                          i.contains(myController.text) |
                          i.toLowerCase().contains(myController.text))
                      .toList()
                      .length,
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

class SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final double width;
  const SearchBar({Key? key, required this.controller, required this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
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
