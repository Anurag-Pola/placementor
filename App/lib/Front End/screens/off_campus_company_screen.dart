import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../models/company_class.dart';
import '../widgets/on_campus_heading.dart';

class OffCampusComapnyScreen extends StatelessWidget {
  const OffCampusComapnyScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Company company = ModalRoute.of(context)!.settings.arguments as Company;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: const Color(0xFFF5F7FC),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              OnCampusHeading(
                logo: 'opportunity',
                companyName: company.companyName,
                roleName: company.roleName,
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                color: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const Opacity(
                      opacity: 0.75,
                      child: Text(
                        'DESCRIPTION',
                        style: TextStyle(
                          color: Color(0xff18191e),
                          fontSize: 13,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.75,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SingleChildScrollView(child: Text(company.jobDescription)),
                    const SizedBox(height: 10),
                  ],
                ),
              )
            ],
          ),
          Positioned(
            bottom: 10,
            child: GestureDetector(
              onTap: () async {
                final url = company.linkToApply;
                if (await canLaunchUrlString(url)) {
                  await launchUrlString(url);
                }
              },
              child: Container(
                width: 215,
                height: 52,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x3f000000),
                      blurRadius: 4,
                      offset: Offset(0, 4),
                    ),
                  ],
                  gradient: const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Color(0xff925ffc), Color(0xff3b57ff)],
                  ),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                child: const Center(
                  child: Text(
                    "APPLY NOW",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
