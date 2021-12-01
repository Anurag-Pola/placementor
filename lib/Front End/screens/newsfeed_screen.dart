import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsfeedScreen extends StatelessWidget {
  const NewsfeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      body: ListView(
        children: const [
          SizedBox(
            height: 20,
          ),
          Bubble(),
          Poll(),
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
      color: Colors.blueGrey.shade300,
      child: Column(
        children: [
          const SizedBox(height: 20),
          const Text(
            'What is your favorite color?',
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
                  'Red',
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
                  'Green',
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
                  'Blue',
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
            "Arpan is a very very very .........",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 5),
          GestureDetector(
            child: const Text(
              "Tap to know!",
              style: TextStyle(color: Colors.blue, fontSize: 16),
            ),
            onTap: () => launch(
                "https://vnrvjiet.acm.org/resources/img/coreteam(2020-21)/Arpan.jpg"),
          ),
        ],
      ),
    );
  }
}
