import 'package:flutter/material.dart';

import '../models/experience_tile_class.dart';
import '../models/faq_tiles_class.dart';
import '../models/previosly_placed_contact_details_class.dart';
import '../models/process_timeline_class.dart';
import '../models/company_class.dart';

class OnCampusCompanyTile extends StatelessWidget {
  final String id;
  final String companyName;
  final String companyType;
  final String roleName;
  final String roleType;
  final String aboutTheFirm;
  final String jobDescription;
  final List<String> skillset;
  final ProcessTimelineClass processTimeline;
  final List<PreviouslyPlacedContactDetailsClass> previouslyPlacedContacts;
  final List<ExperienceTileClass> experienceTilesInfo;
  final List<FAQTilesClass> faqs;
  final String lastDate;
  final double package;
  final String linkToApply;
  final String driveLink;
  final String eligibility;
  final String offerType;

  const OnCampusCompanyTile({
    Key? key,
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
    required this.experienceTilesInfo,
    required this.faqs,
    required this.lastDate,
    required this.package,
    required this.linkToApply,
    required this.driveLink,
    required this.eligibility,
    required this.offerType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          '/onCampusCompanyPage',
          arguments: Company(
            id: id,
            companyName: companyName,
            companyType: companyType,
            roleName: roleName,
            roleType: roleType,
            aboutTheFirm: aboutTheFirm,
            jobDescription: jobDescription,
            skillset: skillset,
            processTimeline: processTimeline,
            previouslyPlacedContacts: previouslyPlacedContacts,
            experiences: experienceTilesInfo,
            faqs: faqs,
            lastDate: lastDate,
            package: package,
            linkToApply: linkToApply,
            driveLink: driveLink,
            eligibility: eligibility,
            offerType: offerType,
          ),
        );
      },
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const FlutterLogo(size: 40),
                ),
                const SizedBox(width: 10),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      child: Text(
                        roleName,
                        style: const TextStyle(
                          color: Color(0xff18191e),
                          fontSize: 16,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Opacity(
                      opacity: 0.80,
                      child: Text(
                        companyName,
                        style: const TextStyle(
                          color: Color(0xff18191e),
                          fontSize: 12,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Chip(
                  name: roleType,
                ),
                Chip(
                  name: lastDate,
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SizedBox(
                    child: Text(
                      '$package LPA',
                      style: const TextStyle(
                        color: Color(0xff18191e),
                        fontSize: 12,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Color(0x3f000000),
              blurRadius: 4,
              offset: Offset(0, 4),
            ),
          ],
          color: Colors.white,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 15,
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 5,
        ),
      ),
    );
  }
}

class Chip extends StatelessWidget {
  final String name;

  const Chip({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: const Color(0xfff4f6fc),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      child: Opacity(
        opacity: 0.80,
        child: Text(
          name,
          textAlign: TextAlign.right,
          style: const TextStyle(
            color: Color(0xff18191e),
            fontSize: 12,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
