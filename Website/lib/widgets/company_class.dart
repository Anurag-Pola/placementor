import '/widgets/experience_tile_class.dart';
import '/widgets/faq_tiles_class.dart';
import '/widgets/previosly_placed_contact_details_class.dart';

import './process_timeline_class.dart';

class Company {
  const Company({
    required this.id,
    required this.companyName,
    required this.companyType,
    required this.roleName,
    required this.roleType,
    required this.aboutTheFirm,
    required this.jobDescription,
    required this.skillset,
    required this.processTimeline,
    required this.previouslyPlacedContacts,
    required this.experiences,
    required this.faqs,
    required this.lastDate,
    required this.package,
    required this.linkToApply,
    required this.driveLink,
    required this.eligibility,
    required this.offerType,
  });

  Company.fromJson(Map<String, Object?> json)
      : this(
          id: json['id'] as String,
          companyName: json['companyName'] as String,
          companyType: json['companyType'] as String,
          roleName: json['roleName'] as String,
          roleType: json['roleType'] as String,
          aboutTheFirm: json['aboutTheFirm'] as String,
          jobDescription: json['jobDescription'] as String,
          skillset: List<String>.from(json['skillset'] as List),
          processTimeline: ProcessTimelineClass.fromJson(
              json['processTimeline'] as Map<String, Object?>),
          previouslyPlacedContacts: (json['previouslyPlacedContacts'] as Map)
              .entries
              .map((e) => PreviouslyPlacedContactDetailsClass(
                  name: e.value["name"],
                  rollNo: e.value["rollNo"],
                  email: e.value["email"],
                  phone: e.value["phone"],
                  linkedin: e.value["linkedin"]))
              // .fromJson(
              //     e.value as Map<String, Object?>))
              .toList(),
          experiences: (json['experiences'] as Map)
              .entries
              .map((e) =>
                  ExperienceTileClass.fromJson(e.value as Map<String, Object?>))
              .toList(),
          faqs: (json['faqs'] as Map)
              .entries
              .map((e) =>
                  FAQTilesClass.fromJson(e.value as Map<String, Object?>))
              .toList(),
          lastDate: json['lastDate'] as String,
          package: json['package'] as String,
          linkToApply: json['linkToApply'] as String,
          driveLink: json['driveLink'] as String,
          eligibility: json['eligibility'] as String,
          offerType: json['offerType'] as String,
        );

  final String id;
  final String companyName;
  final String companyType;
  final String roleName;
  final String roleType;
  final String aboutTheFirm;
  final String jobDescription;
  final List skillset;
  final ProcessTimelineClass processTimeline;
  final List<PreviouslyPlacedContactDetailsClass> previouslyPlacedContacts;
  final List<ExperienceTileClass> experiences;
  final List<FAQTilesClass> faqs;
  final String lastDate;
  final String package;
  final String linkToApply;
  final String driveLink;
  final String eligibility;
  final String offerType;

  Map<String, Object?> toJson() {
    Map<String, Map> previouslyPlacedContactsJson = {};
    Map<String, Map> experienceTilesInfoJson = {};
    Map<String, Map> faqsJson = {};

    for (PreviouslyPlacedContactDetailsClass contact
        in previouslyPlacedContacts) {
      previouslyPlacedContactsJson[contact.rollNo] = contact.toJson();
    }

    for (ExperienceTileClass experienceTile in experiences) {
      experienceTilesInfoJson[experienceTile.rollNo] = experienceTile.toJson();
    }

    for (FAQTilesClass faqTile in faqs) {
      faqsJson[faqTile.question] = faqTile.toJson();
    }

    return {
      'id': id,
      'companyName': companyName,
      'companyType': companyType,
      'roleName': roleName,
      'roleType': roleType,
      'aboutTheFirm': aboutTheFirm,
      'jobDescription': jobDescription,
      'skillset': skillset,
      'processTimeline': processTimeline.toJson(),
      'previouslyPlacedContacts': previouslyPlacedContactsJson,
      'experiences': experienceTilesInfoJson,
      'faqs': faqsJson,
      'lastDate': lastDate,
      'package': package,
      'linkToApply': linkToApply,
      'driveLink': driveLink,
      'eligibility': eligibility,
      'offerType': offerType,
    };
  }
}
