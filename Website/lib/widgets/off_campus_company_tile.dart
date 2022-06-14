import 'package:flutter/material.dart';

import '../models/company_class.dart';

class OffCampusCompanyTile extends StatelessWidget {
  final String id;
  final String companyName;
  final String roleName;
  final String jobDescription;
  final String linkToApply;

  const OffCampusCompanyTile({
    Key? key,
    required this.id,
    required this.companyName,
    required this.roleName,
    required this.jobDescription,
    required this.linkToApply,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/offCampusCompanyPage',
            arguments: Company.fromJson({
              "companyName": companyName,
              "roleName": roleName,
              "jobDescription": jobDescription,
              "linkToApply": linkToApply,
              "id": id,
              "offerType": "Off Campus",
            }));
      },
      child: Container(
        width: 115,
        height: (height * 0.18) - 30,
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
        padding: const EdgeInsets.only(
          left: 12,
          right: 12,
          top: 6,
          bottom: 12,
        ),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 5),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
              ),
              child: const FlutterLogo(size: 40),
            ),
            const SizedBox(height: 8),
            FittedBox(
              child: Text(
                roleName,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            Text(
              companyName,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: Color(0xff46484c),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
