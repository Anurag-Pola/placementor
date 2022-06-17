import 'package:flutter/material.dart';

class OnCampusHeading extends StatelessWidget {
  final String companyName;
  final String roleName;
  final String logo;

  const OnCampusHeading({
    Key? key,
    required this.logo,
    required this.companyName,
    required this.roleName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 8.0),
            child: Image.asset(
              'assets/images/$logo.png',
              scale: 1.5,
              height: 60,
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Text(
              roleName,
              style: const TextStyle(
                color: Color(0xff18191e),
                fontSize: 26,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0, top: 5.0, bottom: 15.0),
            child: Opacity(
              opacity: 0.80,
              child: Text(
                companyName,
                style: const TextStyle(
                  color: Color(0xff18191e),
                  fontSize: 14,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
