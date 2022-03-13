import 'package:flutter/material.dart';

import '../widgets/newsfeed_poll_widget.dart';
import '../widgets/newsfeed_post_widget.dart';

class NewsfeedScreen extends StatelessWidget {
  const NewsfeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: SizedBox(
              height: 40,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "T&P NewsFeed",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: const [
                NewsfeedPost(),
                NewsfeedPoll(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
