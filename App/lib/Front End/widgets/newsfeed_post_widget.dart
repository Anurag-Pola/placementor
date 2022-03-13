import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsfeedPost extends StatelessWidget {
  const NewsfeedPost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(15),
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 15.0,
            offset: Offset(5, 5),
            color: Colors.black54,
          ),
        ],
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Dear Students,\n\nWe are delighted to kick start our Wiley-mthree Internship Recruitment Program for all Circuit branch students graduating in 2022.\n",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 5),
          GestureDetector(
            child: const Text(
              "Tap to register!",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () => launch("https://www.google.com/"),
          ),
        ],
      ),
    );
  }
}
