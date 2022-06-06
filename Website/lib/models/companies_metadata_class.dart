class CompaniesMetadataClass {
  final List companyNames;
  final List companyTypes;
  final List roleNames;
  final List roleTypes;
  final List offerTypes;
  final List skillset;
  final double packageMax;

  CompaniesMetadataClass(
      {required this.companyNames,
      required this.companyTypes,
      required this.roleNames,
      required this.roleTypes,
      required this.offerTypes,
      required this.skillset,
      required this.packageMax});

  CompaniesMetadataClass.fromJson(Map<String, dynamic> json)
      : this(
          companyNames: (json['companyName'] as List)..sort(),
          companyTypes: (json['companyType'] as List)..sort(),
          roleNames: (json['roleName'] as List)..sort(),
          roleTypes: (json['roleType'] as List)..sort(),
          offerTypes: (json['offerType'] as List)..sort(),
          skillset: (json['skillset'] as List)..sort(),
          packageMax: double.parse(json['packageMax'].toString()),
        );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['companyName'] = companyNames;
    data['companyType'] = companyTypes;
    data['roleName'] = roleNames;
    data['roleType'] = roleTypes;
    data['offerType'] = offerTypes;
    data['skillset'] = skillset;
    data['packageMax'] = packageMax;
    return data;
  }

  @override
  String toString() {
    return 'CompaniesMetadataClass{companyNames: $companyNames, companyTypes: $companyTypes, roleNames: $roleNames, roleTypes: $roleTypes, offerTypes: $offerTypes, skillset: $skillset, packageMax: $packageMax}';
  }
}
