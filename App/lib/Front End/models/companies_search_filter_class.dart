import 'package:placementor/Front%20End/models/company_class.dart';

class CompaniesSearchFilter {
  late List<Company> companies;
  List companyNameFilter = [];
  List companyTypeFilter = [];
  List roleNameFilter = [];
  List roleTypeFilter = [];
  List offerTypeFilter = [];
  List skillsetFilter = [];
  late List<int> packageFilter;
  bool lateVariablesInitialized = false;
  late double packageMax;

  bool get isEmpty =>
      companyNameFilter.isEmpty &&
      companyTypeFilter.isEmpty &&
      roleNameFilter.isEmpty &&
      roleTypeFilter.isEmpty &&
      offerTypeFilter.isEmpty &&
      skillsetFilter.isEmpty &&
      packageFilter == [0, packageMax.toInt() + 1];

  void clearFilter() {
    companyNameFilter = [];
    companyTypeFilter = [];
    roleNameFilter = [];
    roleTypeFilter = [];
    offerTypeFilter = [];
    skillsetFilter = [];
    packageFilter = [0, packageMax.toInt() + 1];
  }

  void addCompaniesAndPackageMax(List<Company> companies, double packageMax) {
    if (!lateVariablesInitialized) {
      this.companies = companies;
      packageFilter = [0, packageMax.toInt() + 1];
      this.packageMax = packageMax;
      lateVariablesInitialized = true;
    }
  }

  @override
  String toString() {
    return 'CompaniesSearchFilter{companies: $companies, companyNameFilter: $companyNameFilter, companyTypeFilter: $companyTypeFilter, roleNameFilter: $roleNameFilter, roleTypeFilter: $roleTypeFilter, offerTypeFilter: $offerTypeFilter, skillsetFilter: $skillsetFilter, packageFilter: $packageFilter, lateVariablesInitialized: $lateVariablesInitialized}';
  }

  Map<String, dynamic> filterCompanies() {
    Map<String, String> filteredCompanies = {};
    bool _companyNameFilterPass = companyNameFilter.isEmpty;
    bool _companyTypeFilterPass = companyTypeFilter.isEmpty;
    bool _roleNameFilterPass = roleNameFilter.isEmpty;
    bool _roleTypeFilterPass = roleTypeFilter.isEmpty;
    bool _offerTypeFilterPass = offerTypeFilter.isEmpty;
    bool _skillsetFilterPass = skillsetFilter.isEmpty;
    bool _packageFilterPass = (packageFilter == [0, packageMax.toInt() + 1]);

    for (Company company in companies) {
      if (companyNameFilter.isNotEmpty && company.companyName.isNotEmpty) {
        _companyNameFilterPass =
            companyNameFilter.contains(company.companyName);
      }

      if (companyTypeFilter.isNotEmpty && company.companyType.isNotEmpty) {
        _companyTypeFilterPass =
            companyTypeFilter.contains(company.companyType);
      }

      if (roleNameFilter.isNotEmpty && company.roleName.isNotEmpty) {
        _roleNameFilterPass = roleNameFilter.contains(company.roleName);
      }

      if (roleTypeFilter.isNotEmpty && company.roleType.isNotEmpty) {
        _roleTypeFilterPass = roleTypeFilter.contains(company.roleType);
      }

      if (offerTypeFilter.isNotEmpty && company.offerType.isNotEmpty) {
        _offerTypeFilterPass = offerTypeFilter.contains(company.offerType);
      }

      if (skillsetFilter.isNotEmpty && company.skillset.isNotEmpty) {
        for (var skill in skillsetFilter) {
          if (company.skillset.contains(skill)) {
            _skillsetFilterPass = true;
            break;
          }
        }
      }

      if (packageFilter.isNotEmpty && company.package != null) {
        _packageFilterPass = (packageFilter[0] <= company.package &&
            packageFilter[1] >= company.package);
      }

      bool _companyFilterPass = _companyNameFilterPass &&
          _companyTypeFilterPass &&
          _roleNameFilterPass &&
          _roleTypeFilterPass &&
          _offerTypeFilterPass &&
          _skillsetFilterPass &&
          _packageFilterPass;

      if (_companyFilterPass) {
        filteredCompanies[company.id] = company.toSearchTypeString();
      }
    }
    return filteredCompanies;
  }
}
