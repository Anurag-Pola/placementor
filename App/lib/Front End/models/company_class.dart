import './experience_tile_class.dart';
import './faq_tiles_class.dart';
import './previosly_placed_contact_details_class.dart';

import './process_timeline_class.dart';

class Company {
  const Company({
    required this.id,
    required this.companyName,
    this.companyType,
    required this.roleName,
    this.roleType,
    this.aboutTheFirm,
    required this.jobDescription,
    this.skillset,
    this.processTimeline,
    this.previouslyPlacedContacts,
    this.experiences,
    this.faqs,
    this.lastDate,
    this.package,
    required this.linkToApply,
    this.driveLink,
    this.eligibility,
    required this.offerType,
  });

  Company.fromJson(Map<String, Object?> json)
      : this(
          id: json['id'] as String,
          companyName: json['companyName'] as String,
          companyType: json['companyType'] == null
              ? null
              : json['companyType'] as String,
          roleName: json['roleName'] as String,
          roleType:
              json['roleType'] == null ? null : json['roleType'] as String,
          aboutTheFirm: json['aboutTheFirm'] == null
              ? null
              : json['aboutTheFirm'] as String,
          jobDescription: json['jobDescription'] as String,
          skillset: json['skillset'] == null
              ? null
              : List<String>.from(json['skillset'] as List),
          processTimeline: json['processTimeline'] == null
              ? null
              : ProcessTimelineClass.fromJson(
                  json['processTimeline'] as Map<String, Object?>),
          previouslyPlacedContacts: json['previouslyPlacedContacts'] == null
              ? null
              : (json['previouslyPlacedContacts'] as Map)
                  .entries
                  .map((e) => PreviouslyPlacedContactDetailsClass(
                      name: e.value["name"],
                      rollNo: e.value["rollNo"],
                      email: e.value["email"],
                      phone: e.value["phone"],
                      linkedin: e.value["linkedin"]))
                  .toList(),
          experiences: json['experiences'] == null
              ? null
              : (json['experiences'] as Map)
                  .entries
                  .map((e) => ExperienceTileClass.fromJson(
                      e.value as Map<String, Object?>))
                  .toList(),
          faqs: json['faqs'] == null
              ? null
              : (json['faqs'] as Map)
                  .entries
                  .map((e) =>
                      FAQTilesClass.fromJson(e.value as Map<String, Object?>))
                  .toList(),
          lastDate:
              json['lastDate'] == null ? null : json['lastDate'] as String,
          package: json['package'] == null
              ? null
              : double.parse(json['package'].toString()),
          linkToApply: json['linkToApply'] as String,
          driveLink:
              json['driveLink'] == null ? null : json['driveLink'] as String,
          eligibility: json['eligibility'] == null
              ? null
              : json['eligibility'] as String,
          offerType: json['offerType'] as String,
        );

  final String id;
  final String companyName;
  final String? companyType;
  final String roleName;
  final String? roleType;
  final String? aboutTheFirm;
  final String jobDescription;
  final List? skillset;
  final ProcessTimelineClass? processTimeline;
  final List<PreviouslyPlacedContactDetailsClass>? previouslyPlacedContacts;
  final List<ExperienceTileClass>? experiences;
  final List<FAQTilesClass>? faqs;
  final String? lastDate;
  final double? package;
  final String linkToApply;
  final String? driveLink;
  final String? eligibility;
  final String offerType;

  Map<String, Object?> toJson() {
    Map<String, Map> previouslyPlacedContactsJson = {};
    Map<String, Map> experienceTilesInfoJson = {};
    Map<String, Map> faqsJson = {};

    if (previouslyPlacedContacts != null &&
        experiences != null &&
        faqs != null) {
      for (PreviouslyPlacedContactDetailsClass contact
          in previouslyPlacedContacts!) {
        previouslyPlacedContactsJson[contact.rollNo] = contact.toJson();
      }

      for (ExperienceTileClass experienceTile in experiences!) {
        experienceTilesInfoJson[experienceTile.rollNo] =
            experienceTile.toJson();
      }

      for (FAQTilesClass faqTile in faqs!) {
        faqsJson[faqTile.question] = faqTile.toJson();
      }
    }
    return {
      'id': id,
      'companyName': companyName,
      if (companyType != null) 'companyType': companyType,
      'roleName': roleName,
      if (roleType != null) 'roleType': roleType,
      if (aboutTheFirm != null) 'aboutTheFirm': aboutTheFirm,
      'jobDescription': jobDescription,
      if (skillset != null) 'skillset': skillset,
      if (processTimeline != null) 'processTimeline': processTimeline!.toJson(),
      if (previouslyPlacedContacts != null)
        'previouslyPlacedContacts': previouslyPlacedContactsJson,
      if (experiences != null) 'experiences': experienceTilesInfoJson,
      if (faqs != null) 'faqs': faqsJson,
      if (lastDate != null) 'lastDate': lastDate,
      if (package != null) 'package': package,
      'linkToApply': linkToApply,
      if (driveLink != null) 'driveLink': driveLink,
      if (eligibility != null) 'eligibility': eligibility,
      'offerType': offerType,
    };
  }

  @override
  String toString() {
    return 'Company{id: $id, companyName: $companyName, companyType: $companyType, roleName: $roleName, roleType: $roleType, aboutTheFirm: $aboutTheFirm, jobDescription: $jobDescription, skillset: $skillset, processTimeline: $processTimeline, previouslyPlacedContacts: $previouslyPlacedContacts, experiences: $experiences, faqs: $faqs, lastDate: $lastDate, package: $package, linkToApply: $linkToApply, driveLink: $driveLink, eligibility: $eligibility, offerType: $offerType}';
  }

  String toSearchTypeString() {
    return [
      companyName,
      if (companyType != null) companyType,
      roleName,
      roleType,
      if (aboutTheFirm != null) aboutTheFirm,
      jobDescription,
      if (skillset != null) skillset!.join(' '),
      if (eligibility != null) eligibility,
      offerType
    ].join(' ');
  }
}
