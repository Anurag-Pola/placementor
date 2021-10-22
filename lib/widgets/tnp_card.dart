import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TnPCard extends StatelessWidget {
  const TnPCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        boxShadow: const [
          BoxShadow(
            color: Color(0x3f000000),
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
        color: Colors.white,
      ),
      // padding: const EdgeInsets.symmetric(
      // horizontal: 5,
      // vertical: 4,
      // ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10, bottom: 5),
            height: 100,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset(
                'assets/images/tnp_coordinators_image.png',
                scale: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "Name",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xff252b42),
              fontFamily: "Montserrat",
              fontWeight: FontWeight.w700,
            ),
          ),
          // const SizedBox(height: 5),
          const Text(
            "Department",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xff252b42),
              fontFamily: "Montserrat",
              fontWeight: FontWeight.w700,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () async {
                  const url = 'tel:+91 9876543210';
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                },
                icon: const Icon(
                  Icons.call_outlined,
                  color: Color(0xFF46B35C),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.mail_outline_rounded,
                  color: Color(0xFF1B7AF3),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
