import 'package:flutter/material.dart';
import 'package:fuzzywuzzy/fuzzywuzzy.dart';

import '../models/companies_metadata_class.dart';
import '../models/companies_search_filter_class.dart';
import '../models/company_class.dart';
import '../widgets/search_bar.dart';
import '../widgets/search_company_tile.dart';

CompaniesSearchFilter companiesSearchFilter = CompaniesSearchFilter();
List<String> searchedCompaniesIndex = [];

void refreshCompaniesSearchScreen() {
  companiesSearchFilter = CompaniesSearchFilter();
  searchedCompaniesIndex = [];
}

class CompaniesSearchScreen extends StatefulWidget {
  const CompaniesSearchScreen({Key? key}) : super(key: key);

  @override
  State<CompaniesSearchScreen> createState() => _CompaniesSearchScreenState();
}

class _CompaniesSearchScreenState extends State<CompaniesSearchScreen> {
  final myController = TextEditingController();
  Map<String, Company> companiesMap = {};

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
    final width = MediaQuery.of(context).size.width;
    // final args = ModalRoute.of(context)!.settings.arguments as List;
    var args = ModalRoute.of(context)!.settings.arguments;
    args = args as List;
    final companies = args[0] as List<Company>;
    final companiesMetadata = args[1] as CompaniesMetadataClass;
    for (var company in companies) {
      companiesMap[company.id] = company;
    }
    if (!companiesSearchFilter.lateVariablesInitialized) {
      companiesSearchFilter.addCompaniesAndPackageMax(
          companies, companiesMetadata.packageMax);
    }
    if (searchedCompaniesIndex.isEmpty &&
        myController.text.trim().isEmpty &&
        companiesSearchFilter.isEmpty) {
      searchedCompaniesIndex = companies.map((company) => company.id).toList();
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F9FC),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchBar(
              companies: companies,
              companiesMetadata: companiesMetadata,
              companiesSearchFilter: companiesSearchFilter,
              controller: myController,
              width: width,
              onFilterChanged: () {
                setState(() {
                  searchedCompaniesIndex =
                      companiesSearchFilter.filterCompanies().keys.toList();
                });
              },
              onSearchTextChanged: (searchText) {
                setState(() {
                  if (searchText.length >= 3) {
                    Map<String, int> _weightedSearchMap = {};
                    companiesSearchFilter
                        .filterCompanies()
                        .forEach((companyId, companySearchText) {
                      int _weightedRatio =
                          weightedRatio(searchText, companySearchText);
                      if (_weightedRatio >= 50) {
                        _weightedSearchMap[companyId] = _weightedRatio;
                      }
                    });
                    var _weightedSearchList =
                        _weightedSearchMap.entries.toList();
                    _weightedSearchList
                        .sort((a, b) => b.value.compareTo(a.value));
                    searchedCompaniesIndex =
                        _weightedSearchList.map((e) => e.key).toList();
                  } else {
                    searchedCompaniesIndex =
                        companiesSearchFilter.filterCompanies().keys.toList();
                  }
                });
              },
            ),
            searchedCompaniesIndex.isEmpty
                ? const Center(
                    child: Text("Sorry, no opportunities found!",
                        style: TextStyle(
                            color: Colors.blueGrey,
                            fontStyle: FontStyle.italic)),
                  )
                : Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 450,
                              childAspectRatio: 1.7,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20),
                      itemBuilder: (context, index) {
                        return MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: SearchCompanyTile(
                            company:
                                companiesMap[searchedCompaniesIndex[index]]!,
                          ),
                        );
                      },
                      itemCount: searchedCompaniesIndex.length,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
