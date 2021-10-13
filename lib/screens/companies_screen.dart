import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../widgets/search_bar.dart';
import '../widgets/on_campus_company_tile.dart';
import '../widgets/off_campus_company_tile.dart';

class CompaniesScreen extends StatelessWidget {
  const CompaniesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SearchBar(),
          SizedBox(
            height: height * 0.475,
            child: ListView.builder(
              itemBuilder: (context, index) => const OnCampusCompanyTile(),
              itemCount: 6,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 15.0,
              vertical: 5,
            ),
            child: Text("Off Campus Opportunities"),
          ),
          SizedBox(
            height: height * 0.19,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => const OffCampusCompanyTile(),
              itemCount: 6,
            ),
          )
        ],
      ),
    );
  }
}
