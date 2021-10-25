import 'package:flutter/material.dart';

class OnCampusHeading extends StatelessWidget {
  const OnCampusHeading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 8.0),
            child: FlutterLogo(size: 60),
          ),
          SizedBox(height: 16),
          Padding(
            padding: EdgeInsets.only(left: 25.0),
            child: Text(
              "Senior Product Designer",
              style: TextStyle(
                color: Color(0xff18191e),
                fontSize: 26,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 25.0, top: 5.0, bottom: 15.0),
            child: Opacity(
              opacity: 0.80,
              child: Text(
                "Google INC",
                style: TextStyle(
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
