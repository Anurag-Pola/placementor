import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class OnCampusComapnyScreen extends StatelessWidget {
  const OnCampusComapnyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        actions: [
          IconButton(
            icon: const Icon(
              Icons.description_rounded,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Icons.insert_invitation_rounded,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      backgroundColor: const Color(0xFFF5F7FC),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            OnCampusHeading(),
            SizedBox(
              height: 20,
            ),
            // AboutTheFirm(),
          ],
        ),
      ),
    );
  }
}

class AboutTheFirm extends StatefulWidget {
  const AboutTheFirm({
    Key? key,
  }) : super(key: key);

  @override
  State<AboutTheFirm> createState() => _AboutTheFirmState();
}

class _AboutTheFirmState extends State<AboutTheFirm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: const ExpansionTile(
        title: Opacity(
          opacity: 0.75,
          child: Text(
            "ABOUT THE FIRM",
            style: TextStyle(
              color: Color(0xff18191e),
              fontSize: 11.50,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w700,
              letterSpacing: 0.75,
            ),
          ),
        ),
        subtitle: SizedBox(
          // width: 363,
          child: Text(
            "Can you bring creative human-centered ideas to life and make great things happen beyond what meets the eye?\nWe believe in teamwork, fun, complex projects, diverse perspectives, and simple solutions. How about you? We're looking for a like-minded",
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),
          ),
        ),
      ),

      // child: Column(
      //   mainAxisSize: MainAxisSize.min,
      //   mainAxisAlignment: MainAxisAlignment.start,
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     const
      //     const SizedBox(height: 12),
      //     const
      //     const SizedBox(height: 16),
      //     Row(
      //       mainAxisSize: MainAxisSize.min,
      //       mainAxisAlignment: MainAxisAlignment.start,
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       children: [
      //         const Text(
      //           "See more",
      //           style: TextStyle(
      //             color: Color(0xff1c58f2),
      //             fontSize: 13,
      //             fontFamily: "Poppins",
      //             fontWeight: FontWeight.w600,
      //           ),
      //         ),
      //         const SizedBox(width: 4),
      //         Container(
      //           width: 16,
      //           height: 16,
      //           decoration: BoxDecoration(
      //             borderRadius: BorderRadius.circular(8),
      //           ),
      //           child: const FlutterLogo(size: 16),
      //         ),
      //       ],
      //     ),
      //   ],
      // ),
    );
  }
}

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
