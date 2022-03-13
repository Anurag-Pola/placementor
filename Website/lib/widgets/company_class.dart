import '/widgets/experience_tile_class.dart';
import '/widgets/faq_tiles_class.dart';
import '/widgets/previosly_placed_contact_details_class.dart';

import './process_timeline_class.dart';

class Company {
  final String companyName;
  final String companyType;
  final String roleName;
  final String roleType;
  final String aboutTheFirm;
  final String jobDescription;
  final List<String> skillset;
  final ProcessTimelineClass processTimeline;
  final List<PreviouslyPlacedContactDetailsClass>
      previouslyPlacedContactDetails;
  final List<ExperienceTileClass> experienceTilesInfo;
  final List<FAQTilesClass> faqTilesInfo;
  final String lastDate;
  final String salary;
  final String linkToApply;
  final String driveLink;
  final String eligibility;

  const Company({
    required this.companyName,
    required this.companyType,
    required this.roleName,
    required this.roleType,
    required this.aboutTheFirm,
    required this.jobDescription,
    required this.skillset,
    required this.processTimeline,
    required this.previouslyPlacedContactDetails,
    required this.experienceTilesInfo,
    required this.faqTilesInfo,
    required this.lastDate,
    required this.salary,
    required this.linkToApply,
    required this.driveLink,
    required this.eligibility,
  });
}
