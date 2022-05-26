import 'package:flutter/material.dart';
import 'package:placementor/Front%20End/models/companies_search_filter_class.dart';

import '../models/companies_metadata_class.dart';
import '../models/company_class.dart';
import 'search_filter.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final double width;
  final Function onSearchTextChanged;
  final Function onFilterChanged;
  final List<Company> companies;
  final CompaniesMetadataClass companiesMetadata;
  CompaniesSearchFilter companiesSearchFilter;

  SearchBar(
      {Key? key,
      required this.companies,
      required this.companiesMetadata,
      required this.companiesSearchFilter,
      required this.controller,
      required this.width,
      required this.onSearchTextChanged,
      required this.onFilterChanged})
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
                onChanged: (value) => onSearchTextChanged(value.trim()),
              ),
            ),
          ),
          const Spacer(),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              child: const Icon(Icons.filter_list_rounded),
              onTap: () async {
                await showDialog(
                    context: context,
                    builder: (context) => FilterAlertDialog(
                          companiesSearchFilter: companiesSearchFilter,
                          companiesMetadata: companiesMetadata,
                        ));
                print(companiesSearchFilter);
                print(companiesSearchFilter.filterCompanies());
                onFilterChanged();
              },
            ),
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
