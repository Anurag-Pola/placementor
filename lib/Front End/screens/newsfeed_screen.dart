import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
                Bubble(),
                Poll(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Poll extends StatefulWidget {
  const Poll({Key? key}) : super(key: key);

  @override
  State<Poll> createState() => _PollState();
}

class _PollState extends State<Poll> {
  final List<bool> _isSelected = [false, false, false];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue.shade100,
      child: Column(
        children: [
          const SizedBox(height: 20),
          const Text(
            'Did you register for Wiley-mthree?',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              setState(() {
                if (_isSelected.contains(true)) {
                  for (int i = 0; i < _isSelected.length; i++) {
                    _isSelected[i] = false;
                  }
                }
                _isSelected[0] = !_isSelected[0];
              });
            },
            child: Container(
              width: 200,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(20),
                color: _isSelected[0] ? Colors.lightBlue : Colors.white,
              ),
              child: const Center(
                child: Text(
                  'Yes, Registered!',
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),
          GestureDetector(
            onTap: () {
              setState(() {
                if (_isSelected.contains(true)) {
                  for (int i = 0; i < _isSelected.length; i++) {
                    _isSelected[i] = false;
                  }
                }
                _isSelected[1] = !_isSelected[1];
              });
            },
            child: Container(
              width: 200,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(20),
                color: _isSelected[1] ? Colors.lightBlue : Colors.white,
              ),
              child: const Center(
                child: Text(
                  "I'll register now.",
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),
          GestureDetector(
            onTap: () {
              setState(() {
                if (_isSelected.contains(true)) {
                  for (int i = 0; i < _isSelected.length; i++) {
                    _isSelected[i] = false;
                  }
                }
                _isSelected[2] = !_isSelected[2];
              });
            },
            child: Container(
              width: 200,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(20),
                color: _isSelected[2] ? Colors.lightBlue : Colors.white,
              ),
              child: const Center(
                child: Text(
                  'No, I have other plans.',
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class Bubble extends StatelessWidget {
  const Bubble({Key? key}) : super(key: key);

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
